import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/repositories/text_repository.dart';

abstract class WorkoutPop {
  Future<void> requestPop(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("You sure?"),
              content: new Text(RepositoryProvider.of<TextRepository>(context).A_FEW_MORE),
              actions: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text(RepositoryProvider.of<TextRepository>(context).LEAVE, style: TextStyleProvider.bold(12)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      color: Colors.redAccent
                    ),
                    RaisedButton(
                      child: Text(RepositoryProvider.of<TextRepository>(context).STAY, style: TextStyleProvider.bold(12)),
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
