import 'package:flutter/material.dart';
import 'package:study_mate/taskmanager/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource{
  EventDataSource (List<Event> appointments){
    this.appointments = appointments;


  }
  Event getEvent(int index)=> appointments![index] as Event;

  DateTime getStartTime(int index) =>getEvent(index).from;

  DateTime getEndTime(int index) =>getEvent(index).to;
  @override
  String getSubject(int index) =>getEvent(index).title;

  Color getColor(int index) =>getEvent(index).backgroundColor;
}