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
    return PageHelper.navBarButton(
        Theme.of(context).primaryColor, "BREAK THE LIMITS", () => {}, context);
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
            children: RepositoryProvider.of<Repository>(context)
                .data
                .asMap()
                .entries
                .map((entry) {
              int selectedLevelInApp = 2;
              int selectedDay = 1;
              SetLevel level = entry.value;
              int indx = entry.key;
              var bottomPadding = 8.0;
              if (indx + 1 ==
                  RepositoryProvider.of<Repository>(context).data.length) {
                bottomPadding = 128;
              }
              var color = () {
                if (selectedLevelInApp == indx +1) {
                  if (selectedDay < level.day) {
                    return Colors.grey;
                  } else if (selectedDay == level.day) {
                    return Colors.lightGreenAccent;
                  }
                }
                return Colors.white;

              };
              return Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, bottomPadding),
                child: MenuSection(
                  Theme.of(context).secondaryHeaderColor,
                  Colors.white,
                  level == selectedLevelInApp ? Colors.lightGreenAccent : null,
                  level,
                  (SetLevel level) {
                    print(level.sets);
                  },
                  entryColor: color,
                ),
              );
            }).toList(),
          ),
        ],
      )
    ], context: context);
  }
}
