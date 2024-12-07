import 'package:coffee_meet_app/managers/event_manager.dart';
import 'package:coffee_meet_app/managers/user_manager.dart';

import '../entities/User.dart';
import '../entities/connection.dart';
import '../entities/event.dart';
import '../managers/connection_local_storage_manager.dart';

class ConnectionManager {
  static Future<void> connectUser(User primary,User secondary) async {

    int newId = await ConnectionLocalStorageManager.generatUserConectionId();

    var userConnect = UserConnection(
        connectionId: newId,
        primaryUserId: primary.id,
        foreignUserId: secondary.id
    );
    await ConnectionLocalStorageManager.setUserConnection(userConnect);
  }

  static Future<void> disconnectUser(int userConnectionId) async {
    await ConnectionLocalStorageManager.deleteUserConnection(userConnectionId);
  }

  static Future<void> DisconnectUserFrom(User primary, User secondary) async {
    List<UserConnection> connections = await ConnectionLocalStorageManager.getUserConnectionList();
    disconnectUser(connections.firstWhere((c)=>c.primaryUserId==primary.id && c.foreignUserId==secondary.id).connectionId);
  }

  //Put this in the ConnectionManager, but it might fit better under user.
  // If inverted it returns only the events WITHOUT the connection
  static Future<List<User>> getContactsForUser(User user,
      {bool inverted = false}) async {
    List<UserConnection> userConnectionList =
        await ConnectionLocalStorageManager.getUserConnectionList();
    List<User> users = await UserManager.viewAllUsers();
    List<User> userConnections = userConnectionList
        .where((c1) => c1.primaryUserId == user.id)
        .map((c2) => users.firstWhere((u) => u.id == c2.foreignUserId))
        .toList();
    if (!inverted) {
      return userConnections;
    } else {
      return users.where((e) => !userConnections.contains(e)).toList();
    }
  }

  static Future<void> connectEvent(User user, Event event) async {
    int newId = await ConnectionLocalStorageManager.generatEventConectionId();
    var eventConnect = EventConnection(
        connectionId: newId,
        eventId: event.eventId,
        userId: user.id);
    await ConnectionLocalStorageManager.setEventConnection(eventConnect);
  }

  static Future<void> disconnectEvent(int eventConnectionId) async {
    print("Disconnecting");
    await ConnectionLocalStorageManager.deleteEventConnection(
        eventConnectionId);
  }

  static Future<void> disconnectUserFromEvent(User user, Event event) async {

    List<EventConnection> connections = await ConnectionLocalStorageManager.getEventConnectionList();
    //print("TEST ${connections.firstWhere((c)=>c.userId==user.id && c.eventId==event.eventId).connectionId}");
    disconnectEvent(connections.firstWhere((c)=>c.userId==user.id && c.eventId==event.eventId).connectionId);
  }
}
