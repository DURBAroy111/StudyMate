import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_mate/study%20session/session__calendarwidget.dart';
import 'package:study_mate/study%20session/session_editing_page.dart';
import 'package:study_mate/study%20session/session_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';


class StudySessionsPage  extends StatelessWidget {
  const StudySessionsPage  ({super.key});
  static final String title = "StudyMate";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> SessionProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.deepPurple[300],
        
      ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Sessions",
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: ()=>Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>EventEditingPage()),
        ),
      ),
    );
  }
}
