import 'package:flutter/material.dart';

class RegistrationWidget extends StatelessWidget {
  const RegistrationWidget({
    super.key,
    required this.onTap,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.61),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 255, 248, 248),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}
