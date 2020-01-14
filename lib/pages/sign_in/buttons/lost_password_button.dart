import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/repositories/user_repository.dart';

import '../register_screen.dart';

class LostPasswordButton extends StatelessWidget {
  final UserRepository _userRepository;

  LostPasswordButton({@required UserRepository userRepo})
      : _userRepository = userRepo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          child: Text(
            'Forgot your password?',
            style: TextStyleProvider.bold(12),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("Password reset"),
                    children: <Widget>[
                      Text("Type in your e-mail, and we'll send you a reset link")

                    ],
                  );
                });
          }),
    );
  }
//_userRepository.resetUserPassword(user)
/**
    Navigator.of(context).push(
    MaterialPageRoute(builder: (context) {
    return RegisterScreen(userRepository: _userRepository);
    }),
    );
 **/
}
