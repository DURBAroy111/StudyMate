import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

    final _mybox = Hive.box("mytodobox");
    // Do something with the box

    // run for first time ever
    void createInitialData() {

      todoList = [
        ["Make the bed", false],
        ["Do exercise", false],

      ];   
  }

  //load data
  void loadData(){
    todoList = _mybox.get("TODOLIST");

  }

  //update the data
  void UpdateData(){
    _mybox.put("TODOLIST", todoList);

  }



}


    
  

