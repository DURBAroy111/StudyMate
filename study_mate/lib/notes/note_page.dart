import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_mate/notes/add_note.dart';
import 'package:study_mate/notes/delete_note.dart';
import 'package:study_mate/notes/edit_note.dart';



@HiveType(typeId: 5)
class Note extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  Note({
    required this.title,
    required this.content,
  });
}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final typeId = 5;

  @override
  Note read(BinaryReader reader) {
    return Note(
      title: reader.read(),
      content: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.write(obj.title);
    writer.write(obj.content);
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'StudyMate',
      
      home: NoteList(),
    );
  }
}

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Notes',
        style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.deepPurple[300],
      body: ValueListenableBuilder(
       
        valueListenable: notesBox.listenable(),
        
        builder: (context, Box<Note> box, _) {
          return ListView.builder(
           
            
            itemCount: box.length,
            itemBuilder: (context, index) {
              Note note = box.getAt(index)!;

              return Padding(
                padding: EdgeInsets.all(25),
               
                child: Card(
                  color: Colors.deepPurple[200],
                  child: ListTile(
                   
                    title: Text(note.title),
                    subtitle: Text(note.content),
                  
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNotePage(noteIndex: index),
                        ),
                      );
                    },
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeleteNotePage(noteIndex: index),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
