import '../entities/User.dart';
import '../managers/user_local_storage_manager.dart';


class UserManager{
  List<User> users;
  int currentUserId;

  UserManager({
    this.users = const [],
    required this.currentUserId
  });


  static Future<List<User>> viewAllUsers() async {
    List<Map<String, dynamic>> usersData = await UserLocalStorageManager.getUserList();
    print("Fetched Users Data: $usersData"); // Debugging

    List<User> users = usersData.map((data) => User.fromJSON(data)).toList();
    print("Parsed Users: ${users.map((u) => u.name).toList()}"); // Debugging
    return users;
  }


  void AddUser(){

  }

  void EditUser(){

  }

  void DeleteUser(){

  }

  void CheckLogIn(){

  }
}
