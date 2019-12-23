import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActiveWorkoutState extends Equatable {
  ActiveWorkoutState([List props = const []]) : super(props);
}

class Counting extends ActiveWorkoutState {
  final int counting, currentSet;

  Counting(this.counting, this.currentSet) : super([counting, currentSet]);
}

class Pause extends Counting {
  Pause(int counting, int currentSet) : super(counting, currentSet);
}

class WorkoutFinished extends ActiveWorkoutState{}