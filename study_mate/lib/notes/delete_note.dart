import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/notes/note_page.dart';


class DeleteNotePage extends StatelessWidget {
  final int noteIndex;

  DeleteNotePage({required this.noteIndex});

  @override
  Widget build(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');
    var noteToDelete = notesBox.getAt(noteIndex)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Are you sure you want to delete this note?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Title: ${noteToDelete.title}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Content: ${noteToDelete.content}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _deleteNote(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text('Delete Note'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');
    notesBox.deleteAt(noteIndex);
    Navigator.pop(context); // Go back to the previous screen
  }
}
