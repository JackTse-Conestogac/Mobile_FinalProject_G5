import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../managers/event_local_storage_manager.dart';
import '../entities/Event.dart';


class EventManager {


  static Future<List<Event>> viewAllEvents() async {
    return await EventLocalStorageManager.getEventList();
  }


  Future<void> addEvent(Event event) async {
    int newId = await EventLocalStorageManager.generateEventId();
    event = Event(
      eventId: newId,
      hostId: event.hostId,
      eventName: event.eventName,
      startDate: event.startDate,
      description: event.description,
      eventLocationStatus:  event.eventLocationStatus,
    );
    await EventLocalStorageManager.setEvent(event);
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

    return "${fullDateTime.toIso8601String().split('T')[0]} ${selectedTime.format(context)}";
  }
}


