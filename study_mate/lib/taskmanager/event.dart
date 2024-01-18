

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Event extends HiveObject {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime from;

 @HiveField(3)
 final DateTime to;

  @HiveField(4)
  final Color backgroundColor;

  @HiveField(5)
  final bool isAllday;

  Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightBlue,
    this.isAllday = false,
  });
}
class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 1; // Make sure to set a unique typeId for your class

  @override
  Event read(BinaryReader reader) {
    return Event(
      title: reader.read() as String,
      description: reader.read() as String,
      from: DateTime.parse(reader.read() as String),
     to: DateTime.parse(reader.read() as String),
      backgroundColor: Color(reader.read() as int),
      isAllday: reader.read() as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer.write(obj.title);
    writer.write(obj.description);
    writer.write(obj.from.toIso8601String());
    writer.write(obj.to.toIso8601String());
    writer.write(obj.backgroundColor.value);
    writer.write(obj.isAllday);
  }
}
