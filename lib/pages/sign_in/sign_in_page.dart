import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/models/bloc.dart';
import 'package:project_nash_equilibrium/models/repositories/UserRepository.dart';

class SignInPage extends StatefulWidget {
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}