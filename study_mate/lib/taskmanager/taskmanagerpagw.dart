import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_mate/taskmanager/event_editing_page.dart';
import 'package:study_mate/taskmanager/eventprovider.dart';
import 'package:study_mate/taskmanager/taskcalendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';


/*void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(EventAdapter());
  await Hive.openBox<Event>('events');
  runApp(const MyApp());
}*/

class TaskManagerPage extends StatelessWidget {
  const TaskManagerPage({super.key});
  static final String title = "Task Manager";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> EventProvider(),
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
        title: Text("Task Manager"),
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
