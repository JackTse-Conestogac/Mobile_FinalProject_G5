import 'package:flutter/material.dart';
import '../entities/User.dart';
import '../screens/contactProfileView.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactTile extends StatefulWidget {
  ContactTile(this.user);

  User user;

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool isAdded = false;
  late String emailUrl;


  @override
  void initState() {
    super.initState();
    emailUrl = widget.user.email;
  }

  void _toggleAddConnectionButton() {
    setState(() {
      isAdded = !isAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(widget.user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.user.occupation),
              IconButton(
                onPressed: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: emailUrl,
                  );
                    await launchUrl(emailUri);
                },
                icon: Icon(Icons.mail),
              ),
              //Text("Contact"),
              // IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     debugPrint("Delete ${widget.user.name}");
              //   },
              // ),
            ],
          ),
        ],
      ),
      trailing: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: 100,
              height: 20,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactProfileView(user: widget.user),
                    ),
                  );
                },
                child: Text("View"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: 100,
              height: 20,
              child: FilledButton(
                onPressed: _toggleAddConnectionButton,
                style: FilledButton.styleFrom(
                  backgroundColor: isAdded
                      ? Colors.green
                      : Theme.of(context).primaryColor, // Default color
                ),
                child: Text(
                  isAdded ? "Added" : "Add",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
