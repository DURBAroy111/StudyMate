import 'package:hive/hive.dart';
import 'package:study_mate/attendence/model.dart';

class SubjectModelAdapter extends TypeAdapter<SubjectModel> {
  @override
  final int typeId = 0;

  @override
  SubjectModel read(BinaryReader reader) {
    final subject = SubjectModel()
      ..name = reader.readString()
      ..totalClasses = reader.readInt()
      ..attendedClasses = reader.readInt();
      
    return subject;
  }

  @override
  void write(BinaryWriter writer, SubjectModel subject) {
    writer.writeString(subject.name);
    writer.writeInt(subject.totalClasses);
    writer.writeInt(subject.attendedClasses);
  }
}
