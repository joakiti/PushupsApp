import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_bloc.dart';
import 'package:project_nash_equilibrium/models/sets/bloc.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';
import 'package:project_nash_equilibrium/pages/workoutPage/workoutPage.dart';

class SetPage extends StatefulWidget with MainPageInterface {
  SetPage();

  @override
  _SetPageState createState() => _SetPageState();

  @override
  buildButton(BuildContext context) {
    return PageHelper.navBarButton(
        Theme.of(context).primaryColor,
        "LET'S PUMP IT!",
        () => {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider.value(
                        value: ActiveWorkoutBloc(
                            workout: BlocProvider.of<WorkoutBloc>(context).set),
                        child: WorkoutPage()),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end);
                  var curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  );

                  return SlideTransition(
                    child: child,
                    position: tween.animate(curvedAnimation),
                  );
                },
              ))
            },
        context);
  }
}

class _SetPageState extends State<SetPage>
    with AutomaticKeepAliveClientMixin<SetPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: BlocProvider.of<WorkoutBloc>(context),
      builder: (BuildContext context, WorkoutState state) {
        if (state is WorkoutInitial) {
          BlocProvider.of<WorkoutBloc>(context).dispatch(GetWorkout());
          return Container();
        } else if (state is WorkoutLoading) {
          return _buildLoading();
        } else if (state is WorkoutLoaded) {
          return buildBody(context, state.workout);
        }
      },
    );
  }

  Widget buildBody(BuildContext context, Sets sets) {
    return PageHelper.buildPageViewPage(context: context, widgets: <Widget>[
      SizedBox(
        height: 20,
      ),
      Text(
        "KEEP UP THE GOOD WORK!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 30,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "You've worked out 3 times this week",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      buildPushUpCard(context, sets),
    ]);
  }

  Container buildPushUpCard(BuildContext context, Sets sets) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 17, right: 17, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Theme.of(context).secondaryHeaderColor,
        elevation: 5,
        child: Column(
          children: <Widget>[
            buildCardHeader(context, sets),
            buildCardBody(context, sets)
          ],
        ),
      ),
    );
  }

  Expanded buildCardBody(BuildContext context, Sets sets) {
    String displayText = "";
    for (int set in sets.set) {
      displayText += set.toString() + " - ";
    }
    //Remove the last dash
    displayText = displayText.substring(0, displayText.length - 2);
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: new BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(displayText,
              style: TextStyle(fontSize: 35, color: Colors.white)),
        ),
        //From: https://medium.com/jlouage/container-de5b0d3ad184
        alignment: FractionalOffset(0.5, 0.5),
      ),
    );
  }

  Row buildCardHeader(BuildContext context, Sets sets) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(children: [
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(sets.total.toString() + " PUSH UPS",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Through the set",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            )
          ]),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              child: Text("LEVEL " + sets.level.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor)),
              padding: EdgeInsets.only(top: 5, right: 10),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoading() {
    return SafeArea(
      child: Center(
        heightFactor: 10,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
