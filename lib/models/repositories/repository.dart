import 'package:project_nash_equilibrium/models/notifications/notification.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';

class Repository {
  static Future<Sets> getSets() async {
    await Future.delayed(Duration(seconds: 0));
    return Sets(set: [8, 8, 6, 7, 6]);
  }

  static Future<NotificationTime> getNotificationTime() async {
    await Future.delayed(Duration(seconds: 0));
    return NotificationTime(time: DateTime(2019, 3, 2, 12, 10, 50, 0, 0));
  }

  final List<SetLevel> data = [
    SetLevel(level: 1, sets: [
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8])
    ]),
    SetLevel(level: 2, sets: [
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8])
    ]),
    SetLevel(level: 3, sets: [
      Sets(set: [2, 3, 6, 7])
    ]),
    SetLevel(level: 4, sets: [
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8]),
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8]),
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8]),
    ]),
  ];
}
