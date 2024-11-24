import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/Event.dart';


class EventManager {
  List<Event> events;

  EventManager({
    this.events = const []
    }
  );

  void ViewEventsDetail(){

  }

  void AddEvent(){

  }

  void EditEvent(){

  }

  void DeleteEvent(){

  }

  // manager the selected event's date
  Future<String?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) {
      return null;
    }

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) {
      return null;
    }

    final DateTime fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return "${fullDateTime.toIso8601String().split('T')[0]} ${selectedTime.format(context)}";
  }
}


