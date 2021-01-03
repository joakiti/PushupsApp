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
              title: new Text("Are you sure you want to cancel?"),
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
                      color: Theme.of(context).primaryColor
                    ),
                    RaisedButton(
                      child: Text(RepositoryProvider.of<TextRepository>(context).STAY, style: TextStyleProvider.bold(12)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ]);
        },
      );
  }
}
