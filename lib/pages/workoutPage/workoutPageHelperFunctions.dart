import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_bloc.dart';
import 'package:project_nash_equilibrium/models/repositories/text_repository.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';

Container buildCurrentSetContainer(BuildContext context, {Color color}) {
  return Container(
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
    height: 70,
    width: double.infinity,
    child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 9, left: 8),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(RepositoryProvider.of<TextRepository>(context).CURRENT_SET, style: TextStyleProvider.bold(15)),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Center(
              child: Text(
            buildCurrentSet(context),
            style: TextStyleProvider.bold(30),
          )))
    ]),
  );
}

String buildCurrentSet(BuildContext context) {
//Fix this
  Sets set = BlocProvider.of<ActiveWorkoutBloc>(context).workout;
  return set.toString();
}
