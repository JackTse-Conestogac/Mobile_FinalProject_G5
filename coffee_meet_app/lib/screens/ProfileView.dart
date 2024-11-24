import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:flutter/material.dart';


class ContactListView extends StatefulWidget {
  // Properties
  static const String titleText = "Profile";

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(ContactListView.titleText),
        ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network('https://picsum.photos/250?image=9'),
            Text("occupation (temp)"),
            Text("Email: (temp)"),
            Text("Status (temp)"),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.facebook),
                ),
              ],
            )
          ],
        ));
  }
}
