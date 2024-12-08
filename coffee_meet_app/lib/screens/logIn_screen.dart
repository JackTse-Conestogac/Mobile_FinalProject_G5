import 'package:coffee_meet_app/entities/global_state.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/screens/create_user_screen.dart';
import 'package:coffee_meet_app/screens/tab_List_screen.dart';
import 'package:coffee_meet_app/managers/user_manager.dart';
import 'package:coffee_meet_app/managers/user_local_storage_manager.dart';
import 'package:coffee_meet_app/managers/connection_local_storage_manager.dart';
import 'package:coffee_meet_app/entities/User.dart';

import '../managers/event_local_storage_manager.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();

  static const icon = Icons.edit_calendar;
  static const text = "LOG IN";
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserManager _userManager = UserManager();
  GlobalState _globalState = GlobalState();
  String? _emailError;
  String? _passwordError;


  void _navigateToCreateUserScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateUserScreen()),
    );

    if (result == true) {
      // Display a success message (or refresh the UI if necessary)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User created successfully! Please log in.")),
      );
    }
  }

  Future<void> _clearAllUsers() async {
    _emailError = null;
    _passwordError = null;
    await UserLocalStorageManager.clearUserList();
    await ConnectionLocalStorageManager.clearUserConnectionList();
    await ConnectionLocalStorageManager.clearEventConnectionList();
    print("All users have been deleted.");
  }

  Future<void> _clearAllEvents() async {
    _emailError = null;
    _passwordError = null;
    await EventLocalStorageManager.clearEventList();
    await ConnectionLocalStorageManager.clearEventConnectionList();
    print("All events have been deleted.");
  }

  // User Authoraization
  Future<void> _userAuthorization() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
        return;
      });

    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
        return;
      });

    }

    bool emailExists = await _userManager.checkEmail(_emailController.text);
    if (!emailExists) {
      setState(() {
        _emailError = 'No user found with this email';
        return;
      });

    }

    bool passwordValid = await _userManager.checkPassword(_passwordController.text);
    if (!passwordValid) {
      setState(() {
        _passwordError = 'Invalid password';
        return;
      });

    }

    User loggedInUser = await _userManager.fetchUser(
      _emailController.text,
      _passwordController.text,
    );

    // Set current user in global state
    if (loggedInUser != null) {
      _globalState.setCurrentUser(loggedInUser);
    }

    // If both validations pass, navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TabListScreen(user: _globalState.getCurrentUser()), // Pass the User object
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LogInScreen.text),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Required',
                    border: const OutlineInputBorder(),
                    errorText: _emailError, // Display email error message here
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password:',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Required',
                    border: const OutlineInputBorder(),
                    errorText: _passwordError, // Display password error message here
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true, // For password fields
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _userAuthorization, // Use the new validation function
                      child: const Text('Log In'),
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Space before the link
                Center(
                  child: GestureDetector(
                    onTap: () => _navigateToCreateUserScreen(context),
                    child: const Text(
                      'Don’t have an account? Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _clearAllUsers,
                      child: const Text('Clear All Users'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _clearAllEvents,
                      child: const Text('Clear All Events'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
