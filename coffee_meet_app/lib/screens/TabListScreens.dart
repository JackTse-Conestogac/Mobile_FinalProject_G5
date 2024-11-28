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

class _TabListScreenState extends State<TabListScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.user.name} UserID: ${widget.user.id}"),
            bottom: const TabBar(
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
          body: TabBarView(children: [
            ContactListView(),
            AttendingEventView(),
            EventListView(),
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
