import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {

  @override
  MainPageState get initialState =>  ChangedPage(1);

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is PageChanged) {
      yield ChangedPage(event.index);
    }
  }
}
