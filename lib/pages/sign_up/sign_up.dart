import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kat_chat/pages/chat/chat.dart';
import 'package:kat_chat/pages/sing_in/sign_in.dart';
import '../../widgets/sign_up_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

String? userName, email, password;
Future<void> addUser() async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!,
    password: password!,
  );
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
                addUser();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Chat()));
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
