import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_nash_equilibrium/models/notifications/notification.dart';

@immutable
abstract class NotificationState extends Equatable {
  NotificationState([List props = const []]) : super(props);
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final NotificationTime notification;

  NotificationLoaded(this.notification) : super([notification]);
}
