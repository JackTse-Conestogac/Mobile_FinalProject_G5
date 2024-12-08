import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../managers/event_local_storage_manager.dart';
import '../managers/connection_local_storage_manager.dart';
import '../entities/event.dart';
import '../entities/User.dart';
import '../entities/connection.dart';



class EventManager {


  static Future<List<Event>> viewAllEvents() async {
    return await EventLocalStorageManager.getEventList();
  }


  Future<void> addEvent(Event event) async {
    try {
      int newId = await EventLocalStorageManager.generateEventId();
      event = Event(
        eventId: newId,
        hostId: event.hostId,
        eventName: event.eventName,
        startDate: event.startDate,
        description: event.description,
        eventLocationStatus: event.eventLocationStatus,
        isPublic: event.isPublic
      );

      await EventLocalStorageManager.setEvent(event);
      print("Event added successfully: ${event.toJSON()}");
    } catch (e) {
      print("Error in addEvent: $e");
      rethrow;
    }
  }



  Future<void> editUser(int eventId, Event updatedEvent) async {
    // Fetch all events
    List<Event> allEvents = await viewAllEvents();

    // Find and update the specific user
    for (int i = 0; i < allEvents.length; i++) {
      if (allEvents[i].eventId == eventId) {
        allEvents[i] = updatedEvent;
        break;
      }
    }

    // Save the updated event to local storage
    await EventLocalStorageManager.setEvent(updatedEvent);
  }


  // Delete a user by ID
  Future<void> deleteEvent(int eventId) async {
    await EventLocalStorageManager.deleteEvent(eventId);
  }


  // manager the selected event's date
  Future<String?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) {
      return null;
    }

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) {
      return null;
    }

    final DateTime fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return fullDateTime.toIso8601String();
  }


  //Put this in the ConnectionManager, but it might fit better under user or event.
  // If inverted it returns only the events WITHOUT the connection
  static Future<List<Event>> getEventsForUser(User user,
      {bool inverted = false}) async {

    List<EventConnection> eventConnectionList =
    await ConnectionLocalStorageManager.getEventConnectionList();

    List<Event> events = await EventManager.viewAllEvents();

    List<Event> userEvents = eventConnectionList
        .where((c1) => c1.userId == user.id)
        .map((c2) => events.firstWhere((e) => e.eventId == c2.eventId))
        .toList();

    if (!inverted) {
      return userEvents;
    } else {
      return events.where((e) => !userEvents.contains(e)).toList();
    }

  }

  Future<void> shareEventWithUsers(Event event, List<int> userIds) async {
    for (int userId in userIds) {
      EventConnection connection = EventConnection(
        connectionId: 0,
        eventId: event.eventId,
        userId: userId,
      );
      await ConnectionLocalStorageManager.setEventConnection(connection);
    }
  }
}


