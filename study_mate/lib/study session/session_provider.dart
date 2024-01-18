import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:study_mate/study%20session/session.dart';


class SessionProvider extends ChangeNotifier{
  final List <Event1> _events= [];

  List <Event1> get events=> _events;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate =>_selectedDate;

  SessionProvider() {
    // Load events from Hive when the provider is initialized
    _loadEvents();
  }
  void _loadEvents() async {
    final eventsBox = await Hive.openBox<Event1>('session');
    _events.addAll(eventsBox.values);
    notifyListeners();
  }

  void setDate(DateTime date) => _selectedDate = date;

  List<Event1> get eventsOfSelectedDate => _events;

  void addEvent(Event1 event) async{
    _events.add(event);
    notifyListeners();
    await _saveEvents();
  }

  void editEvent(Event1 newEvent, Event1 oldEvent) async{
    final index = _events.indexOf(oldEvent);
    _events[index]= newEvent;

    notifyListeners();
    await _saveEvents();
  }
  Future<void> _saveEvents() async {
    final eventsBox = await Hive.openBox<Event1>('session');
    await eventsBox.clear();
    await eventsBox.addAll(_events);
  }

}