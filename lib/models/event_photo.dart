import 'package:flutter/foundation.dart';

@immutable
class EventPhoto {
  const EventPhoto({
    this.id,
    required this.eventId,
    required this.filePath,
    required this.takenAt,
    this.caption,
  });

  final int? id;
  final int eventId;
  final String filePath;
  final DateTime takenAt;
  final String? caption;

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'event_id': eventId,
    'file_path': filePath,
    'taken_at': takenAt.toIso8601String(),
    'caption': caption,
  };

  factory EventPhoto.fromMap(Map<String, dynamic> m) => EventPhoto(
    id: m['id'] as int?,
    eventId: m['event_id'] as int,
    filePath: m['file_path'] as String,
    takenAt: DateTime.parse(m['taken_at'] as String),
    caption: m['caption'] as String?,
  );
}
