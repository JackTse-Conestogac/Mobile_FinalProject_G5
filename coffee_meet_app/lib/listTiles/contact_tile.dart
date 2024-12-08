import 'package:coffee_meet_app/entities/connection.dart';
import 'package:coffee_meet_app/entities/global_state.dart';
import 'package:flutter/material.dart';
import '../entities/User.dart';
import '../screens/contact_profile_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person, size: 40),
      title: Text(widget.user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.user.occupation),
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: emailUrl,
              );
              await launchUrl(emailUri);
            },
            icon: Icon(Icons.mail, size: 30),
          ),
          // View Icon
          IconButton(
            icon: Icon(Icons.visibility, size: 30, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactProfileScreen(user: widget.user),
                ),
              );
            },
          ),
          // Add/Remove Icon
          IconButton(
            icon: Icon(
              widget.connected ? Icons.remove : Icons.add,
              size: 30,
              color: widget.connected ? Colors.red : Colors.green,
            ),
            onPressed: widget.connected ? removeUserConnection : addUserConnection,
          ),
        ],
      ),
    );
  }
}
