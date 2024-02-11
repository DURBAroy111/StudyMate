import 'package:flutter/material.dart';
import 'package:study_mate/todo/my_button.dart';

class tododialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;


   tododialog({
    super.key,
     required this.controller,
     required this.onSave,
     required this.onCancel
     });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[300],
      content: Container(
        height: 120,

        //user input
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: "Add a new Task",
            
              
              ),
              
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
               children: [
          myButton(text: "Save", onPressed: onSave),
          const SizedBox(width: 8,),

            myButton(text: "Cancel", onPressed: onCancel),
          
         ],
            )
          ],
        ),
       

         ),
    );
  }
}