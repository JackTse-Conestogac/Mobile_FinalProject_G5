import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';


class UserLocalStorageManager{
    static const String _key = "USER";
    static const String _userListKey = "USER_LIST";


    // To create / update  a user
    static Future<void> setUser(User user) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      List<Map<String, dynamic>> userList = await _getUserList();
      userList.removeWhere((u) => u['id'] == user.id); // Remove any existing user with the same ID
      userList.add(user.toJSON());

      await localStorage.setString(_userListKey, jsonEncode(userList));

      // Debugging: Print the user list to verify
      print("User list after saving: ${jsonEncode(userList)}");
    }



    // To read all users
    static Future<List<User>> getUserList() async {
      List<Map<String, dynamic>> userList = await _getUserList();

      // Debugging: Print the retrieved user list
      print("Retrieved user list: ${jsonEncode(userList)}");

      return userList.map((userJson) => User.fromJSON(userJson)).toList();
    }



    // To delete a user by ID
    static Future<void> deleteUser(int userId) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> userList = await _getUserList();

      // Remove user with the given ID
      userList.removeWhere((u) => u['id'] == userId);

      // Update the local storage
      localStorage.setString(_userListKey, jsonEncode(userList));
    }


  // Generate a new ID
    static Future<int> generateId() async {
      List<Map<String, dynamic>> userList = await _getUserList();

      if (userList.isEmpty) {
        return 1; // Start with ID 1 if no users exist
      }

      // Find the highest existing ID and add 1
      int maxId = userList.map((u) => u['id'] as int).reduce((a, b) => a > b ? a : b);
      return maxId + 1;
    }

    // Private method to get the user list from local storage
    static Future<List<Map<String, dynamic>>> _getUserList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String? encodedJson = localStorage.getString(_userListKey);

      if (encodedJson == null) {
        return [];
      }

      List<dynamic> decodedJson = jsonDecode(encodedJson);
      return List<Map<String, dynamic>>.from(decodedJson);
    }


    // Clear All Users
    static Future<void> clearUserList() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.remove(_userListKey);
      print("User list cleared.");
    }

}
