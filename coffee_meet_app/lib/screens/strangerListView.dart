import 'package:coffee_meet_app/entities/GlobalState.dart';
import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/managers/connection_manager.dart';
import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:flutter/material.dart';
import '../listTiles/contactTile.dart';
import '../entities/User.dart';
import 'createUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StrangerListView extends StatefulWidget {
  @override
  State<StrangerListView> createState() => _StrangerListViewState();

  static const icon = Icons.person;
  static const text = "Other Users";
  final TabController tabController;
  StrangerListView (this.tabController, {super.key});
}

class _StrangerListViewState extends State<StrangerListView> {
  late Future<List<User>> _users; // Define Future<List<User>> to fetch data

  @override
  void initState() {
    super.initState();
    _users = ConnectionManager.getContactsForUser(GlobalState().getCurrentUser(), inverted: true); // Initialize the Future

  }
  void _fetchUsers() {
    setState(() {
      _users = ConnectionManager.getContactsForUser(GlobalState().getCurrentUser(), inverted: true); // Re-fetch the user list
    });
  }

  void _navigateToAddUserScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUserScreen()),
    );

    if (result == true) {
      _fetchUsers(); // Refresh the user list if a user was added
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: _users, // Use the Future here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // Show error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No contacts available.")); // Handle empty state
          } else {
            List<User> users = snapshot.data!; // Extract the user list
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ContactTile.wController(users[index],widget.tabController);
              },
            );
          }
        },
      ),
    );
  }
}
