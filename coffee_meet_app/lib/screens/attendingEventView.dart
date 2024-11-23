import 'package:flutter/material.dart';

class AttendingEventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(text),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile();
            }));
  }

  // It made sense to set the tabs stuff here
  static const icon = Icons.watch_later;
  static const text = "Attending";
}
