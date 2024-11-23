import 'package:flutter/material.dart';

class EventListView extends StatelessWidget{
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
            }));;
  }
  // It made sense to set the tabs stuff here
  static const icon = Icons.edit_calendar;
  static const text = "Events";
}