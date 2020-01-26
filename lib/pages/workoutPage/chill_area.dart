import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/components/pause_timer.dart';
import 'package:project_nash_equilibrium/components/wave_background.dart';
import 'package:project_nash_equilibrium/helpers/ticker.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_bloc.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_event.dart';
import 'package:project_nash_equilibrium/models/active_workout/active_workout_state.dart';
import 'package:project_nash_equilibrium/models/timer/bloc.dart';
import 'package:project_nash_equilibrium/pages/workoutPage/workoutPage.dart';
import 'package:project_nash_equilibrium/pages/workoutPage/workoutPageHelperFunctions.dart';
import 'package:project_nash_equilibrium/pages/workoutPage/workoutPop.dart';

class ChillAreaCard extends StatefulWidget {
  @override
  _ChillAreaCardState createState() => _ChillAreaCardState();
}

class _ChillAreaCardState extends State<ChillAreaCard> with WorkoutPop {
  ActiveWorkoutBloc awb;
  TimerBloc _timerBloc = TimerBloc(ticker: Ticker());

  @override
  void initState() {
    awb = BlocProvider.of<ActiveWorkoutBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  Future<void> pauseTimerAndDisplayBackWarning(BuildContext context) {
    _timerBloc.add(PauseTimer());
    return requestPop(context).whenComplete(() => _timerBloc.add(Resume()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () => pauseTimerAndDisplayBackWarning(context),
      child: SafeArea(
        child: BlocListener(
          bloc: BlocProvider.of<ActiveWorkoutBloc>(context),
          listener: (context, state) {
            // do stuff here based on BlocA's state
            if (state is Counting) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return BlocProvider<ActiveWorkoutBloc>.value(
                    value: awb, child: WorkoutPage());
              }));
            }
          },
          child: Scaffold(
            backgroundColor: Color(0xFF1C3853),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("YOU KNOW THE DRILL\nTAKE A CHILL PILL",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 30,
                            ))),
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
                        child: Text("chill area",
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
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
        ),
      ),
    );
  }

  Container buildPushUpsCounter(BuildContext context, double height) {
    return Container(
        constraints: BoxConstraints.expand(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: Color(0xFF1C3853),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, height - 500),
                child: Container(
                  child: WavesBackground([
                    Colors.lightBlue.withOpacity(0.9),
                    Colors.lightBlueAccent,
                    Colors.greenAccent
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: BlocProvider(
                      create: (BuildContext context) => _timerBloc,
                      child: TimerBreakWidget(
                        onFinish: () {
                          awb.add(NotifyPauseFinished());
                        },
                      ),
                    )),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: buildCurrentSetContainer(context,
                      color: Theme.of(context).secondaryHeaderColor)),
            ],
          ),
        ));
  }
}
