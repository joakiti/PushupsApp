import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class Start extends TimerEvent {
  final int duration;

  Start({@required this.duration}) : super([duration]);

  @override
  String toString() => "Start { duration: $duration }";
}

class PauseTimer extends TimerEvent {
  @override
  String toString() => "Pause";
}

class Resume extends TimerEvent {
  @override
  String toString() => "Resume";
}

class Reset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class End extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Increment extends TimerEvent {
  final int value;

  Increment(this.value);
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";
}
