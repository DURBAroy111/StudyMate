import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/attendence/model.dart';
import 'package:hive_flutter/hive_flutter.dart';


class SubjectController {
  final Box<SubjectModel> _box = Hive.box<SubjectModel>('subjects');

  List<SubjectModel> get subjects => _box.values.toList();

  void addSubject(String name, int totalClasses) {
    final subject = SubjectModel()
      ..name = name
      ..totalClasses = totalClasses
      ..attendedClasses = 0;
    _box.add(subject);
    notifyListeners();
  }

  void editSubject(
      SubjectModel subject, String editedName, int editedTotalClasses) {
    subject
      ..name = editedName
      ..totalClasses = editedTotalClasses;
    subject.save();
    notifyListeners();
  }

  void incrementAttendedClasses(SubjectModel subject) {
    if (subject.attendedClasses < subject.totalClasses) {
      subject.attendedClasses++;
      subject.save();
      notifyListeners();
    }
  }

  void deleteSubject(SubjectModel subject) {
    subject.delete();
    notifyListeners();
  }

  void notifyListeners() {
    _box.listenable().addListener(() {});
  }
}
