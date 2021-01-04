part of 'level_bloc.dart';

@immutable
abstract class LevelState {}

class SelectedLevel extends LevelState {
  int level, day;

  SelectedLevel(this.level, this.day);
}
