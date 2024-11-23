import 'User.dart';

class Event {
  String eventName;
  DateTime startDate;
  List<User> attendance;

  Event({
    required this.eventName,
    required this.startDate,
    this.attendance = const []
  });
}
