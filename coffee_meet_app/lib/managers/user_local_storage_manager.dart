import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';


class UserLocalStorageManager{
    static const String _key = "USER";
    static const String _userListKey = "USER_LIST";


    // To create / update  a user
  static Future<void> setUser(User user) async {
    // 1. convert User into json
    //Map<String,dynamic> json = user.toJSON();


    // 2. stringify this json
    //String encodedJson = jsonEncode(json);

    // 3. store a key in local storage for that product with stringified JSON
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //localStorage.setString(UserLocalStorageManager._key, encodedJson);

    // add/update the user in the user list
    List<Map<String, dynamic>> userList = await _getUserList();
    userList.removeWhere((u) => u['id'] == user.id); // Remove any existing user with the same ID
    userList.add(user.toJSON());
    localStorage.setString(_userListKey, jsonEncode(userList));
  }


  // To read a user
  static Future<User?> getUser()async{
    SharedPreferences localStorge= await SharedPreferences.getInstance();
    String? encodedJson = localStorge.getString(UserLocalStorageManager._key);

    if (encodedJson == null) {
      return null;
    }

    //convert that JSON into a real object
    Map<String, dynamic> decodeJson = jsonDecode(encodedJson);

    return User.fromJSON(decodeJson);
  }


  // To delete a user
  static Future<User?> deleteUser() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove(UserLocalStorageManager._key);
  }


  // Generate New ID
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

    static Future<List<Map<String, dynamic>>> getUserList() async {

      return _getUserList();
    }
}