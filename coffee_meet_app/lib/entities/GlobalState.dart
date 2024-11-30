import 'User.dart';

class GlobalState{
  static final GlobalState _instance = GlobalState.interal();
  late User _currentUser;

GlobalState.interal(){
    _currentUser = User(id: 0, name: "name", password: "password", email: "email", phone: 123, occupation: "occupation");
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
}