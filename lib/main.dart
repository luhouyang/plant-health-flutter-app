import 'package:flutter/material.dart';
import 'package:plant_health_data/pages/route_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Health Collection',
      theme: ThemeData(
        fontFamily: 'RobotoCondensed',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const RoutePage(),
    );
  }
}
