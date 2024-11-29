import 'User.dart';

class UserConnection{
    int connectionId;
    int primaryUserId;
    int foreignUserId;

    UserConnection({
      this.connectionId = 0,
      required this.primaryUserId,
      required this.foreignUserId,
    });

    Map<String, dynamic> toJSON() {
      return {
        'connectionId': connectionId,
        'primaryUserId': primaryUserId,
        'foreignUserId': foreignUserId,
      };
    }

    static UserConnection fromJSON(Map<String, dynamic> json) {
      return UserConnection(
        connectionId: json['connectionId'],
        primaryUserId: json['primaryUserId'],
        foreignUserId: json['foreignUserId'],
      );
    }
}

class EventConnection{
  int connectionId;
  int eventId;
  int userId;

  EventConnection({
     this.connectionId = 0,
    required this.eventId,
    required this.userId,
  });

  Map<String, dynamic> toJSON() {
    return {
      'connectionId': connectionId,
      'eventId': eventId,
      'userId': userId,
    };
  }

  static EventConnection fromJSON(Map<String, dynamic> json) {
    return EventConnection(
      connectionId: json['connectionId'],
      eventId: json['eventId'],
      userId: json['userId'],
    );
  }

}


