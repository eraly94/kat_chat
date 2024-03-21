import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kat_chat/models/user_model.dart';
import 'package:kat_chat/pages/chat/chat.dart';
import 'package:kat_chat/pages/sing_in/sign_in.dart';
import '../../widgets/sign_up_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

Future<void> createUser(
    BuildContext context, UserCredential userCredential) async {
  final usermodel =
      UserModel(name: userName, email: email, id: userCredential.user!.uid);
  users.doc(userCredential.user!.uid).set(usermodel.toMap()).then((_) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Chat(userModelData: usermodel)));
  });
}

String? userName, email, password;

final users = FirebaseFirestore.instance.collection('users');
Future<void> addUser(BuildContext context) async {
  try {
    final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );

    createUser(
      context,
      userCredential,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      log('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Let's Get Started!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SignUpWidget(
            labelText: 'Name',
            onChanged: (userText) {
              userName = userText;
            },
            labelIcon: Icons.person,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpWidget(
            labelText: 'Email',
            onChanged: (userText) {
              email = userText;
            },
            labelIcon: Icons.email,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpWidget(
            labelText: 'Password',
            onChanged: (userText) {
              password = userText;
            },
            labelIcon: Icons.password,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton(
              onPressed: () {
                addUser(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Chat()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                "CREATE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
