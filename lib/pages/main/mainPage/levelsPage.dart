import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/level_selection.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/repositories/repository.dart';

class LevelsPage extends StatefulWidget implements MainPageInterface {
  @override
  _LevelsPageState createState() => _LevelsPageState();

  @override
  Widget buildButton(BuildContext context) {
    // TODO: implement buildButton
    return Container();
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
            children:
                RepositoryProvider.of<Repository>(context).data.map((slevel) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MenuSection(
                  Theme.of(context).secondaryHeaderColor,
                  Theme.of(context).primaryColorLight,
                  slevel,
                  (SetLevel level) {
                    print(level.sets);
                  },
                ),
              );
            }).toList(),
          ),
        ],
      )
    ], context: context);
  }
}
