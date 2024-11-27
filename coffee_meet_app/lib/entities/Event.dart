import 'User.dart';

class Event {
  int eventId;
  String eventName;
  DateTime startDate;
  String description;
  List<User> attendance;

  Event({
    required this.eventId,
    required this.eventName,
    required this.startDate,
    required this.description,
    this.attendance = const []
  });

  // toJSON method - convert a Product object into JSON
  Map<String,dynamic> toJSON(){
    return {"id":this.eventId,
      "evenName":this.eventName,
      "startDate":this.startDate,
      "description": this.description,
      "attendance":this.attendance,
    };
  }
  // fromJSON method - convert JSON into a Product object
  Event.fromJSON(Map<String, dynamic> json):
        this.eventId = json["eventId"],
        this.eventName = json["eventName"],
        this.startDate = json["startDate"],
        this.description = json["description"],
        this.attendance = json["attendance"];
}
