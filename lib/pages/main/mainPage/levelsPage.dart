import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/level_selection.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/repositories/repository.dart';
import 'package:project_nash_equilibrium/models/sets/bloc.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/workout_bloc.dart';

class LevelsPage extends StatefulWidget implements MainPageInterface {
  @override
  _LevelsPageState createState() => _LevelsPageState();

  @override
  Widget buildButton(BuildContext context) {
    // TODO: implement buildButton
    return PageHelper.navBarButton(
        Color.lerp(Theme.of(context).secondaryHeaderColor, Colors.black, 0.9),
        "PUSH THE LIMITS!", () {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text("Not possible yet :-/"),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                      "Adding levels is not yet possible. Like this app on the app store to get more content!"),
                )
              ],
            );
          });
      /**
       * TODO: Fix this
          BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
          );
       **/
    }, context);
  }
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          FutureBuilder(
            future: Repository.getCurrentLevel(),
            builder: (context, level) {
              if (level.hasData) {
                return FutureBuilder(
                    future: Repository.getCurrentDay(),
                    builder: (context, day) {
                      if (day.hasData) {
                        return Column(
                          children: Repository.data
                              .map((set) => generateSetLevelSection(
                                  set, level.data, day.data))
                              .toList(),
                        );
                      }
                      return CircularProgressIndicator();
                    });
              } else
                return CircularProgressIndicator();
            },
          ),
        ],
      )
    ], context: context);
  }

  Widget generateSetLevelSection(
      SetLevel set, int selectedLevel, int selectedDay) {
    int level = set.level;
    var bottomPadding = 8.0;
    if (level == Repository.data.length) {
      bottomPadding = 128;
    }
    var colorFunc = (day) {
      if (selectedLevel == level) {
        if (selectedDay > day) {
          return Colors.grey;
        } else if (selectedDay == day) {
          return Colors.green;
        }
      } else if (selectedLevel > level) {
        return Colors.grey;
      }
      return Colors.white;
    };
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, bottomPadding),
      child: MenuSection(
        Theme.of(context).secondaryHeaderColor,
        Colors.white,
        level == selectedLevel ? Colors.green : null,
        set,
        (day, level) async {
          Repository.setCurrentLevel(level);
          Repository.setCurrentDay(day);
          BlocProvider.of<WorkoutBloc>(context).add(GetWorkout());
        },
        entryColor: colorFunc,
      ),
    );
  }
}
