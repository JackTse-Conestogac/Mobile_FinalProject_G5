import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:flutter/material.dart';
import '../entities/User.dart';

class ContactProfileView extends StatefulWidget {
  // Properties
  final User user;
  const ContactProfileView({Key? key, required this.user}) : super(key: key);

  static const String titleText = "Profile";

  @override
  State<ContactProfileView> createState() => _ContactProfileViewState();
}

class _ContactProfileViewState extends State<ContactProfileView> {

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Access the passed user object

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("${user.name} "+ContactProfileView.titleText),
        ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network('https://picsum.photos/250?image=9'),
            Text("occupation: ${user.occupation}"),
            Text("Email: ${user.email}"),
            Text("Phone: ${user.phone}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  icon: Icon(Icons.link),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                  },
                  icon: Icon(Icons.email),
                ),
              ],
            )
          ],
        ));
  }
}
