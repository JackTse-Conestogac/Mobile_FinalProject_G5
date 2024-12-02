import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:flutter/material.dart';
import '../entities/global_state.dart';
import '../listTiles/contact_tile.dart';
import '../entities/User.dart';
import '../managers/connection_manager.dart';
import 'create_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListScreen extends StatefulWidget {
  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
  ContactListScreen(this.tabController,{super.key});
  final TabController tabController;
  static const icon = Icons.contacts;
  static const text = "Contacts";
}

class _ContactListScreenState extends State<ContactListScreen> {
  late Future<List<User>> _users; // Define Future<List<User>> to fetch data

  @override
  void initState() {
    super.initState();
    _users = ConnectionManager.getContactsForUser(GlobalState().getCurrentUser()); // Initialize the Future

  }
  void _fetchUsers() {
    setState(() {
      _users = ConnectionManager.getContactsForUser(GlobalState().getCurrentUser()); // Re-fetch the user list
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
                return ContactTile.wController(users[index],widget.tabController,connected: true,);
              },
            );
          }
        },
      ),
    );
  }
}
