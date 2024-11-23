import 'Event.dart';
import 'User.dart';

class TempEntities {
  static List<User> users = [
    User(name: "test1", email: "t1.t@t", phone: 11, occupation: "occu1"),
    User(name: "test2", email: "t2.t@t", phone: 22, occupation: "occu2"),
    User(name: "test3", email: "t3.t@t", phone: 33, occupation: "occu3"),
  ];

  static List<Event> events = [
    Event(eventName: "test1", startDate: DateTime(2021, 10, 1)),
    Event(eventName: "test2", startDate: DateTime(2022, 2, 2)),
  ];
}
