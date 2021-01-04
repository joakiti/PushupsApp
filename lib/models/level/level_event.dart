part of 'level_bloc.dart';

@immutable
abstract class LevelEvent {}

class Changed extends LevelEvent {
  final int level, day;

  Changed(this.level, this.day);
}
