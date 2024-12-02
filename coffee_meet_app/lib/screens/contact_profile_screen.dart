import 'package:flutter/material.dart';
import '../entities/User.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProfileScreen extends StatefulWidget {
  // Properties
  final User user;
  const ContactProfileScreen({Key? key, required this.user}) : super(key: key);

  static const String titleText = "Profile";

  @override
  State<ContactProfileScreen> createState() => _ContactProfileScreenState();
}

class _ContactProfileScreenState extends State<ContactProfileScreen> {

  // lanuchUrl for social media
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
      await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user; // Access the passed user object

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("${user.name} "+ContactProfileScreen.titleText),
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
                    _launchUrl(user.facebookUrl);
                  },
                  icon: Icon(Icons.facebook),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                    _launchUrl(user.linkedInUrl);
                  },
                  icon: Icon(Icons.link),
                ),
                IconButton(
                  onPressed: () {
                    // Link for Social Media
                    _launchUrl("mailto:${user.email}");
                  },
                  icon: Icon(Icons.email),
                ),
              ],
            )
          ],
        ));
  }
}
