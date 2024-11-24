import 'package:coffee_meet_app/screens/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/screens/eventDetails.dart';
import '../entities/Event.dart';

class EventTile extends StatelessWidget {
  //EventTile(this.event);

  final Event event;

 const EventTile(this.event,{super.key});

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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EventDetailScreen(event: event),
                    ),
                );
                debugPrint("Details ${event.eventName}");
              },
              child: Text("Details"),
            ),
            FilledButton(
              onPressed: () {
                  Navigator.push(
                      context,
                       MaterialPageRoute(
                          builder: (context) =>  CreateEventScreen(),
                       ),
                  );
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
