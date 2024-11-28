import 'package:coffee_meet_app/screens/TabListScreens.dart';
import 'package:coffee_meet_app/screens/LogInScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
} // Returns the MaterialApp

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogInScreen(),
    );
  }
}

