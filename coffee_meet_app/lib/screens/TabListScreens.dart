import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/screens/createProfile.dart';
import 'package:coffee_meet_app/screens/eventListView.dart';
import 'package:flutter/material.dart';

import 'attendingEventView.dart';
import 'contactListView.dart';

class TabListScreen extends StatefulWidget {
  const TabListScreen({super.key});
  @override
  State<TabListScreen> createState() => _TabListScreenState();
}

class _TabListScreenState extends State<TabListScreen> with SingleTickerProviderStateMixin{
  //I'll be honest, I barely understand this - Christopher
  //I'm fairly certain the with SingleTicker... lets the object
  // provide itself to TabController.vsync for to be used for animations
  // -- Reading further "mixin"s seem to be Interfaces with non-abstract methods
  // Which Java has had for ages, and didn't feel the need to give a stupid name
  late final _tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(TempEntities.currentUser.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(ContactListView.icon),
              text: ContactListView.text,
            ),
            Tab(
              icon:Icon(AttendingEventView.icon),
              text: AttendingEventView.text,
            ),
            Tab(
              icon:Icon(EventListView.icon),
              text: EventListView.text,
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
        ContactListView(),
        AttendingEventView(),
        EventListView(_tabController),
      ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateProfileScreen(),
                ),
            );
      },
        child: const Icon(Icons.add),
      ),
    );
  }
}
