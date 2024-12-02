import 'package:coffee_meet_app/screens/tab_List_screen.dart';
import 'package:coffee_meet_app/screens/logIn_screen.dart';
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

