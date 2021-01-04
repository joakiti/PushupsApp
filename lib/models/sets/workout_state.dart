import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';


@immutable
abstract class WorkoutState extends Equatable {
  WorkoutState([List props = const []]) : super(props);
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final SetLevel workout;

  WorkoutLoaded(this.workout) : super([workout]);
}
