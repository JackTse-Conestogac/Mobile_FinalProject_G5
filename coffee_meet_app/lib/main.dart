import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/screens/TabListScreens.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
} // Returns the MaterialApp

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TempEntities.Init();
    return const MaterialApp(
      home: TabListScreen(),
    );
  }
}

