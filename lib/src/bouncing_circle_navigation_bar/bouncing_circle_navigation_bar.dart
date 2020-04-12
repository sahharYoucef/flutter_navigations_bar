import './painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'clip_shadow_path.dart';
import 'painter.dart';

class BouncingCircleNavigationBar extends StatefulWidget {
  final Function(int) onchanged;
  final Color iconColor;
  final List<NavigationBarItem> icons;
  final Color barColor;
  final Color circleColor;
  final BoxShadow boxShadow;
  final Gradient gradient;
  final double margin;
  final double height;

  const BouncingCircleNavigationBar({
    Key key,
    @required this.onchanged,
    this.iconColor = Colors.white,
    @required this.icons,
    this.barColor = Colors.amber,
    this.circleColor = Colors.cyan,
    this.boxShadow,
    this.gradient,
    this.margin = 0.0,
    this.height = 70,
  }) : super(key: key);
  @override
  _BouncingCircleNavigationBarState createState() =>
      _BouncingCircleNavigationBarState();
}

class _BouncingCircleNavigationBarState extends State<BouncingCircleNavigationBar>
    with SingleTickerProviderStateMixin {
  double value;
  double newPosition;
  AnimationController _animationController;
  Animation _animation;

  List<bool> selected = [];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    final Animation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animation = Tween<double>(
      begin: 0,
      end: -33,
    ).animate(curve);
    _animationController.forward();
    selected = List.generate(widget.icons.length, (index) {
      if (index == 0) {
        return true;
      } else
        return false;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(BouncingCircleNavigationBar oldWidget) {
    if (oldWidget.icons != widget.icons) {
      selected = List.generate(widget.icons.length, (index) {
        if (index == 0) {
          return true;
        } else
          return false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    value = ((MediaQuery.of(context).size.width - widget.margin * 2) /
            widget.icons.length) /
        2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          ClipShadowPath(
            shadow: widget.boxShadow ??
                BoxShadow(
                  color: Colors.transparent,
                ),
            clipper: BottomBarClipper(
                newPosition ??
                    ((MediaQuery.of(context).size.width - widget.margin * 2) /
                            widget.icons.length) /
                        2,
                MediaQuery.of(context).size.width / widget.icons.length),
            child: Container(
              decoration: BoxDecoration(
                  color: widget.barColor,
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(16)),
              width: MediaQuery.of(context).size.width,
              height: widget.height,
              alignment: Alignment.center,
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            child: CustomPaint(
              painter: CirclePainter(widget.circleColor),
              child: Container(
                height: MediaQuery.of(context).size.width / widget.icons.length,
                width: MediaQuery.of(context).size.width / widget.icons.length,
              ),
            ),
            builder: (BuildContext context, Widget child) {
              return Positioned(
                top: _animation.value - 5,
                bottom: 0,
                left: newPosition ?? value,
                child: child,
              );
            },
          ),
          ...widget.icons
              .asMap()
              .map((index, NavigationBarItem barIcon) {
                return MapEntry(
                    index,
                    _SpecialIcon(
                        iconColor: widget.iconColor,
                        selected: selected[index],
                        icon: barIcon.icon,
                        text: barIcon.lable,
                        position: value * (index + 1) +
                            MediaQuery.of(context).size.width /
                                widget.icons.length /
                                2 *
                                index + 5,
                        onPressed: () {
                          setState(() {
                            if (!selected[index]) {
                              _animationController.reset();
                              _animationController.forward();
                              selected = selected
                                  .asMap()
                                  .map((i, f) {
                                    if (i == index) {
                                      return MapEntry(i, true);
                                    } else
                                      return MapEntry(i, false);
                                  })
                                  .values
                                  .toList();
                              // widget.onchanged(index);
                            }
                            newPosition = value * (index + 1) +
                                MediaQuery.of(context).size.width /
                                    widget.icons.length /
                                    2 *
                                    index;
                          });
                          barIcon.onPressed();
                        }));
              })
              .values
              .toList(),
        ],
      ),
    );
  }
}

class _SpecialIcon extends StatelessWidget {
  final bool selected;
  final double position;
  final Color iconColor;
  final Function onPressed;
  final Widget icon;
  final String text;

  const _SpecialIcon({
    Key key,
    this.selected,
    this.position,
    this.iconColor,
    this.onPressed,
    this.icon,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      top: selected ? -30 : 25,
      left: position,
      width: 60,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: icon,
            onPressed: onPressed,
          ),
          SizedBox(
            height: 27,
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: selected
                ? Text(
                    '$text',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          )
        ],
      ),
    );
  }
}

class NavigationBarItem {
  final Widget icon;
  final Function onPressed;
  final String lable;

  NavigationBarItem({this.icon, this.onPressed, this.lable});
}
