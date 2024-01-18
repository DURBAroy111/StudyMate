import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/taskmanager/event.dart';

class EventProvider extends ChangeNotifier{
  final List <Event> _events= [];

  List <Event> get events=> _events;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate =>_selectedDate;

  EventProvider() {
    // Load events from Hive when the provider is initialized
    _loadEvents();
  }
  void _loadEvents() async {
    final eventsBox = await Hive.openBox<Event>('events');
    _events.addAll(eventsBox.values);
    notifyListeners();
  }

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) async{
    _events.add(event);
    notifyListeners();
    await _saveEvents();
  }

  void editEvent(Event newEvent, Event oldEvent) async{
    final index = _events.indexOf(oldEvent);
    _events[index]= newEvent;

    notifyListeners();
    await _saveEvents();
  }
  Future<void> _saveEvents() async {
    final eventsBox = await Hive.openBox<Event>('events');
    await eventsBox.clear();
    await eventsBox.addAll(_events);
  }

}