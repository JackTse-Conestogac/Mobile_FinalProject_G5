import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget{
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _linkdeinController = TextEditingController();

  bool _isSaved = false;
  bool _showSocialMediaIcon = false;
  bool _isAvailable = false;

  String? _isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaved = true;
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create profile'),
      ),
      body: Form(
        key: _formKey,
      child:ListView(
        padding: EdgeInsets.all(16),
        children: [
          const Text(
            'Name:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8,),
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
              return null;
            },
          ),
          const Text(
            'Phone:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              hintText: 'Optional',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const Text(
            'Email:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Required',
              border: OutlineInputBorder(),
            ),
            validator: _isValidEmail,
          ),
          const Text(
            'Occupation:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8,
          ),
          TextFormField(
            controller: _occupationController,
            decoration: const InputDecoration(
              hintText: 'Required',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Occupation is required';
              }
              return null;
            },
          ),
          const Text(
            'LinkdeIn:',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8,
          ),
          TextFormField(
            controller: _linkdeinController,
            decoration: const InputDecoration(
              hintText: 'Optional',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 8,),
          CheckboxListTile(
              title: const Text(
                'Show Social Media Icon', style: TextStyle(fontSize: 25),),
              value: _showSocialMediaIcon,
              onChanged: (value) {
                setState(() {
                  _showSocialMediaIcon = value ?? false;
                });
              }
          ),
          CheckboxListTile(
              title: const Text('Available?', style: TextStyle(fontSize: 25),),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value ?? false;
                });
              }
          ),
          const SizedBox(height: 16,),
          Center(
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 30)
              ),
              child: const Text('Save'),
            ),
          ),
          if(_isSaved)
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text('Profile has been saved successfully!',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
        ],
      ),
      ),
    );
  }
}