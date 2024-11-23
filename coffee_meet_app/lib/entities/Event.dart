import 'User.dart';

class Event {
  int eventId;
  String eventName;
  DateTime startDate;
  List<User> attendance;

  Event({
    required this.eventId,
    required this.eventName,
    required this.startDate,
    this.attendance = const []
  });
}
