import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/models/repositories/user_repository.dart';

import 'login/bloc.dart';
import 'login_form.dart';
import 'dart:ui' as ui;


class LoginScreen extends StatefulWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /**
         * The background of the sign in page.
         */
        Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Image.asset(
            "assets/pushup_man.jpg",
            height: ui.window.physicalSize.height,
            fit: BoxFit.fitHeight,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.transparent,
          body: BlocProvider<LoginBloc>(
            create: (context) => _loginBloc,
            child: LoginForm(userRepository: _userRepository),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
