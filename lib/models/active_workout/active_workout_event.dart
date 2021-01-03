import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActiveWorkoutEvent extends Equatable {

  ActiveWorkoutEvent([List props = const []]) : super(props);
}

class Start extends ActiveWorkoutEvent {
}

class Decrement extends ActiveWorkoutEvent {

}

class NotifyPauseFinished extends ActiveWorkoutEvent {

}
