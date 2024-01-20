import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/notes/note_page.dart';


class EditNotePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final int noteIndex;

  EditNotePage({required this.noteIndex});

  @override
  Widget build(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');
    var noteToEdit = notesBox.getAt(noteIndex)!;

    titleController.text = noteToEdit.title;
    contentController.text = noteToEdit.content;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
                _editNote(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _editNote(BuildContext context) {
    var notesBox = Hive.box<Note>('notes');
    var editedNote = Note(
      title: titleController.text,
      content: contentController.text,
    );
    notesBox.putAt(noteIndex, editedNote);
    Navigator.pop(context); // Go back to the previous screen
  }
}
