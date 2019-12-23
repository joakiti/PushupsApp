import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_bloc.dart';
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
          child: Text("CURRENT SET", style: TextStyleProvider.bold(15)),
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
  String withManyDashes = set.set.fold<String>(
      "", (empty, next) => empty.toString() + next.toString() + " - ");
  return withManyDashes.substring(
      0, ((set.set.length - 1) * 3 + set.set.length) + 1);
}
