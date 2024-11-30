import 'package:coffee_meet_app/entities/Connection.dart';
import 'package:coffee_meet_app/entities/GlobalState.dart';
import 'package:flutter/material.dart';
import '../entities/User.dart';
import '../screens/contactProfileView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../managers/connection_manager.dart';


class ContactTile extends StatefulWidget {
  ContactTile(this.user,{this.connected=false});
  ContactTile.wController(this.user, this._tabController,{this.connected=false}){
    //print("TileUser = ${user.id}");
  }
  TabController? _tabController;
  Function? refreshList;
  bool connected;
  User user;


  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  //bool isAdded = false;
  late String emailUrl;
  late UserConnection userConnection;
  late ConnectionManager _connectionManager;

  @override
  void initState() {
    super.initState();
    emailUrl = widget.user.email;
  }

  void addUserConnection(){
    setState(() {

      ConnectionManager.connectUser(GlobalState().getCurrentUser(), widget.user);
    });
    widget._tabController?.index=0;
  }

  void removeUserConnection(){
    setState(() {
      ConnectionManager.DisconnectUserFrom(GlobalState().getCurrentUser(), widget.user);
    });
    widget._tabController?.index=1;
  }

  void _toggleAddConnectionButton() {
    setState(() {
      //isAdded = !isAdded;

      //userConnection = new UserConnection(primaryUserId: primaryUserId, foreignUserId: widget.user.id); // Missing current account user id, needs a global state for it.

      // if(isAdded){
      //   _connectionManager.connectUser(userConnection);
      //   print("User connected");
      // }
      // else{
      //   _connectionManager.disconnectUser(userConnection.connectionId);
      //   print("User disconnected");
      // }

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
              width: 118,
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
              width: 118,
              height: 20,
              child: !widget.connected ? FilledButton(
                onPressed: addUserConnection,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green // Default color
                ),
                child: Text(
                  "Add",
                  style: const TextStyle(color: Colors.white),
                ),
              ) : FilledButton(
                onPressed: removeUserConnection,
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.red // Default color
                ),
                child: Text(
                  "Remove",
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
