import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageHelper {
  //This method must be called inside a column, for which it returns a list of widgets.
  static List<Widget> buildHeader(BuildContext context) {
    return [
      Container(
        height: 50,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Text("MIKKEL KAJ ANDERSEN",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
            Spacer(),
            IconButton(
              icon: Icon(FontAwesomeIcons.cog),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                print("Pressed a header button");
              },
            ),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
      Divider(
        color: Color(0xFF3d4d5c),
        height: 2,
      )
    ];
  }

  static int buildHeaderSize() {
    return 50;
  }

  static Widget buildPageViewPage(
      {@required List<Widget> widgets, @required BuildContext context}) {
    return ListView(children: widgets);
  }

  static Widget navBarButton(
      Color color, String text, Function func, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.all(20),
          width: size.width / 2,
          height: 60,
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: color,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
            onPressed: () => func(),
          )),
    );
  }
}
