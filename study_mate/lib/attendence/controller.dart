import 'package:hive/hive.dart';
import 'package:study_mate/attendence/model.dart';


class SubjectController {
  final Box<SubjectModel> _box = Hive.box<SubjectModel>('subjects');

  List<SubjectModel> get subjects => _box.values.toList();

  void addSubject(String name, int totalClasses) {
    final subject = SubjectModel()
      ..name = name
      ..totalClasses = totalClasses
      ..attendedClasses = 0;
      //..deleteFunction= false;
    _box.add(subject);
  }

  void incrementAttendedClasses(SubjectModel subject) {
    if (subject.attendedClasses < subject.totalClasses) {
      subject.attendedClasses++;
      subject.save();
    }
  }
   void deleteSubject(SubjectModel subject) {
    subject.delete();
     
}}