import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/level_selection.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/repositories/repository.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';

class LevelsPage extends StatefulWidget implements MainPageInterface {
  @override
  _LevelsPageState createState() => _LevelsPageState();

  @override
  Widget buildButton(BuildContext context) {
    // TODO: implement buildButton
    return PageHelper.navBarButton(Color.lerp(Theme.of(context).secondaryHeaderColor, Colors.black, 0.9),
        "PUSH THE LIMITS!", () => {}, context);
  }
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return PageHelper.buildPageViewPage(widgets: [
      Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text("TIME TO SHAPE\n THINGS UP?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "You've come to the right place",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: Repository
                .data
                .map((set) => generateSetLevelSection(set))
                .toList(),
          ),
        ],
      )
    ], context: context);
  }

  Widget generateSetLevelSection(SetLevel set) {
    int selectedLevelInApp = 2;
    int selectedDay = 2;
    int level = set.level;
    var bottomPadding = 8.0;
    if (level == Repository.data.length) {
      bottomPadding = 128;
    }
    var colorFunc = (day) {
      if (selectedLevelInApp == level) {
        if (selectedDay > day) {
          return Colors.grey;
        } else if (selectedDay == day) {
          return Colors.green;
        }
      }
      else if (selectedLevelInApp > level) {
        return Colors.grey;
      }
      return Colors.white;
    };
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, bottomPadding),
      child: MenuSection(
        Theme.of(context).secondaryHeaderColor,
        Colors.white,
        level == selectedLevelInApp ? Colors.green : null,
        set,
        (SetLevel level) {
          showDialog(context: context, child: AlertDialog());
        },
        entryColor: colorFunc,
      ),
    );
  }
}
