import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_mate/attendence/attendencepage.dart';
import 'package:study_mate/attendence/model.dart';
import 'package:study_mate/attendence/subject_adapter.dart';
import 'package:study_mate/notes/note_page.dart';
import 'package:study_mate/study%20session/session.dart';
import 'package:study_mate/study%20session/study_sessionpage.dart';
import 'package:study_mate/taskmanager/event.dart';
import 'package:study_mate/taskmanager/taskmanagerpagw.dart';
import 'package:study_mate/todo/todopage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/src/rendering/box.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(SubjectModelAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(SessionAdapter());

  await Hive.openBox<Event>('events');
  await Hive.openBox<Event>('session');
  await Hive.openBox("mytodobox");
  await Hive.openBox<SubjectModel>('subjects');
  await Hive.openBox<Note>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'StudyMate',
      debugShowCheckedModeBanner: false,
      home : Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  var height, width;

  List imgSrc = [
    "images/notes.png",
    "images/session.png",
    "images/task.png",
    "images/time.png",
    "images/attendence.png",
  ];

  List titles = [
    "Notes",
    "Study Sessions",
    "Task Manager",
    "ToDo",
    "Attendance ",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.deepPurple[300],
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              height: height * 0.25,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 65,
                  left: 20,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "StudyMate",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Welcome to the Dashboard",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white54,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              height: height * 0.75,
              width: width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imgSrc.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotesPage(),
                          ),
                        );
                      },
                      child: buildContainer(index),
                    );
                  } else if (index == 1) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudySessionsPage(),
                          ),
                        );
                      },
                      child: buildContainer(index),
                    );
                  } else if (index == 2) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskManagerPage(),
                          ),
                        );
                      },
                      child: buildContainer(index),
                    );
                  } else if (index == 3) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToDoPage(),
                          ),
                        );
                      },
                      child: buildContainer(index),
                    );
                  } 
                  else if (index == 4) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendencePage(),
                          ),
                        );
                      },
                      child: buildContainer(index),
                    );
                  } 
                  else {
                    return Container(); 
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26, 
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imgSrc[index],
            width: 100,
          ),
          Text(
            titles[index],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

