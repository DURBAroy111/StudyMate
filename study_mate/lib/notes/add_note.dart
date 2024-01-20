import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/notes/note_page.dart';
 // Import your main.dart or adjust the import accordingly

class AddNotePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addNote(context);
              },
              child: Text('Save Note'),
            ),
            Text("After saving the note , press once to edit the note and long press to delete it."),
          ],
        ),
      ),
    );
  }

  void _addNote(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');
    var newNote = Note(
      title: titleController.text,
      content: contentController.text,
    );
    notesBox.add(newNote);
    Navigator.pop(context); // Go back to the previous screen
  }
}
