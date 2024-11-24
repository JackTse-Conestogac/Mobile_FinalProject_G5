import 'package:flutter/cupertino.dart';
import 'package:coffee_meet_app/listTiles/eventTile.dart';
import 'package:flutter/material.dart';
import 'package:coffee_meet_app/managers/EventManager.dart';

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


  bool _isOutdoors = false;
  bool _isIndoors = false;
  bool _isOther = false;

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
            const SizedBox(height: 8,),
            CheckboxListTile(
                title: const Text(
                  'Outdoors', style: TextStyle(fontSize: 25),),
                value: _isOutdoors,
                onChanged: (value) {
                  setState(() {
                    _isOutdoors = value ?? false;
                  });
                }
            ),
            CheckboxListTile(
                title: const Text(
                  'Indoors', style: TextStyle(fontSize: 25),),
                value: _isIndoors,
                onChanged: (value) {
                  setState(() {
                    _isIndoors = value ?? false;
                  });
                }
            ),
            CheckboxListTile(
                title: const Text(
                  'Others', style: TextStyle(fontSize: 25),),
                value: _isOther,
                onChanged: (value) {
                  setState(() {
                    _isOther = value ?? false;
                  });
                }
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