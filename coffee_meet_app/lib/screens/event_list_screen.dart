import 'package:coffee_meet_app/managers/connection_manager.dart';
import 'package:coffee_meet_app/managers/event_manager.dart';
import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../entities/User.dart';
import '../listTiles/event_tile.dart';
import '../entities/global_state.dart';

class EventListView extends StatefulWidget {
  @override
  State<EventListView> createState() => _EventListViewState();

  static const icon = Icons.edit_calendar;
  static const text = "Events";
  final TabController tabController;

  const EventListView(this.tabController, {super.key,});
}

class _EventListViewState extends State<EventListView> {
  //not to signify that it is inverted
  late Future<List<Event>> _UserNOTevents;

  void _fetchEvents(){
    User currentUser = GlobalState().getCurrentUser();
    _UserNOTevents= EventManager.getEventsForUser(currentUser, inverted: true);

  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  // void refreshEvents(){
  //   setState(() {
  //     _UserNOTevents = EventManager.getEventsForUser(widget.user, inverted: true);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return EventTile(events[index],widget.tabController,);
              },
            );
          }
        },
      ),
    );
  }
}
