import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:project_nash_equilibrium/models/sets/bloc.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';

import 'package:project_nash_equilibrium/models/repositories/repository.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {

  Sets set;

  @override
  WorkoutState get initialState => WorkoutInitial();

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetWorkout) {
      yield WorkoutLoading();
      final SetLevel workout = await Repository.getSets();
      this.set = workout.sets[workout.activeDay];
      yield WorkoutLoaded(this.set);
    }
  }
}
