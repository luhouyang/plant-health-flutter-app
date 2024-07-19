import 'package:flutter/material.dart';

class MyH1 extends StatelessWidget {
  final String text;
  const MyH1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
    );
  }
}
