import 'package:coffee_meet_app/entities/Event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';


class EventLocalStorageManager {
  static const String _eventListkey = "EVENT_LIST";

  // To create event
  static Future<void> setEvent(Event event) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> eventList = await _getEventList();
    eventList.removeWhere((u) => u['id'] == event.eventId);
    eventList.add(event.toJSON());

    await localStorage.setString(_eventListkey, jsonEncode(eventList));

    // Debugging: Print the user list to verify
    print("Event list after saving: ${jsonEncode(eventList)}");
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
    eventList.removeWhere((u) => u['id'] == eventId);

    // Update the local storage
    localStorage.setString(_eventListkey, jsonEncode(eventList));
  }

  // Generate a new ID
  static Future<int> generateEventId() async {
    List<Map<String, dynamic>> eventList = await _getEventList();

    if (eventList.isEmpty) {
      return 1; // Start with ID 1 if no users exist
    }

    // Find the highest existing ID and add 1
    int maxId = eventList.map((u) => u['id'] as int).reduce((a, b) => a > b ? a : b);
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

}
