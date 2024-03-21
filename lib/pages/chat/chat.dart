import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kat_chat/models/chat_model.dart';
import 'package:kat_chat/models/user_model.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.userModelData}) : super(key: key);
  final UserModel userModelData;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  final chats = FirebaseFirestore.instance.collection('chats');
  ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final usersCollection = FirebaseFirestore.instance.collection('users');
  bool isGallery = false;
  Future<void> _pickImageGallery() async {
    // setState(() {
    //   isGallery = true;
    // });
    final image = await _picker.pickImage(
      source: isGallery == true ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 95,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  final chatCollection = FirebaseFirestore.instance.collection('chats');
  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    final String? imageUrl =
        _imageFile != null ? await uploadImageToStorage(_imageFile!) : null;
    if (messageText.isNotEmpty || imageUrl!.isNotEmpty) {
      final chatModel = ChatModel(
        imageUrl: imageUrl ?? '',
        message: messageController.text,
        senderEmail: widget.userModelData.email,
        time: Timestamp.now(),
        senderId: widget.userModelData.id,
      );
      try {
        await chatCollection.add(chatModel.toMap());
        messageController.clear();
        setState(() {
          _imageFile = null;
        });
      } catch (e) {
        throw (e);
      }

      chatCollection
          .doc(widget.userModelData.id)
          .set(chatModel.toMap())
          .then((_) {
        log('Chat koshuldu');
      }).catchError((error) => log("Failed to add user: $error"));
    }
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    final storage = FirebaseStorage.instance;
    final imageFileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final storageRef = storage.ref().child('images').child(imageFileName);
    final uploadTask = await storageRef.putFile(File(imageFile.path));
    return await uploadTask.ref.getDownloadURL();
  }

  Widget getMessageData() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatCollection
          .orderBy('time') // Order by timestamp
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No messages");
        }

        final messages = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final messageData = messages[index].data() as Map<String, dynamic>;
            // final messageText = messageData['message'] as String;
            // final senderId = messageData['senderId'] as String;
            final chatModel = ChatModel.fromMap(messageData);
            // Add logic to display messages based on sender (isMe)
            // bool isMe = senderId == widget.userModel.id;
            bool isMe = chatModel.senderId == widget.userModelData.id;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isMe ? Colors.tealAccent : Colors.grey[200],
              ),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      chatModel.message,
                      style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: 16),
                    ),
                    getUserData(),
                    // Text(

                    //   style: TextStyle(
                    //       color: isMe ? Colors.white : Colors.black,
                    //       fontSize: 16),
                    // ),
                  ],
                ),
                leading: chatModel.imageUrl.isNotEmpty
                    ? Image.network(chatModel.imageUrl)
                    : const SizedBox(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getUserData(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getMessageData(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Write your message',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _pickImageGallery();
                      setState(() {
                        isGallery = true;
                      });
                    },
                    icon: const Icon(Icons.attach_file),
                  ),
                  IconButton(
                    onPressed: () {
                      _pickImageGallery();
                      setState(() {
                        isGallery = false;
                      });
                    },
                    icon: const Icon(Icons.camera),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget getUserData() {
    return FutureBuilder<DocumentSnapshot>(
      future: usersCollection.doc(widget.userModelData.id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final userModel = UserModel.fromMap(data);
          return Text("${userModel.name}");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
