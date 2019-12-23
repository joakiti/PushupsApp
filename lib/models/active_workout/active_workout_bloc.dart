import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';

import './bloc.dart';

class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  @override
  ActiveWorkoutState get initialState => Counting(workout.set[0], 0);

  final Sets workout;

  ActiveWorkoutBloc({@required this.workout});

  @override
  Stream<ActiveWorkoutState> mapEventToState(
    ActiveWorkoutEvent event,
  ) async* {
    if (event is Decrement) {
      var currentState = this.currentState as Counting;
      var newCount = currentState.counting - 1;
      yield Counting(newCount, currentState.currentSet);

      if (newCount == 0 && currentState.currentSet >= workout.set.length - 1) {
        yield WorkoutFinished();//newCount, currentState.currentSet);
      }

      if (newCount == 0 && currentState.currentSet < workout.set.length - 1) {
        var currentState = this.currentState as Counting;
        yield Pause(currentState.counting, currentState.currentSet);
      }

    }
      else if (event is NotifyPauseFinished) {
        var currentState = this.currentState as Pause;
        var updateSetIndex = currentState.currentSet + 1;
        yield Counting(workout.set[updateSetIndex], updateSetIndex);
    }
  }
}
