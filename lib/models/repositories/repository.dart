import 'package:project_nash_equilibrium/models/notifications/notification.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static Future<SetLevel> getSets() async {
    await Future.delayed(Duration(milliseconds: 500));
    SetLevel level = data[await getCurrentLevel() - 1];
    level.activeDay = await getCurrentDay();
    return level;
  }

  static Future setCurrentLevel(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt('level', level);
  }
  static Future setCurrentDay(int day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('day', day);
  }
  static Future<int> getCurrentLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('level') != null) {
      return prefs.getInt('level');
    }
    else {
      return 0;
    }
  }
  static Future<int> getCurrentDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('day') != null) {
      return prefs.getInt('day');
    }
    else {
      return 0;
    }
  }

  static Future<NotificationTime> getNotificationTime() async {
    await Future.delayed(Duration(seconds: 0));
    return NotificationTime(time: DateTime(2019, 3, 2, 12, 10, 50, 0, 0));
  }

  static final List<SetLevel> data = [
    SetLevel(level: 1, sets: [
      Sets(set: [1, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8])
    ]),
    SetLevel(level: 2, sets: [
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 8]),
      Sets(set: [2, 3, 6, 8]),
      Sets(set: [2, 3, 6, 8]),
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
