import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/simple_bloc_delegate.dart';
import 'package:project_nash_equilibrium/pages/main/mainPage.dart';
import 'helpers/colors.dart';
import 'models/bloc.dart';
import 'models/mainpage/bloc.dart';
import 'models/notifications/bloc.dart';
import 'models/repositories/repository.dart';
import 'models/repositories/text_repository.dart';
import 'models/repositories/user_repository.dart';
import 'models/sets/bloc.dart';
import 'pages/sign_in/login_screen.dart';
import 'pages/sign_in/splash_screen.dart';
import 'package:bloc/bloc.dart';

void main() => {
      /**
       * Comment line in to enable debugging of *all* bloc events.
       */
      BlocSupervisor.delegate = SimpleBlocDelegate(),
      runApp(MyApp())
    };

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MainPageBloc _mainPageBloc = MainPageBloc();
  UserRepository _userRepository = UserRepository();
  WorkoutBloc _workoutBlocPageBloc = WorkoutBloc();
  NotificationBloc _notificationPageBloc = NotificationBloc();

  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    // TODO: implement initState
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: MultiBlocProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch:
                    MaterialColor(0xFFfa5333, CustomColors.primary_color),
                secondaryHeaderColor: Color(0xFF0d2134),
                primaryColorLight: Color(0xFFD8E0E3),
                fontFamily: 'Roboto'),
            home: SafeArea(
                child: BlocBuilder(
              bloc: _authenticationBloc,
              // ignore: missing_return
              builder: (BuildContext context, AuthenticationState state) {
                if (state is Uninitialized) {
                  return SplashScreen();
                }
                if (state is Unauthenticated) {
                  return LoginScreen(userRepository: _userRepository);
                }
                if (state is Authenticated) {
                  return MainPage();
                }
              },
            )),
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
          BlocProvider<AuthenticationBloc>(
            create: (context) => _authenticationBloc,
          )
        ],
      ),
      providers: [
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
        RepositoryProvider<Repository>(
            create: (context) => Repository()),
        RepositoryProvider<TextRepository>(
            create: (context) => TextRepository())
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// v2: add Gesture detector
