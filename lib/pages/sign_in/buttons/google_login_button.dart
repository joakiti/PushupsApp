import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text("Not possible yet :-/"),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text("Signing in with google is not available just yet. Like this app on the app store to get more content!"),
                  )
                ],
              );
            });
        /**
         * TODO: Fix this
            BlocProvider.of<LoginBloc>(context).add(
            LoginWithGooglePressed(),
            );
         **/
      },
      label: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      //color: Colors.redAccent,
      color: Colors.grey,
    );
  }
}
