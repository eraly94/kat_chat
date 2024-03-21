import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kat_chat/models/user_model.dart';
import 'package:kat_chat/pages/chat/chat.dart';
import 'package:kat_chat/pages/sign_up/sign_up.dart';
import '../../widgets/sign_up_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email, password;

//  Future <void> signIn() async {
//   try {

//   }
//     {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email!,
//         password: password!,
//       );
//       log("user: $credential");
//       final chats = FirebaseFirestore.instance.collection('chats');
//       final usermodel =
//           UserModel(name: "", email: email!, id: credential.user!.uid);
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Chat(
//                 userModelData: usermodel,
//               )));
//     }
//   }

  Future<void> signIn() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email!,
        name: userCredential.user!.displayName!,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chat(
                    userModelData: userModel,
                  )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code != e.email) {
        log('Email not found');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome Back!",
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
            labelText: 'Email',
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            labelIcon: Icons.email,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpWidget(
            labelText: 'Password',
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            labelIcon: Icons.password,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    "Sign Up",
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
                signIn();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                "SING IN",
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
