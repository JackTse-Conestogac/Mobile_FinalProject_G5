import 'package:flutter/material.dart';
import '../listTiles/contactTile.dart';

class ContactListView extends StatelessWidget {
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
              return ContactTile();
            }));
  }

  // It made sense to set the tabs stuff here
  static const icon = Icons.contacts;
  static const text = "Contacts";
}
