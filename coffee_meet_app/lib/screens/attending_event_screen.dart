import 'package:coffee_meet_app/entities/global_state.dart';
import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../entities/User.dart';
import '../listTiles/event_tile.dart';
import '../managers/connection_manager.dart';
import '../managers/event_manager.dart';

class AttendingEventScreen extends StatefulWidget {
  @override
  State<AttendingEventScreen> createState() => _AttendingEventScreenState();

  static const icon = Icons.watch_later;
  static const text = "Attending";
  final TabController tabController;
  const AttendingEventScreen(this.tabController, {super.key});
}

class _AttendingEventScreenState extends State<AttendingEventScreen> {
  late Future<List<Event>> _userEvents;

  @override
  void initState() {
    super.initState();
    _userEvents=EventManager.getEventsForUser(GlobalState().getCurrentUser());
  }

  void refreshEvents(){
    setState(() {
      _userEvents=EventManager.getEventsForUser(GlobalState().getCurrentUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Event>>(
        future: _userEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No events available."));
          } else {
            List<Event> events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventTile(events[index],widget.tabController,connected: true,);
              },
            );
          }
        },
      ),
    );
  }
}
