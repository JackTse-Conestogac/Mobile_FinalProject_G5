import 'package:flutter/material.dart';

import '../entities/temporaryTestingEntities.dart';
import '../listTiles/eventTile.dart';

class AttendingEventView extends StatelessWidget {
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
  static const icon = Icons.watch_later;
  static const text = "Attending";
}
