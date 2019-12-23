import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/pages/main/mainPage.dart';
import 'package:project_nash_equilibrium/pages/sign_in/sign_in_page.dart';
import 'helpers/colors.dart';
import 'models/mainpage/bloc.dart';
import 'models/notifications/bloc.dart';
import 'models/sets/bloc.dart';
import 'pages/sign_in/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';

void main() =>
    {BlocSupervisor.delegate = SimpleBlocDelegate(), runApp(MyApp())};

class MyApp extends StatelessWidget {
  final MainPageBloc _mainPageBloc = MainPageBloc();
  final NotificationBloc _notificationPageBloc = NotificationBloc();
  final WorkoutBloc _workoutBlocPageBloc = WorkoutBloc();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch:
                  MaterialColor(0xFFfa5333, CustomColors.primary_color),
              secondaryHeaderColor: Color(0xFF0d2134),
              primaryColorLight: Color(0xFFD8E0E3),
              fontFamily: 'Roboto'),
          home: SafeArea(child: SignInPage()),
          routes: <String, WidgetBuilder>{
            '/notifications': (BuildContext context) {
              _mainPageBloc.add(PageChanged(0));
              return MainPage();
            },
            '/sets': (BuildContext context) {
              _mainPageBloc.add(PageChanged(1));
              return MainPage();
            },
          }),
      providers: <BlocProvider>[
        BlocProvider<MainPageBloc>(
          create: (BuildContext context) => _mainPageBloc,
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => _notificationPageBloc,
        ),
        BlocProvider<WorkoutBloc>(
          create: (BuildContext context) => _workoutBlocPageBloc,
        ),
      ],
    );
  }
}
// v2: add Gesture detector
