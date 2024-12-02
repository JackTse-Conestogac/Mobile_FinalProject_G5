import 'package:coffee_meet_app/entities/Connection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';


class ConnectionLocalStorageManager {
    static const String _userConnectionKey = "USER_CONNECTION_LIST";
    static const String _eventConnectionKey = "EVENT_CONNECTION_LIST";


    /// User Connection
    static Future<void> setUserConnection(UserConnection userConnection) async{
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      List<Map<String, dynamic>> userConnectionList = await _getUserConnectionList();
      userConnectionList.removeWhere((u) => u['connectionId'] == userConnection.connectionId);
      userConnectionList.add(userConnection.toJSON());

      await localStorage.setString(_userConnectionKey, jsonEncode(userConnectionList));
    }

    static Future<void> deleteUserConnection(int connectionId) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> userList = await _getUserConnectionList();

      // Remove user connection with the given ID
      userList.removeWhere((u) => u['connectionId'] == connectionId);

      // Update the local storage
      localStorage.setString(_userConnectionKey, jsonEncode(userList));
    }


    // Generate a new ID
    static Future<int> generatUserConectionId() async {
      List<Map<String, dynamic>> userList = await _getUserConnectionList();

      if (userList.isEmpty) {
        return 1; // Start with ID 1 if no user connection exist
      }

      // Find the highest existing ID and add 1
      int maxId = userList.map((u) => u['connectionId'] as int).reduce((a, b) => a > b ? a : b);
      print("Generating ID ${maxId+1}");
      return maxId + 1;
    }

    // Private method to get the user list from local storage
    static Future<List<Map<String, dynamic>>> _getUserConnectionList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String? encodedJson = localStorage.getString(_userConnectionKey);

      if (encodedJson == null) {
        return [];
      }
      List<dynamic> decodedJson = jsonDecode(encodedJson);
      return List<Map<String, dynamic>>.from(decodedJson);
    }

    static Future<void> clearUserConnectionList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.remove(_userConnectionKey);
      print("User Connection list cleared.");
    }

    static Future<List<UserConnection>> getUserConnectionList() async{
      List<Map<String, dynamic>> userList = await _getUserConnectionList();
      print("retrieved userConnections ${jsonEncode(userList)}");
      return userList.map((userConnectionJson) => UserConnection.fromJSON(userConnectionJson)).toList();
    }


    /// Event Connection

    static Future<void> setEventConnection(EventConnection eventConnection) async{
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      List<Map<String, dynamic>> eventConnectionList = await _getEventConnectionList();
      eventConnectionList.removeWhere((u) => u['connectionId'] == eventConnection.connectionId);
      eventConnectionList.add(eventConnection.toJSON());

      await localStorage.setString(_eventConnectionKey, jsonEncode(eventConnectionList));
    }

    static Future<void> deleteEventConnection(int connectionId) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> eventConnectionList = await _getEventConnectionList();
      print("Removing EventConnection: ${connectionId}");
      // Remove connection with the given ID
      eventConnectionList.removeWhere((u) => u['connectionId'] == connectionId);

      // Update the local storage
      localStorage.setString(_eventConnectionKey, jsonEncode(eventConnectionList));
    }


    // Generate a new ID
    static Future<int> generatEventConectionId() async {
      List<Map<String, dynamic>> userList = await _getEventConnectionList();

      if (userList.isEmpty) {
        return 1; // Start with ID 1 if no users exist
      }

      // Find the highest existing ID and add 1
      int maxId = userList.map((u) => u['connectionId'] as int).reduce((a, b) => a > b ? a : b);
      return maxId + 1;
    }

    // Private method to get the user list from local storage
    static Future<List<Map<String, dynamic>>> _getEventConnectionList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String? encodedJson = localStorage.getString(_eventConnectionKey);

      if (encodedJson == null) {
        return [];
      }

      List<dynamic> decodedJson = jsonDecode(encodedJson);
      return List<Map<String, dynamic>>.from(decodedJson);
    }

    static Future<void> clearEventConnectionList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.remove(_eventConnectionKey);
      print("Event Connection list cleared.");
    }

    static Future<List<EventConnection>> getEventConnectionList() async{
      List<Map<String, dynamic>> eventConnectionList = await _getEventConnectionList();
      return eventConnectionList.map((eventConnectionJson) => EventConnection.fromJSON(eventConnectionJson)).toList();
    }

}