import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:coffee_meet_app/managers/event_manager.dart';
import 'package:flutter/material.dart';

import '../entities/Event.dart';
import '../listTiles/eventTile.dart';

class EventListView extends StatefulWidget {
  @override
  State<EventListView> createState() => _EventListViewState();

  static const icon = Icons.edit_calendar;
  static const text = "Events";

  const EventListView({super.key});
}

class _EventListViewState extends State<EventListView> {
  late Future<List<Event>> _events = EventManager.viewAllEvents();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(EventListView.text),
      ),
      body: FutureBuilder<List<Event>>(
        future: _events,
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
