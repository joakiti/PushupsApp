import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/helpers/ticker.dart';

import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  int _duration = 1;
  final Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;

  @override
  TimerState get initialState => Ready(_duration);

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      yield* generateStateStart(event);
    } else if (event is Tick) {
      yield* generateStateTick(event);
    } else if (event is PauseTimer) {
      yield* generateStatePause(event);
    } else if (event is Resume) {
      yield* generateStateResume(event);
    }
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
  }

  Stream<TimerState> generateStatePause(PauseTimer pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration);
    }
  }

  Stream<TimerState> generateStateResume(Resume pause) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration);
    }
  }

  Stream<TimerState> generateStateStart(Start event) async* {
    _duration = event.duration;
    yield Running(event.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen((duration) {
      add(Tick(duration: duration));
    });
  }

  Stream<TimerState> generateStateTick(Tick event) async* {
    _duration = event.duration;
    yield _duration == 0 ? Finished() : Running(event.duration);
  }
}
