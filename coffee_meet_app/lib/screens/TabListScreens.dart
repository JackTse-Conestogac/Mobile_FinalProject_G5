import 'package:coffee_meet_app/screens/eventListView.dart';
import 'package:flutter/material.dart';

import 'attendingEventView.dart';
import 'contactListView.dart';

class TabListScreen extends StatefulWidget {
  const TabListScreen({super.key});
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
            title: Text("TEMPNAME"),
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
          ]),
        ));
  }
}
