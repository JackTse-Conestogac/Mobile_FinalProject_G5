import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:coffee_meet_app/screens/create_user_screen.dart';
import 'package:coffee_meet_app/screens/event_list_screen.dart';
import 'package:coffee_meet_app/screens/create_event_screen.dart';
import 'package:coffee_meet_app/screens/stranger_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/entities/User.dart';
import 'package:coffee_meet_app/screens/blog_api_screen.dart';

import 'attending_event_screen.dart';
import 'contact_list_screen.dart';
import 'map_screen.dart';

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
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlogApiScreen(),
        ),
      );
    } else if(index==2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome back, ${widget.user.name}!"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(ContactListScreen.icon),
              text: ContactListScreen.text,
            ),
            Tab(
              icon: Icon(StrangerListView.icon),
              text: StrangerListView.text,
            ),
            Tab(
              icon: Icon(AttendingEventScreen.icon),
              text: AttendingEventScreen.text,
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
          ContactListScreen(_tabController),
          StrangerListView(_tabController),
          AttendingEventScreen(_tabController),
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
          BottomNavigationBarItem(
            icon:Icon(Icons.map),
            label:'Map',
          )
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
