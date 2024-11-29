import 'User.dart';

class UserConnection{
    int connectionId;
    int primaryUserId;
    int foreignUserId;

    UserConnection({
      required this.connectionId,
      required this.primaryUserId,
      required this.foreignUserId,
    });
}

class EventConnection{
  int connectionId;
  int eventId;
  int userId;

  EventConnection({
    required this.connectionId,
    required this.eventId,
    required this.userId,
  });
}
