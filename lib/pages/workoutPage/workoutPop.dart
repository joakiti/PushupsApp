import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_state.dart';
import 'package:project_nash_equilibrium/models/timer/bloc.dart';

abstract class WorkoutPop {
  Future<void> requestPop(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Just a few more push-ups to go!'),
              actions: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('LEAVE', style: TextStyleProvider.bold(12)..merge(new TextStyle(color: Colors.redAccent))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      child: Text('STAY', style: TextStyleProvider.bold(12)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.green,
                    ),
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ]);
        },
      );
  }
}
