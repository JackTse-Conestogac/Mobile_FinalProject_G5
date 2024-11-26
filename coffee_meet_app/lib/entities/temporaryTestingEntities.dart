import 'Event.dart';
import 'User.dart';

class TempEntities {
  static List<User> users = [
    User(name: "test1", email: "t1.t@t", phone: 11, occupation: "occu1"),
    User(name: "test2", email: "t2.t@t", phone: 22, occupation: "occu2"),
    User(name: "test3", email: "t3.t@t", phone: 33, occupation: "occu3"),
  ];

  static List<Event> events = [
    Event(eventId: 0, eventName: "test1", startDate: DateTime(2021, 10, 1),description: "test1"),
    Event(eventId:1, eventName: "test2", startDate: DateTime(2022, 2, 2),description: "test2"),
    Event(eventId:2, eventName: "test3", startDate: DateTime(2023, 3, 3),description: "test3"),
    Event(eventId:3, eventName: "test4", startDate: DateTime(2024, 4, 4),description: "test4"),

  ];

  static User currentUser = User(name:"Prime",email: "prime@p.rime",phone: 100,occupation: "PrimeUser",);

  static bool init = false;
  static void Init(){
    if(init) return;
    init=true;
    currentUser.contacts.add(users[0]);
    currentUser.contacts.add(users[1]);
    currentUser.attendEvents.add(events[0]);
    currentUser.attendEvents.add(events[1]);
  }

}
