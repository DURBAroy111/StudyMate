import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:study_mate/taskmanager/event.dart';
import 'package:study_mate/taskmanager/event_data_source.dart';
import 'package:study_mate/taskmanager/event_editing_page.dart';
import 'package:study_mate/taskmanager/eventprovider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatefulWidget {
  //const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<EventProvider>(context);
   final selectedEvents = provider.eventsOfSelectedDate;

   if(selectedEvents.isEmpty){
    return Center(
      child: Text(
        'No Events Found',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
   }
   return FutureBuilder(
      future: Hive.openBox<Event>('eventsBox'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final eventsBox = Hive.box<Event>('eventsBox');
          return SfCalendarTheme(
    data: SfCalendarThemeData(
      timeTextStyle: TextStyle(fontSize: 16, color: Colors.black,)
    ), 
    child: SfCalendar(
      backgroundColor: Colors.white,
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      todayHighlightColor: Colors.black,
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
      onTap: (details){
        if (details.appointments==null)return;

        final event = details.appointments!.first;

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventEditingPage(event : event),
          ));
      },
      )
      );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  }
  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ){
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
        
          ),
        ),
      )
    );
  }
