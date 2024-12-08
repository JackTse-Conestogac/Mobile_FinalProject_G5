import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'User.dart';

class GlobalState{
  static final GlobalState _instance = GlobalState.interal();
  late User _currentUser;
  late LatLng _location;

GlobalState.interal(){
    _currentUser = User(id: 0, name: "name", password: "password", email: "email", phone: 123, occupation: "occupation");
    _location = LatLng(0, 0);
  }

  factory GlobalState(){

    return _instance;
  }

  User setCurrentUser(User user){
    return _currentUser = user;
  }

  User getCurrentUser(){
    return _currentUser;
  }

  void setLocation(LatLng location){
    _location = location;
  }
  LatLng getLocation(){
   return _location;
  }

}