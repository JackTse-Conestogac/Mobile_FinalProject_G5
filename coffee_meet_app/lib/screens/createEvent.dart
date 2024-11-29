import 'package:flutter/cupertino.dart';
import 'package:coffee_meet_app/listTiles/eventTile.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/managers/event_manager.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final EventManager _eventManager = EventManager();


  String _selectedOption ='';

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            const Text(
              'Title:',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter the event title',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null ||value.isEmpty){
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8,),
            const Text('Address:',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Event address',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null ||value.isEmpty){
                  return 'Address is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8,),
            const Text('Date:',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: 'Select a date',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async{
                    String? selectedDateTime = await _eventManager.selectDateTime(context);

                    if(selectedDateTime != null){
                      setState(() {
                        _dateController.text = selectedDateTime;
                      });
                    }
                },
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Date and time are required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8,),
            const Text('Description:',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Event description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              scrollController: ScrollController(),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Outdoors',
                      style: TextStyle(fontSize: 25),
                    ),
                    Radio<String>(
                      value: 'Outdoors',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Indoors',
                      style: TextStyle(fontSize: 25),
                    ),
                    Radio<String>(
                      value: 'Indoors',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Others',
                      style: TextStyle(fontSize: 25),
                    ),
                    Radio<String>(
                      value: 'Others',
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: _saveEvent,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 30)
              ),
              child: const Text('Save'),
            ),
          ),
          ],
        ),
      ),
    );
  }
}