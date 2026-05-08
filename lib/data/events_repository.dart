import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import 'database.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(AppDatabase.instance);
});

final eventsProvider = FutureProvider<List<Event>>((ref) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getAll();
});

class EventsRepository {
  EventsRepository(this._db);
  final AppDatabase _db;

  Future<List<Event>> getAll() => _db.getEvents();
  Future<Event?> getById(int id) => _db.getEvent(id);
  Future<int> create(Event event) => _db.insertEvent(event);
  Future<void> update(Event event) => _db.updateEvent(event);
  Future<void> delete(int id) => _db.deleteEvent(id);
}
