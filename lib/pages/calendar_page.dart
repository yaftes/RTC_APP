
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today  = DateTime.now();
    return Scaffold(
      
      appBar: AppBar(
        
        title: Center(
          child: Text("Calendar",style: TextStyle(
            color: Colors.white,
            
          ),),
        ),
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body:  Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 43,
              headerStyle: HeaderStyle(formatButtonVisible:false,titleCentered: true),
              focusedDay: today,
               firstDay: DateTime.utc(2010,09,14), 
               lastDay: DateTime.utc(2040,4,23),),
          )
        ],
      ),
    );
  }
}