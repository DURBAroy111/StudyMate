import 'package:flutter/material.dart';
import 'package:study_mate/study%20session/session_data_source.dart';
import 'package:study_mate/study%20session/session_provider.dart';
import 'package:study_mate/study%20session/session_task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class CalendarWidget extends StatelessWidget {
 // const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<SessionProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.black,
      viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.deepPurple),
      onLongPress: (details) {
        final provider = Provider.of<SessionProvider>(context , listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context
        , builder: (context ) => TasksWidget() ,
        );

      },
    );
  }
}