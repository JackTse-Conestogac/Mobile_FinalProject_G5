import '../entities/User.dart';
import '../managers/user_local_storage_manager.dart';

class UserManager {
  //  User currentUser;
  //
  // UserManager({
  //  required this.currentUser
  // });

  // Fetch all users from local storage
  static Future<List<User>> viewAllUsers() async {
    List<User> userList = await UserLocalStorageManager.getUserList();
    return userList;
  }

  // CHANGE: Fetch user by email and password
  Future<User> fetchUser(String email, String password) async {
    List<User> allUsers = await viewAllUsers();

    // Find the user with the matching email and password
    return allUsers.firstWhere(
          (user) =>
      user.email.toLowerCase() == email.toLowerCase() &&
          user.password == password,
    );
  }



  // Add a new user
  Future<void> addUser(User user) async {

    // Check if email already exist
    bool emailExists = await checkEmail(user.email);
    if (emailExists) {
      throw Exception("Email already in use");
    }

    int newId = await UserLocalStorageManager.generateId();
    user = User(
      id: newId,
      name: user.name,
      password: user.password,
      email: user.email,
      phone: user.phone,
      occupation: user.occupation,
      facebookUrl: user.facebookUrl ?? '',
      linkedInUrl: user.linkedInUrl ?? '',
      showSocialMedia: user.showSocialMedia,
      isAvailable: user.isAvailable,
    );

    await UserLocalStorageManager.setUser(user);
  }

  // Edit an existing user
  Future<void> editUser(int userId, User updatedUser) async {
    // Fetch all users
    List<User> allUsers = await viewAllUsers();

    // Find and update the specific user
    for (int i = 0; i < allUsers.length; i++) {
      if (allUsers[i].id == userId) {
        allUsers[i] = updatedUser;
        break;
      }
    }

    // Save the updated user to local storage
    await UserLocalStorageManager.setUser(updatedUser);
  }

  // Delete a user by ID
  Future<void> deleteUser(int userId) async {
    await UserLocalStorageManager.deleteUser(userId);
  }


   // Check Email
  Future<bool>checkEmail(String email) async{
    List<User> allUsers = await viewAllUsers();

    for (final user in allUsers) {
      if (user.email.toLowerCase() == email.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  // Check Password
  Future<bool>checkPassword(String password) async{
    List<User> allUsers = await viewAllUsers();

    for (final user in allUsers) {
      if (user.password.toLowerCase() == password.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

}
