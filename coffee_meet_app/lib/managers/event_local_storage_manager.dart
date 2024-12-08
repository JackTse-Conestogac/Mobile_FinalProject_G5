import 'package:coffee_meet_app/entities/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';
import 'package:flutter/services.dart';


class EventLocalStorageManager {
  static const String _eventListkey = "EVENT_LIST";

  // initialize data from JSON file
  static Future<void> initializeTestEvents() async {
    final SharedPreferences event_prefs = await SharedPreferences.getInstance();

    if (!event_prefs.containsKey(_eventListkey)) {
      try {
        final String jsonString = await rootBundle.loadString('assets/event_data.json');
        final List<dynamic> jsonData = jsonDecode(jsonString);

        final List<Map<String, dynamic>> eventList = jsonData.map((item) => Map<String, dynamic>.from(item)).toList();

        await event_prefs.setString(_eventListkey, jsonEncode(eventList));
      } catch (e) {
        print('Error loading event data from JSON: $e');
      }
    }
  }

  // To create event
  static Future<void> setEvent(Event event) async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> eventList = await _getEventList();

      // Update or add the event
      eventList.removeWhere((e) => e['eventId'] == event.eventId);
      eventList.add(event.toJSON());

      await localStorage.setString(_eventListkey, jsonEncode(eventList));
      print("Event list after saving: ${jsonEncode(eventList)}");
    } catch (e) {
      print("Error in setEvent: $e");
      rethrow;
    }
  }


  // To read all events
  static Future<List<Event>> getEventList() async {

    List<Map<String, dynamic>> eventList = await _getEventList();

    // Debugging: Print the retrieved user list
    print("Retrieved event list: ${jsonEncode(eventList)}");

    return eventList.map((eventJson) => Event.fromJSON(eventJson)).toList();
  }

  // To delete a event by ID
  static Future<void> deleteEvent(int eventId) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> eventList = await _getEventList();

    // Remove user with the given ID
    eventList.removeWhere((u) => u['eventId'] == eventId);

    // Update the local storage
    localStorage.setString(_eventListkey, jsonEncode(eventList));
  }

  // Generate a new ID
  static Future<int> generateEventId() async {
    List<Map<String, dynamic>> eventList = await _getEventList();
print("print generate Id${eventList}");
    if (eventList.isEmpty) {
      return 1; // Start with ID 1 if no users exist
    }

    // Find the highest existing ID and add 1
    int maxId = eventList.map((u) => u['eventId'] as int).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }


  // Private method to get the event list from local storage
  static Future<List<Map<String, dynamic>>> _getEventList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? encodedJson = localStorage.getString(_eventListkey);

    if (encodedJson == null) {
      return [];
    }

    List<dynamic> decodedJson = jsonDecode(encodedJson);
    return List<Map<String, dynamic>>.from(decodedJson);
  }

  // Clear All Events
  static Future<void> clearEventList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove(_eventListkey);
    print("Event list cleared.");
  }

}
