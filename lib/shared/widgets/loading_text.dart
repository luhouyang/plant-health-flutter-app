import 'dart:async';
import 'package:flutter/material.dart';

class LoadingTextWidget extends StatefulWidget {
  const LoadingTextWidget({super.key});

  @override
  LoadingTextWidgetState createState() => LoadingTextWidgetState();
}

class LoadingTextWidgetState extends State {
  // set colours
  final List _colors = [
    const Color.fromARGB(255, 120, 255, 142),
    const Color.fromARGB(255, 48, 255, 93),
    const Color.fromARGB(255, 20, 255, 51),
    const Color.fromARGB(255, 0, 255, 60),
  ];

  // track colour
  int _currentColorIndex = 0;

  // set text message
  final List _mssg = ["Loading      ", "Loading .    ", "Loading . .  ", "Loading . . ."];

  // track text message
  int _currentTextMssg = 0;

  // animation timing
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start the timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
        _currentTextMssg = (_currentTextMssg + 1) % _mssg.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        _mssg[_currentTextMssg],
        style: TextStyle(color: _colors[_currentColorIndex], fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
