import 'Event.dart';

class User{
  int id;
  String name;
  String email;
  int phone;
  String occupation;
  List<Event> attendEvents = [];
  List<User> contacts = [];

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.occupation,
    this.attendEvents = const [],
    this.contacts = const [],
  });

  // toJSON method - convert a Product object into JSON
  Map<String,dynamic> toJSON(){
    return {"id":this.id,
      "name":this.name,
      "email":this.email,
      "phone":this.phone,
      "occupation":this.occupation,
      "addendEvents":this.attendEvents,
      "contacts": this.contacts,
    };
  }
  // fromJSON method - convert JSON into a Product object
  User.fromJSON(Map<String, dynamic> json):
        this.id = json["id"],
        this.name = json["name"],
        this.email = json["email"],
        this.phone = json["phone"],
        this.occupation = json["occupation"],
        this.attendEvents = json["attendEvents"],
        this.contacts = json["contacts"];
}

