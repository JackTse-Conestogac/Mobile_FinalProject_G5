import 'package:coffee_meet_app/entities/Event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entities/User.dart';


class EventLocalStorageManager{
  static const String _key = "EVENT";

  // To create event
  static Future<void> setEvent(Event event) async {
    // 1. convert User into json
    Map<String,dynamic> json = event.toJSON();

    // 2. stringify this json
    String encodedJson = jsonEncode(json);

    // 3. store a key in local storage for that product with stringified JSON
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(EventLocalStorageManager._key, encodedJson);
  }

  // To read event
  static Future<Event?> getEvent()async{
    SharedPreferences localStorge= await SharedPreferences.getInstance();
    String? encodedJson = localStorge.getString(EventLocalStorageManager._key);

    if (encodedJson == null) {
      return null;
    }

    //convert that JSON into a real object
    Map<String, dynamic> decodeJson = jsonDecode(encodedJson);

    return Event.fromJSON(decodeJson);
  }


  // To delete a event
  static Future<User?> deleteEvent() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove(EventLocalStorageManager._key);
  }

}