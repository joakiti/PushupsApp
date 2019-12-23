import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:project_nash_equilibrium/models/notifications/notification.dart';
import 'package:project_nash_equilibrium/models/repository.dart';

import './bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetNotification) {
      yield NotificationLoading();
      NotificationTime notification = await Repository.getNotificationTime();
      yield NotificationLoaded(notification);
    }
  }
}
