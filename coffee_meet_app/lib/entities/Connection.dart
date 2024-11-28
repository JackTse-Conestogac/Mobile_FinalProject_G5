import 'User.dart';

class UserConnection{
    int? connectionId;
    int? primaryUserId;
    int? foreignUserId;
    bool isConnected = false;

    UserConnection({
      required this.connectionId,
      required this.primaryUserId,
      required this.foreignUserId,
      required this.isConnected
    });
}

class EventConnection{
  int? connectionId;
  int? eventId;
  int? userId;

  EventConnection({
    required this.connectionId,
    required this.eventId,
    required this.userId,
  });
}
