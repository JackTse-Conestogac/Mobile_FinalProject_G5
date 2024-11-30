import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/managers/connection_manager.dart';
import 'package:coffee_meet_app/managers/event_manager.dart';
import 'package:flutter/material.dart';

import '../entities/Event.dart';
import '../entities/User.dart';
import '../listTiles/eventTile.dart';

class EventListView extends StatefulWidget {
  @override
  State<EventListView> createState() => _EventListViewState();

  static const icon = Icons.edit_calendar;
  static const text = "Events";
  final User user;

  const EventListView({super.key, required this.user});
}

class _EventListViewState extends State<EventListView> {
  //not to signify that it is inverted
  late Future<List<Event>> _UserNOTevents;

  @override
  void initState() {
    super.initState();
    _UserNOTevents=ConnectionManager.getEventsForUser(widget.user, inverted: true);
  }

  void refreshEvents(){
    setState(() {
      _UserNOTevents=ConnectionManager.getEventsForUser(widget.user, inverted: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(EventListView.text),
      ),
      body: FutureBuilder<List<Event>>(
        future: _UserNOTevents,
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
                return EventTile(events[index]);
              },
            );
          }
        },
      ),
    );
  }
}
