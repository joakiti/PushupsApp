import 'package:project_nash_equilibrium/models/notifications/notification.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';
import 'package:project_nash_equilibrium/pages/main/mainPage/levelsPage.dart';

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
    SetLevel(level: 2, sets: [
      Sets(set: [2, 3, 6, 7]),
      Sets(set: [2, 3, 6, 7])
    ]),
    SetLevel(level: 3, sets: [
      Sets(set: [2, 3, 6, 7])
    ])
  ];
}
/**
    <Entry>[
    Entry(
    'Chapter A',
    <Entry>[
    Entry(
    'Section A0',
    <Entry>[
    Entry('Item A0.1'),
    Entry('Item A0.2'),
    Entry('Item A0.3'),
    ],
    ),
    Entry('Section A1'),
    Entry('Section A2'),
    ],
    ),
    Entry(
    'Chapter B',
    <Entry>[
    Entry('Section B0'),
    Entry('Section B1'),
    ],
    ),
    Entry(
    'Chapter C',
    <Entry>[
    Entry('Section C0'),
    Entry('Section C1'),
    Entry(
    'Section C2',
    <Entry>[
    Entry('Item C2.0'),
    Entry('Item C2.1'),
    Entry('Item C2.2'),
    Entry('Item C2.3'),
    ],
    ),
    ],
    ),
    ];
    }
 **/
