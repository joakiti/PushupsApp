import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/helpers/TextStyleProvider.dart';
import 'package:project_nash_equilibrium/models/sets/set_level.dart';
import "package:flare_flutter/flare_actor.dart" as flare;

typedef ChangeConfig(int day, int level);

/// This widget displays the single menu section of the [MainMenuWidget].
///
/// There are three main sections, as loaded from the menu.json file in the
/// assets folder.
/// Each section has a backgroundColor, an accentColor, a background Flare asset,
/// and a list of elements it needs to display when expanded.
///
/// Since this widget expands and contracts when tapped, it needs to maintain a [State].
class MenuSection extends StatefulWidget {
  final Color backgroundColor;
  final Color accentColor;
  final Color borderColor;
  final Function entryColor;
  final SetLevel setLevel;
  final ChangeConfig navigateTo;

  MenuSection(
      this.backgroundColor, this.accentColor, this.borderColor, this.setLevel, this.navigateTo,
      {Key key, this.entryColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SectionState();
}

/// This [State] uses the [SingleTickerProviderStateMixin] to add [vsync] to it.
/// This allows the animation to run smoothly and avoids consuming unnecessary resources.
class _SectionState extends State<MenuSection>
    with SingleTickerProviderStateMixin {
  /// The [AnimationController] is a Flutter Animation object that generates a new value
  /// whenever the hardware is ready to draw a new frame.
  AnimationController _controller;
  ScrollController _scrollController = new ScrollController();

  void _goToElement(int index) {
    _controller.animateTo((100.0 * index),
        // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  /// Since the above object interpolates only between 0 and 1, but we'd rather apply a curve to the current
  /// animation, we're providing a custom [Tween] that allows to build more advanced animations, as seen in [initState()].
  static final Animatable<double> _sizeTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  /// The [Animation] object itself, which is required by the [SizeTransition] widget in the [build()] method.
  Animation<double> _sizeAnimation;

  /// Detects which state the widget is currently in, and triggers the animation upon change.
  bool _isExpanded = false;

  /// Here we initialize the fields described above, and set up the widget to its initial state.
  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    /// This curve is controlled by [_controller].
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    /// [_sizeAnimation] will interpolate using this curve - [Curves.fastOutSlowIn].
    _sizeAnimation = _sizeTween.animate(curve);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Whenever a tap is detected, toggle a change in the state and move the animation forward
  /// or backwards depending on the initial status.
  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    switch (_sizeAnimation.status) {
      case AnimationStatus.completed:
        _controller.reverse();
        break;
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  /// This method wraps the whole widget in a [GestureDetector] to handle taps appropriately.
  ///
  /// A custom [BoxDecoration] is used to render the rounded rectangle on the screen, and a
  /// [MenuVignette] is used as a background decoration for the whole widget.
  ///
  /// The [SizeTransition] opens up the section and displays the list underneath the section title.
  ///
  /// Each section sub-element is wrapped into a [GestureDetector] too so that the Timeline can be displayed
  /// when that element is tapped.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _toggleExpand();
        },
        child: Container(
            decoration: BoxDecoration(
              border: widget.borderColor != null ? Border.all(color: widget.borderColor, width: 3) : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: 3.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      3.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(20.0),
                color: widget.backgroundColor),
            child: Stack(
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "LEVEL " + widget.setLevel.level.toString(),
                              style: TextStyleProvider.bold(20),
                            ),
                          ),
                          Align(alignment: Alignment.centerRight,
                            child: Container(
                              height: 25.0,
                              width: 25.0,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: Colors.grey.withOpacity(0.4)),

                              /// Another [FlareActor] widget that
                              /// you can experiment with here: https://www.2dimensions.com/a/pollux/files/flare/expandcollapse/preview
                              child: flare.FlareActor(
                                  "assets/flare/ExpandCollapse.flr",
                                  color: Theme.of(context).primaryColor,
                                  animation: _isExpanded ? "Collapse" : "Expand"),
                            ),
                          ),
                        ],
                      )),
                  SizeTransition(
                      sizeFactor: _sizeAnimation,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white10),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 20.0, top: 15),
                              child: Column(
                                  children: widget.setLevel.sets
                                      .asMap()
                                      .map((dayZero, item) {
                                        int dayOne = dayZero + 1;
                                        return MapEntry(
                                            dayZero,
                                            GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () => widget.navigateTo(dayOne, widget.setLevel.level),
                                                child: Container(
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      bottom: 14.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: Colors.white10),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            30),
                                                                child: Text(
                                                                  "DAY " +
                                                                      dayOne
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      color: widget.entryColor(dayOne),
                                                                      fontSize:
                                                                          20.0,
                                                                      fontFamily:
                                                                          "RobotoMedium"),
                                                                ))),
                                                        Expanded(
                                                            child: Container(
                                                                child: Text(
                                                          item.toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: widget.entryColor(dayOne),
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  "RobotoMedium"),
                                                        ))),
                                                        Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Image.asset(
                                                                "assets/flare/right_arrow.png",
                                                                color: widget
                                                                    .accentColor,
                                                                height: 22.0,
                                                                width: 22.0))
                                                      ]),
                                                )));
                                      })
                                      .values
                                      .toList()))))
                ]),
              ],
            )));
  }
}
