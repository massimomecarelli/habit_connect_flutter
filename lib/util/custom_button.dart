import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.lightBlue
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}