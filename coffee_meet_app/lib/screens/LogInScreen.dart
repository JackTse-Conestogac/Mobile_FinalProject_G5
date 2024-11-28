import 'package:flutter/material.dart';
import 'package:coffee_meet_app/screens/createUser.dart';
import 'package:coffee_meet_app/screens/TabListScreens.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();

  static const icon = Icons.edit_calendar;
  static const text = "LOG IN";
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  //Temp data for checking
  // String _name = "Jack";
  // String _password = "123";

  // bool checkUserName(String name){
  //   return name == _name;
  // }
  // bool checkPassword(String password){
  //   return password == _password;
  // }


  void UserAuthorization(String name, String password){

    // Check user logic here:


    //if(checkUserName(name) && checkPassword(password)){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TabListScreen(),
        ),
      );
    //}


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
                  'Name:',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Required',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    // else if(value != _name){
                    //   return "No user found";
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password:',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Required',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true, // For password fields
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // else if(value != _password){
                    //   return 'Invalid password';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //  login logic here
                          UserAuthorization(_nameController.text, _passwordController.text);


                        }
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Space before the link
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Sign-Up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateUserScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Don’t have an account? Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        //decoration: TextDecoration.underline,
                      ),
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
