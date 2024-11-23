import 'package:flutter/material.dart';

import '../entities/Event.dart';

class EventTile extends StatelessWidget {
  EventTile(this.event);

  Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [
          Text(event.eventName),
          Icon(Icons.image),
        ]),
        Column(
          children: [
            FilledButton(
              onPressed: () {
                debugPrint("Details ${event.eventName}");
              },
              child: Text("Details"),
            ),
            FilledButton(
              onPressed: () {
                debugPrint("Add ${event.eventName}");
              },
              child: Text("Add"),
            ),
            IconButton(
              onPressed: () {
                debugPrint("Delete ${event.eventName}");
              },
              icon: Icon(Icons.delete),
            )
          ],
        )
      ]),
    );
  }
}
