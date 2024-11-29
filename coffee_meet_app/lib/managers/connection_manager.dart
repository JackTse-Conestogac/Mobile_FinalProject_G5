import '../entities/User.dart';
import '../entities/Connection.dart';
import '../entities/Event.dart';
import '../managers/connection_local_storage_manager.dart';


class ConnectionManager{

   Future<void> connectUser(UserConnection userConnect) async{

      int newId = await ConnectionLocalStorageManager.generatUserConectionId();
      userConnect = UserConnection (
         connectionId: newId,
          primaryUserId: userConnect.primaryUserId,
          foreignUserId: userConnect.foreignUserId
      );
      await ConnectionLocalStorageManager.setUserConnection(userConnect);
   }

   Future<void> disconnectUser(int userConnectionId) async{
         await ConnectionLocalStorageManager.deleteUserConnection(userConnectionId);
   }


   Future<void> connectEvent(EventConnection eventConnect) async {
      int newId = await ConnectionLocalStorageManager.generatEventConectionId();
      eventConnect = EventConnection (
          connectionId: newId,
          eventId: eventConnect.eventId,
          userId: eventConnect.userId
      );
      await ConnectionLocalStorageManager.setEventConnection(eventConnect);
   }

   Future<void> disconnectEvent(int eventConnectionId) async{
      await ConnectionLocalStorageManager.deleteEventConnection(eventConnectionId);
   }

}