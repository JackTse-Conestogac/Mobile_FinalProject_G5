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
}
