import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpWidget extends StatelessWidget {
  String labelText;
  Function(String)? onChanged;
  final IconData labelIcon;

  SignUpWidget({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.labelIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(labelIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
