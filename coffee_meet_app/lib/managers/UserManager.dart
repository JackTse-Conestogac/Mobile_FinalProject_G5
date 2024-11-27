import '../entities/User.dart';
import '../managers/user_local_storage_manager.dart';

class UserManager{
  List<User> users;

  UserManager({
   this.users = const []
  });


  Future<User?> ViewUsersDetail(){
        return UserLocalStorageManager.getUser();
  }

  void AddUser(){

  }

  void EditUser(){

  }

  void DeleteUser(){

  }
}
