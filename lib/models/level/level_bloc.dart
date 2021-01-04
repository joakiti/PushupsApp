import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {

  SetLevel current;

  LevelBloc(this.current);

  @override
  Stream<LevelState> mapEventToState(
    LevelEvent event,
  ) async* {
    if (event is Changed) {

    }
    // TODO: implement mapEventToState
  }

  @override
  // TODO: implement initialState
  LevelState get initialState => SelectedLevel(current.level, current.activeDay);
}
