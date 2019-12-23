import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';
import 'package:project_nash_equilibrium/models/mainpage/bloc.dart';

import 'mainPage/notificationPage.dart';
import 'mainPage/setPage.dart';

class MainPage extends StatefulWidget {
  MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller;

  List<MainPageInterface> get pages => [NotificationPage(), SetPage(), ];

  @override
  void initState() {
    controller = PageController(initialPage: BlocProvider.of<MainPageBloc>(context).state.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<MainPageBloc, MainPageState>(
          builder: (BuildContext context, MainPageState state) {
        int index = 1; //Just some default value
        if (state is ChangedPage) {
          index = state.index;
        }
        return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textTheme.caption.color,
            currentIndex: index,
            onTap: (int) => {
                  controller.animateToPage(int,
                      curve: Interval(0, 1),
                      duration: Duration(milliseconds: 100))
                },
            items: [
              BottomNavigationBarItem(
                  title: Text("Notifications"),
                  icon: Icon(Icons.notifications)),
              BottomNavigationBarItem(
                  title: Text("Workout"), icon: Icon(Icons.accessibility_new)),
              BottomNavigationBarItem(
                  title: Text("Levels"), icon: Icon(Icons.adjust)),
              BottomNavigationBarItem(
                  title: Text("Statistics"),
                  icon: Icon(FontAwesomeIcons.chartLine)),
            ]);
      }),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: PageHelper.buildHeader(context)
            ..add(Expanded(
              child: Stack(children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(),
                  child: PageView(
                      onPageChanged: (pageIndex) {
                        BlocProvider.of<MainPageBloc>(context)
                            .add(PageChanged(pageIndex));
                      },
                      controller: controller,
                      children: pages),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: BlocBuilder(
                    bloc: BlocProvider.of<MainPageBloc>(context),
                    builder: (BuildContext context, MainPageState state) {

                      MainPageState state =
                          BlocProvider.of<MainPageBloc>(context).state;
                      return pages[state.index].buildButton(context);
                    },
                  ),
                )
              ]),
            ))),
    );
  }
}
