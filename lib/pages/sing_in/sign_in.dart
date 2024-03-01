import 'package:flutter/material.dart';
import 'package:kat_chat/pages/sign_up/sign_up.dart';
import '../../widgets/sign_up_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

String userText = '';

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome Back!",
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
              Text("Don't have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: Text(
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
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
