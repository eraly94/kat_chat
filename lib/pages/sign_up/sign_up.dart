import 'package:flutter/material.dart';
import 'package:kat_chat/pages/chat/chat.dart';
import 'package:kat_chat/pages/sing_in/sign_in.dart';
import '../../widgets/sign_up_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

String userText = '';

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Let's Get Started!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SignUpWidget(
            labelText: 'Name',
            onChanged: (name) {
              userText = name;
            },
            labelIcon: Icons.person,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpWidget(
            labelText: 'Email',
            onChanged: (email) {
              userText = email;
            },
            labelIcon: Icons.email,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpWidget(
            labelText: 'Password',
            onChanged: (password) {
              userText = password;
            },
            labelIcon: Icons.password,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: Text(
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
              child: Text(
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
