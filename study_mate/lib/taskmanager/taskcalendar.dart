import 'package:flutter/material.dart';
import 'package:study_mate/taskmanager/event_data_source.dart';
import 'package:study_mate/taskmanager/eventprovider.dart';
import 'package:study_mate/taskmanager/taskwidget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
 // const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.black,
      viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.deepPurple),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context , listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context
        , builder: (context ) => TasksWidget() ,
        );

      },
    );
  }
}