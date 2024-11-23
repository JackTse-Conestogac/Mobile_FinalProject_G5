import 'dart:ffi';
import 'Event.dart';

class User{
  String name;
  String email;
  Int phone;
  String occupation;
  List<Event> attendEvents = [];
  List<User> contacts = [];

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.occupation,
    this.attendEvents = const [],
    this.contacts = const [],
  });
}

