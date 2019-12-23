import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nash_equilibrium/helpers/ticker.dart';
import 'package:project_nash_equilibrium/models/timer/bloc.dart';

class TimerBreakWidget extends StatefulWidget {
  Function onFinish;

  TimerBreakWidget({this.onFinish});

  @override
  _TimerBreakWidgetState createState() => _TimerBreakWidgetState();
}

class _TimerBreakWidgetState extends State<TimerBreakWidget> {
  TimerBloc _timerBloc;

  @override
  void initState() {
    // TODO: implement initState
    _timerBloc = BlocProvider.of<TimerBloc>(context);
    _timerBloc.dispatch(Start(duration: 30));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _timerBloc,
      listener: (context, state) {
        if (state is Finished && widget.onFinish != null) {
          widget.onFinish();
        }
      },
      child: BlocProvider(
          builder: (BuildContext context) => _timerBloc, child: Timer()),
    );
  }
}

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 80,
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      BlocBuilder(
        bloc: BlocProvider.of<TimerBloc>(context),
        builder: (context, state) {
          final String minutesStr =
              ((state.duration / 60) % 60).floor().toString().padLeft(1, '0');
          final String secondsStr =
              (state.duration % 60).floor().toString().padLeft(2, '0');
          return Text(
            '$minutesStr:$secondsStr',
            style: Timer.timerTextStyle,
          );
        },
      ),
    ]);
  }
}
