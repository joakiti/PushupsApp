import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/level_selection.dart';
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
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: MenuSection(
                Theme.of(context).secondaryHeaderColor,
                Theme.of(context).primaryColorLight,
                RepositoryProvider.of<Repository>(context).data[index],
                (SetLevel level) {
                  print(level.sets);
                },
              ),
            ),
        itemCount: RepositoryProvider.of<Repository>(context).data.length);
  }
}
