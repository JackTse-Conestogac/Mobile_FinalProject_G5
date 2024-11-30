import 'package:coffee_meet_app/managers/event_manager.dart';

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

   //Put this in the ConnectionManager, but it might fit better under user or event.
   // If inverted it returns only the events WITHOUT the connection
   Future<List<Event>> getEventsForUser(User user, {bool inverted=false}) async {
      List<EventConnection> eventConnectionList = await ConnectionLocalStorageManager.getEventConnectionList();
      List<Event> events = await EventManager.viewAllEvents();
      List<Event> userEvents = eventConnectionList.where((c1)=>c1.userId==user.id).map((c2)=>events.firstWhere((e)=>e.eventId==c2.eventId)).toList();
      if(!inverted){
         return userEvents;
      }else{
         return events.where((e)=>!userEvents.contains(e)).toList();
      }
   }

}