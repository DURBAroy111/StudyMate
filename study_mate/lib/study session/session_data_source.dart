import 'package:flutter/material.dart';
import 'package:study_mate/study%20session/session.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource{
  EventDataSource (List<Event1> appointments){
    this.appointments = appointments;


  }
  Event1 getEvent(int index)=> appointments![index] as Event1;

  DateTime getStartTime(int index) =>getEvent(index).from;

  DateTime getEndTime(int index) =>getEvent(index).to;
  @override
  String getSubject(int index) =>getEvent(index).title;

  Color getColor(int index) =>getEvent(index).backgroundColor;
}