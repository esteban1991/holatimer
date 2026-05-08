import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_photo.dart';
import 'database.dart';

final photosRepositoryProvider = Provider((_) => PhotosRepository());

final photosProvider = FutureProvider.family<List<EventPhoto>, int>((ref, eventId) async {
  return ref.watch(photosRepositoryProvider).getForEvent(eventId);
});

class PhotosRepository {
  Future<List<EventPhoto>> getForEvent(int eventId) async {
    final db = await AppDatabase.instance.db;
    final maps = await db.query(
      'photos',
      where: 'event_id = ?',
      whereArgs: [eventId],
      orderBy: 'taken_at DESC',
    );
    return maps.map(EventPhoto.fromMap).toList();
  }

  Future<EventPhoto> insert(EventPhoto photo) async {
    final db = await AppDatabase.instance.db;
    final id = await db.insert('photos', photo.toMap());
    return EventPhoto(
      id: id,
      eventId: photo.eventId,
      filePath: photo.filePath,
      takenAt: photo.takenAt,
      caption: photo.caption,
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance.db;
    await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }
}
