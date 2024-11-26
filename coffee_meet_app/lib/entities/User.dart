import 'Event.dart';

class User{
  String name;
  String email;
  int phone;
  String occupation;
  late List<Event> attendEvents;
  late List<User> contacts;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.occupation,
    List<Event>? attendEvents,
    List<User>? contacts,
  }){
    this.attendEvents = attendEvents ?? <Event>[];
    this.contacts = contacts ?? <User>[];
  }
}

