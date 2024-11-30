import 'package:coffee_meet_app/entities/GlobalState.dart';

import 'User.dart';
import '../enum/event_location.dart';

class Event {
  int eventId;
  int hostId = GlobalState().getCurrentUser().id;
  String eventName;
  DateTime startDate;
  String description;
  EventLocation eventLocationStatus = EventLocation.indoor;


  Event({
    required this.eventId,
    required this.hostId,
    required this.eventName,
    required this.startDate,
    required this.description,
    required this.eventLocationStatus,
  });

  // toJSON method - convert a Product object into JSON
  Map<String,dynamic> toJSON(){
    return {"id":this.eventId,
      "hostId": this.hostId,
      "evenName":this.eventName,
      "startDate":this.startDate,
      "description": this.description,
      "eventLocation": this.eventLocationStatus,
    };
  }

  // fromJSON method - convert JSON into a Product object
  Event.fromJSON(Map<String, dynamic> json):
        this.eventId = json["eventId"],
        this.hostId = json["hostId"],
        this.eventName = json["eventName"],
        this.startDate = json["startDate"],
        this.description = json["description"],
        this.eventLocationStatus = json["eventLocationStatus"];

}
