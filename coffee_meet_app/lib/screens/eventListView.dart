import 'package:coffee_meet_app/entities/temporaryTestingEntities.dart';
import 'package:flutter/material.dart';

import '../listTiles/eventTile.dart';

class EventListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(text),
        ),
        body: ListView.builder(
          itemCount: TempEntities.events.length,
          itemBuilder: (context, index) {
            return EventTile(TempEntities.events[index]);
          },
        ));
  }

  // It made sense to set the tabs stuff here
  static const icon = Icons.edit_calendar;
  static const text = "Events";
}
