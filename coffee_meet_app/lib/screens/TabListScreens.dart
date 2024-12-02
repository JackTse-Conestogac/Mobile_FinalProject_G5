import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:coffee_meet_app/screens/createUser.dart';
import 'package:coffee_meet_app/screens/eventListView.dart';
import 'package:coffee_meet_app/screens/createEvent.dart';
import 'package:coffee_meet_app/screens/strangerListView.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/entities/User.dart';
import 'package:coffee_meet_app/screens/blog_api_screen.dart';

import 'attendingEventView.dart';
import 'contactListView.dart';

class TabListScreen extends StatefulWidget {
  final User user;
  const TabListScreen({super.key, required this.user});

  @override
  State<TabListScreen> createState() => _TabListScreenState();
}

class _TabListScreenState extends State<TabListScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlogApiScreen(),
        ),
      );
    } else {

      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name} UserID: ${widget.user.id}"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(ContactListView.icon),
              text: ContactListView.text,
            ),
            Tab(
              icon: Icon(StrangerListView.icon),
              text: StrangerListView.text,
            ),
            Tab(
              icon: Icon(AttendingEventView.icon),
              text: AttendingEventView.text,
            ),
            Tab(
              icon: Icon(EventListView.icon),
              text: EventListView.text,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ContactListView(_tabController),
          StrangerListView(_tabController),
          AttendingEventView(_tabController),
          EventListView(_tabController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEventScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
