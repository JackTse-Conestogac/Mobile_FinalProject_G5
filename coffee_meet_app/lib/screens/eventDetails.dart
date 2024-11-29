import 'package:flutter/material.dart';
import '../entities/Event.dart';



class EventDetailScreen extends StatelessWidget{
   final Event event;

  const EventDetailScreen({required this.event,Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Icons.event,size: 100,),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      event.startDate.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8,),
            // Text(
            //   event.attendance.isEmpty? 'No description provided' :
            //       'This is where the detailded description of the event will populate',
            //   style: TextStyle(fontSize: 20),
            // ),
            const SizedBox(height: 16,),
            Text(
              event.description,
              style: TextStyle(
                  fontSize: 25,
                 fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16,),
            Center(
              child: ElevatedButton(
                  onPressed: (){
                    // display map function in here
                    debugPrint('View map for event:${event.eventName}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child:Text('View Map'),
              ),
            )
          ],
        ),
      ),
    );
  }

}