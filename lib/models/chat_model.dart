import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String senderEmail;
  final String imageUrl;
  final Timestamp time;
  final String senderId;

  ChatModel({
    required this.message,
    required this.senderEmail,
    required this.imageUrl,
    required this.time,
    required this.senderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'senderEmail': senderEmail,
      'imageUrl': imageUrl,
      'time': time.millisecondsSinceEpoch,
      'senderId': senderId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      message: map['message'] as String,
      senderEmail: map['senderEmail'] as String,
      imageUrl: map['imageUrl'] as String,
      time: Timestamp.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
