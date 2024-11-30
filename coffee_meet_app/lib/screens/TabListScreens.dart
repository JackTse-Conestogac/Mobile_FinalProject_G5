import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:coffee_meet_app/screens/createUser.dart';
import 'package:coffee_meet_app/screens/eventListView.dart';
import 'package:coffee_meet_app/screens/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/entities/User.dart';

import 'attendingEventView.dart';
import 'contactListView.dart';
import 'package:coffee_meet_app/managers/user_manager.dart';

class TabListScreen extends StatefulWidget {
  final User user;
  const TabListScreen({super.key, required this.user});


  @override
  State<TabListScreen> createState() => _TabListScreenState();
}

class _TabListScreenState extends State<TabListScreen> with SingleTickerProviderStateMixin{
  //I'll be honest, I barely understand this - Christopher
  //I'm fairly certain the with SingleTicker... lets the object
  // provide itself to TabController.vsync for to be used for animations
  // -- Reading further "mixin"s seem to be Interfaces with default implementation
  // Which Java has had for ages, and didn't feel the need to give a stupid name
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.user.name} UserID: ${widget.user.id}"),
            bottom:  TabBar(
              controller: _tabController,
              tabs: [
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
            EventListView(user:widget.user),
          ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const CreateEventScreen(),
                    ),
                );
          },
            child: const Icon(Icons.add),
          ),
        ),
    );
  }
}
