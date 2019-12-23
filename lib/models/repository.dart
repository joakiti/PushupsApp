import 'package:project_nash_equilibrium/models/sets/sets.dart';

import 'notifications/notification.dart';

class Repository {
  static Future<Sets> getSets() async {
    await Future.delayed(Duration(seconds: 0));
    return Sets(set: [8, 8, 6, 7, 6], level: 2);
  }

  static Future<NotificationTime> getNotificationTime() async {
    await Future.delayed(Duration(seconds: 0));
    return NotificationTime(time: DateTime(2019, 3, 2, 12, 10, 50, 0, 0));
  }
}
