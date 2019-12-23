import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/notifications/bloc.dart';
import 'package:project_nash_equilibrium/models/notifications/notification.dart';

class NotificationPage extends StatefulWidget with MainPageInterface {
  @override
  _NotificationPageState createState() => _NotificationPageState();

  final FlutterTts flutterTts = new FlutterTts();

  @override
  buildButton(BuildContext context) {
    return PageHelper.navBarButton(Theme.of(context).secondaryHeaderColor,
        "SAVE", () => print("Save"), context);
  }
}

class _NotificationPageState extends State<NotificationPage>
    with AutomaticKeepAliveClientMixin<NotificationPage> {

  final List<int> minutes = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
  final List<int> hours = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
  ];

  final FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
  }

  //TODO: Consider if state management is correct
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder(
      bloc: BlocProvider.of<NotificationBloc>(context),
      // ignore: missing_return
      builder: (BuildContext context, NotificationState state) {
        if (state is NotificationInitial) {
          BlocProvider.of<NotificationBloc>(context)
              .add(GetNotification());
          return Container();
        } else if (state is NotificationLoading) {
          return _buildLoading();
        } else if (state is NotificationLoaded) {
          return buildBody(context, state.notification);
        }
      },
    );
  }

  Widget buildBody(BuildContext context, NotificationTime notification) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      PageHelper.buildPageViewPage(
        widgets: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text("REMEMBER!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Set a daily reminder for your workout.\n Studies find that people who work out at the same time every day will be less relient to quit!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: size.height / 2.5,
              child: Align(
                  alignment: FractionalOffset.center, child: buildWheel(250)),
            ),
          ),
          Column(
            children: <Widget>[],
          )
        ],
        context: context,
      ),
    ]);
  }

  Widget buildWheel(double height) {
    TextStyle _style = TextStyle(
        color: Theme.of(context).secondaryHeaderColor,
        fontSize: 60,
        fontWeight: FontWeight.bold);
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          buildTimeWheel(height, _style),
          Positioned(
            child: IgnorePointer(
              child: Container(
                height: height / 3.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.01),
                      Theme.of(context).scaffoldBackgroundColor
                    ])),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: IgnorePointer(
                child: Container(
                  height: height / 3.5,
                  alignment: FractionalOffset.bottomCenter,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.01),
                      ])),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTimeWheel(double height, TextStyle _style) {
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: _style.fontSize * 1.5,
            child: ListWheelScrollView.useDelegate(
                controller: fixedExtentScrollController,
                physics: FixedExtentScrollPhysics(),
                //this equation works for now.
                itemExtent: _style.fontSize + height / 9,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: hours
                        .map((hour) => hour < 10
                            ? Text(
                                "0$hour",
                                style: _style,
                              )
                            : Text(
                                "$hour",
                                style: _style,
                              ))
                        .toList())),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ":",
                style: _style,
              ),
              SizedBox(
                height: height / 9,
              )
            ],
          ),
          Container(
            width: _style.fontSize * 1.5,
            child: ListWheelScrollView.useDelegate(
                physics: FixedExtentScrollPhysics(),
                itemExtent: _style.fontSize + height / 9,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: minutes
                        .map((minute) => minute < 10
                            ? Text(
                                "0$minute",
                                style: _style,
                              )
                            : Text(
                                "$minute",
                                style: _style,
                              ))
                        .toList())),
          ),
        ],
      ),
    );
  }

  Widget buildTimerStyling(
      BuildContext context, double height, TextStyle style) {
    return IgnorePointer(
      child: Container(
          height: height,
          child: Column(
            children: <Widget>[],
          )),
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
