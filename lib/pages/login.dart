import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kat_chat/pages/sign_up/sign_up.dart';
import 'package:kat_chat/pages/sing_in/sign_in.dart';
import '../widgets/registration_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          colors: [
            Colors.yellow,
            Colors.red,
            Colors.indigo,
            Colors.teal,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 20.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('KAT CHAT',
                      textStyle: GoogleFonts.getFont(
                        'Raleway',
                        textStyle: const TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(255, 236, 246, 237),
                            fontWeight: FontWeight.bold),
                      )),
                ],
                isRepeatingAnimation: true,
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RegistrationWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              text: 'Sign In',
            ),
            const SizedBox(
              height: 20,
            ),
            RegistrationWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
