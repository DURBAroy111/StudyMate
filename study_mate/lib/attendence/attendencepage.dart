import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_mate/attendence/controller.dart';
import 'package:study_mate/attendence/model.dart';




class AttendencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyMate',
       debugShowCheckedModeBanner: false,
      home: SubjectListScreen(),
    );
  }
}

class SubjectListScreen extends StatelessWidget {
  final SubjectController _controller = SubjectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title: Text('Attendance Tracker'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<SubjectModel>('subjects').listenable(),
        builder: (context, Box<SubjectModel> box, _) {
          final subjects = _controller.subjects;
          return Padding(
            padding: EdgeInsets.only(top: 20,left: 10,right: 10, bottom: 15),
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(subject.name),
                    subtitle: Text(
                        'Attended ${subject.attendedClasses} out of ${subject.totalClasses} classes'),
                    onTap: () {
                      _controller.incrementAttendedClasses(subject);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSubjectDialog(context);
        },
        child: Icon(Icons.add),
         backgroundColor: Colors.deepPurpleAccent[150]
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    String name = '';
    int totalClasses = 0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Subject'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Subject Name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Total Classes'),
              keyboardType: TextInputType.number,
              onChanged: (value) => totalClasses = int.parse(value),
            ),
            Text("After adding the class, tap on the class name to increase number of attended class.")
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _controller.addSubject(name, totalClasses);
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
