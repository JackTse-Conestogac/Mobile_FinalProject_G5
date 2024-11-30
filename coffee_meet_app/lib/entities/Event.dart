import 'package:coffee_meet_app/entities/GlobalState.dart';

import 'User.dart';
import '../enum/event_location.dart';

class Event {
  int eventId;
  int hostId;
  String eventName;
  String startDate;
  String description;
  EventLocation eventLocationStatus ;


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
    return {"eventId":this.eventId,
      "hostId": this.hostId,
      "eventName":this.eventName,
      "startDate":this.startDate,
      "description": this.description,
      "eventLocation": this.eventLocationStatus.name,
    };
  }

  // fromJSON method - convert JSON into a Product object
  Event.fromJSON(Map<String, dynamic> json):
        this.eventId = json["eventId"],
        this.hostId = json["hostId"],
        this.eventName = json["eventName"],
        this.startDate = json["startDate"],
        this.description = json["description"],
        this.eventLocationStatus = EventLocation.values.firstWhere(
  (e) => e.name == json["eventLocation"], // Deserialize string to enum
  orElse: () => EventLocation.indoor,);
}