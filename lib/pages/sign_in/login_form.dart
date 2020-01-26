import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/bloc.dart';
import 'package:project_nash_equilibrium/models/repositories/user_repository.dart';
import 'package:project_nash_equilibrium/pages/sign_in/buttons/lost_password_button.dart';
import 'buttons/create_account_button.dart';
import 'buttons/google_login_button.dart';
import 'buttons/login_button.dart';
import 'login/bloc.dart';
import 'dart:ui' as ui;

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController =
      TextEditingController(text: "test@hotmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "secretpassword1");

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                            child: Text(
                                'Login Failure: ${state.failureMesage.message}'))),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              child: Container(
                /**
                 * So, we push down the layout by having a box o
                 */
                height: ui.window.physicalSize.height * ui.window.physicalSize.aspectRatio - 350,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyleProvider.bold(16).copyWith(decoration: TextDecoration.underline),
                        icon: Icon(Icons.email, color: Theme.of(context).primaryColor.withOpacity(0.9)),
                        labelText: 'Email',
                      ),
                      autovalidate: false,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid
                            ? 'Your e-mail must contain @'
                            : null;
                      },
                    ),
                    TextFormField(
                      style: TextStyleProvider.regular(14),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelStyle: TextStyleProvider.bold(16).copyWith(decoration: TextDecoration.underline),
                        fillColor: Colors.white,
                        icon: Icon(Icons.lock, color: Theme.of(context).primaryColor.withOpacity(0.9)),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autovalidate: false,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Your password must contain characters and numbers'
                            : null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: <Widget>[
                          LoginButton(onPressed: _onFormSubmitted),
                          GoogleLoginButton(),
                          CreateAccountButton(
                              userRepository: _userRepository),
                          LostPasswordButton(
                              userRepo: _userRepository)
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
