import 'package:flutter/foundation.dart';

enum EventType { pregnancy, birthday, anniversary, travel, custom }

enum DisplayUnit { days, weeks, months }

@immutable
class Event {
  const Event({
    this.id,
    required this.name,
    required this.targetDate,
    required this.type,
    required this.displayUnit,
    required this.createdAt,
    this.notificationTime,
    this.isActive = true,
  });

  final int? id;
  final String name;
  final DateTime targetDate;
  final EventType type;
  final DisplayUnit displayUnit;
  final DateTime createdAt;
  final String? notificationTime; // "HH:mm"
  final bool isActive;

  int get daysRemaining {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return target.difference(today).inDays;
  }

  int get weeksRemaining => (daysRemaining / 7).ceil();
  int get monthsRemaining => (daysRemaining / 30).ceil();

  Event copyWith({
    int? id,
    String? name,
    DateTime? targetDate,
    EventType? type,
    DisplayUnit? displayUnit,
    DateTime? createdAt,
    String? notificationTime,
    bool? isActive,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      targetDate: targetDate ?? this.targetDate,
      type: type ?? this.type,
      displayUnit: displayUnit ?? this.displayUnit,
      createdAt: createdAt ?? this.createdAt,
      notificationTime: notificationTime ?? this.notificationTime,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'target_date': targetDate.toIso8601String(),
      'type': type.name,
      'display_unit': displayUnit.name,
      'created_at': createdAt.toIso8601String(),
      'notification_time': notificationTime,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int?,
      name: map['name'] as String,
      targetDate: DateTime.parse(map['target_date'] as String),
      type: EventType.values.byName(map['type'] as String),
      displayUnit: DisplayUnit.values.byName(map['display_unit'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      notificationTime: map['notification_time'] as String?,
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
