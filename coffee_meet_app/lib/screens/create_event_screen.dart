import 'package:coffee_meet_app/entities/global_state.dart';
import 'package:coffee_meet_app/enum/event_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:coffee_meet_app/listTiles/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/managers/event_manager.dart';
import 'package:coffee_meet_app/managers/event_local_storage_manager.dart';
import 'package:coffee_meet_app/entities/event.dart';
import 'package:coffee_meet_app/screens/tab_List_screen.dart';

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
  String _eventError = "";
  String _selectedOption ='';

  bool _isPublic = true;


  EventLocation _getEventLocation(String location){
  EventLocation eventLocation = EventLocation.indoor;

  switch(location){
    case "Indoors":
      eventLocation = EventLocation.indoor;
      break;
    case "Outdoors":
      eventLocation = EventLocation.outdoor;
      break;
    case "Others":
      eventLocation = EventLocation.others;
      break;
  }

  return eventLocation;
}


  Future<void> _saveEvent() async {
    print("Save button pressed");
    if (_formKey.currentState!.validate()) {
      print("Form validated successfully");

      if (_selectedOption.isEmpty) {
        print("Event location not selected");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an event location.')),
        );
        return;
      }
      try {
        final currentUser = GlobalState().getCurrentUser();
        if(currentUser == null){
          setState(() {
            _eventError = 'User not logged in.';
          });
          return;
        }

        print("Current user: ${currentUser.id}");
        // fetch a unique event id
        int newEventId = await EventLocalStorageManager.generateEventId();
        print("Generated new event ID: $newEventId");

        Event _event = Event(
          eventId: newEventId,
          hostId: currentUser.id,
          eventName: _titleController.text,
          startDate: _dateController.text,
          description: _descriptionController.text,
          eventLocationStatus: _getEventLocation(_selectedOption),
          isPublic: _isPublic
        );

        print("Event object created: $_event");
        // Save event
        await _eventManager.addEvent(_event);


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TabListScreen(user:currentUser),
          ),
        );
        print("Navigated to TabListScreen");
      } catch (e) {
        setState(() {
          _eventError = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $_eventError')),
        );
      }
    }else{
      print("Form validation failed");
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
              validator: (value) {
                if (value == null || value.isEmpty) {
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
              validator: (value) {
                if (value == null || value.isEmpty) {
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
              onTap: () async {
                String? selectedDateTime = await _eventManager.selectDateTime(
                    context);

                if (selectedDateTime != null) {
                  setState(() {
                    _dateController.text = selectedDateTime;
                  });
                  print("Selected date and time: $selectedDateTime");
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Public Event?',
                  style: TextStyle(fontSize: 25),
                ),
                Switch(
                  value: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value;
                    });
                  },
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
                    textStyle: TextStyle(fontSize: 32)
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