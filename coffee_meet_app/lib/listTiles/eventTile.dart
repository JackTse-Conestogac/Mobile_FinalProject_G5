import 'package:coffee_meet_app/entities/GlobalState.dart';
import 'package:coffee_meet_app/screens/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/screens/eventDetails.dart';
import '../entities/Event.dart';
import '../managers/connection_manager.dart';

class EventTile extends StatefulWidget {
  //EventTile(this.event);

  final Event event;
  final TabController tabController;
  bool connected;
  EventTile(this.event, this.tabController, {this.connected=false, super.key});

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {

  void addEventConnection(){
    setState(() {
      ConnectionManager.connectEvent(GlobalState().getCurrentUser(), widget.event);
    });
    widget.tabController.index=2;
  }

  void removeEventConnection(){
    setState(() {
      ConnectionManager.disconnectUserFromEvent(GlobalState().getCurrentUser(), widget.event);
    });
    widget.tabController.index=3;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [
          Text(widget.event.eventName),
          Icon(Icons.image),
        ]),
        Column(
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailScreen(event: widget.event),
                  ),
                );
                debugPrint("Details ${widget.event.eventName}");
              },
              child: Text("Details"),
            ),IconButton(
              icon: Icon(
                widget.connected ? Icons.remove : Icons.add,
                size: 30,
                color: widget.connected ? Colors.red : Colors.green,
              ),
              onPressed: widget.connected ? removeEventConnection : addEventConnection,
            ),
            IconButton(
              onPressed: () {
                debugPrint("Delete ${widget.event.eventName}");
              },
              icon: Icon(Icons.delete),
            )
          ],
        )
      ]),
    );
  }
}
