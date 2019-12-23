import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/helpers/colors.dart';
import 'package:project_nash_equilibrium/models/active_workout/bloc.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';
import 'package:project_nash_equilibrium/pages/workoutPage/workoutPop.dart';

import 'workoutPageHelperFunctions.dart';
import 'chill_area.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> with WorkoutPop {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<ActiveWorkoutBloc>(context),
        listener: (context, state) {
          // do stuff here based on BlocA's state
          if (state is Pause) {
            ActiveWorkoutBloc awb = BlocProvider.of<ActiveWorkoutBloc>(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<ActiveWorkoutBloc>.value(
                  value: awb, child: ChillAreaCard());
            }));
          }
          if (state is WorkoutFinished) {
            Navigator.pop(context, ["Finish"]);
            /**
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return WorkoutFinishPage();
                }));
             **/
          }
        },
        child: WillPopScope(
            onWillPop: () => requestPop(context), child: NoseAreaCard()));
  }
}

class NoseAreaCard extends StatefulWidget {
  @override
  _NoseAreaCardState createState() => _NoseAreaCardState();
}

class _NoseAreaCardState extends State<NoseAreaCard> {
  bool onPushDown = false;

  bool canPushDown = true;

  Matrix4 pressedTranslation = Matrix4.identity()..translate(-2.0, -2.0, 0);
  Matrix4 identityMatrix = Matrix4.identity();

  ActiveWorkoutBloc awb;

  @override
  void initState() {
    awb = BlocProvider.of<ActiveWorkoutBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFfa5333),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("DO YOUR THING\nCHICKEN WING",
                        textAlign: TextAlign.center,
                        style: TextStyleProvider.italicBold(30))),
              ),
            ),
            Container(
                width: width * 0.75,
                //Take 3/4rds of the screen
                height: height * 0.60,
                //take 2/3ds of the screen
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    width: double.infinity,
                    child: Text("nose area",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  Expanded(
                    child: Container(
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: Colors.white,
                        strokeWidth: 1.5,
                        dashPattern: [5, 5],
                        radius: Radius.circular(12),
                        child: buildPushUpsCounter(context, height),
                      ),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }

  Container buildPushUpsCounter(BuildContext context, double height) {
    return Container(
        constraints: BoxConstraints.expand(),
        child: AnimatedContainer(
          transform: onPushDown ? pressedTranslation : identityMatrix,
          duration: Duration(milliseconds: 50),
          child: GestureDetector(
            onTapDown: (TapDownDetails tdp) => dispatchTap(context),
            onPanStart: (DragStartDetails tdp) => () {
              if (canPushDown) {
                dispatchTap(context);
              }
            },
            onTapUp: (TapUpDetails tdp) => finishTap(),
            onPanEnd: (DragEndDetails ded) => finishTap(),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: onPushDown ? 1 : 6,
              color: Theme.of(context).primaryColor,
              child: Stack(children: <Widget>[
                Align(
                    alignment: FractionalOffset.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, bottom: height / 8),
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: SvgPicture.asset(
                          'assets/nose.svg',
                          color: Color(0xFFD23B1E),
                        ),
                      ),
                    )),
                pushUpsToGo(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: buildCurrentSetContainer(context,
                        color: CustomColors.workout_button_color))
              ]),
            ),
          ),
        ));
  }

  void dispatchTap(BuildContext context) {
    if (canPushDown) {
      BlocProvider.of<ActiveWorkoutBloc>(context).dispatch(Decrement());
      HapticFeedback.vibrate();
      //TODO: dont use setState
      this.setState(() => {
            onPushDown = true,
          });
    }
    canPushDown = false;
    new Future.delayed(const Duration(milliseconds: 100), () {
      canPushDown = true;
    });
  }

  void finishTap() {
    //TODO: dont use setState
    setState(() {
      // TODO: better solution for this pls.
      if (onPushDown) {
        Future.delayed(Duration(milliseconds: 80),
            () => {this.setState(() => onPushDown = false)});
      }
    });
  }

  Column pushUpsToGo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //Column is as big as its biggest child
        Center(child: Container()),
        BlocBuilder<ActiveWorkoutBloc, ActiveWorkoutState>(
          builder: (context, ActiveWorkoutState state) {
            if (state is Counting) {
              return Text(state.counting.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 90,
                  ));
            } else
              return Text("0",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 90,
                  ));
          },
        ),
        Text("PUSH UPS", style: TextStyleProvider.bold(10)),
        Text("TO GO", style: TextStyleProvider.bold(30)),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
