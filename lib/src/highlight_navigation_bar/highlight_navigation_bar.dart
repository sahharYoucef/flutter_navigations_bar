import 'package:flutter/Material.dart';
import './painter.dart';

class HighlightNavigationBar extends StatefulWidget {
  final double height;
  final List<IconButton> icons;
  final Duration duration;
  final Color backgroundColor;
  final Color unselectedIconColor;
  final Color selectedIconColor;
  final Color highLightColor;

  const HighlightNavigationBar({
    Key key,
    @required this.height,
    @required this.icons,
    this.duration = const Duration(milliseconds: 900),
    this.backgroundColor = const Color(0xff2c362f),
    this.unselectedIconColor = Colors.grey,
    this.selectedIconColor = Colors.white, this.highLightColor = Colors.white,
  }) : super(key: key);
  @override
  _HighlightNavigationBarState createState() => _HighlightNavigationBarState();
}

class _HighlightNavigationBarState extends State<HighlightNavigationBar>
    with TickerProviderStateMixin {
  AnimationController _positionController;
  AnimationController _opacityController;
  double shadowPosition = 0.0;
  int currentIndex = 0;
  double margin = 16;

  @override
  void initState() {
    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds))
      ..addStatusListener((AnimationStatus animationStatus) async {
        if (animationStatus == AnimationStatus.forward) {
          _opacityController.forward();
        }
        if (animationStatus == AnimationStatus.completed) {
          setState(() {
            shadowPosition = _positionController.value;
          });
          _opacityController.reverse();
        }
      });
    _opacityController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: (widget.duration.inMilliseconds / 3).floor()));
    super.initState();
  }

  @override
  void didUpdateWidget(HighlightNavigationBar oldWidget) {
    if (widget.icons != oldWidget.icons) {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ...List.generate(
                    widget.icons.length,
                    (index) => Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: widget.icons[index].icon,
                                onPressed: () {
                                  _positionController.animateTo(
                                      1 / widget.icons.length * index);
                                  setState(() {
                                    currentIndex = index;
                                  });
                                  widget.icons[index].onPressed();
                                },
                                color: index == currentIndex
                                    ? widget.selectedIconColor
                                    : widget.unselectedIconColor,
                              )),
                        ))
              ],
            ),
          ),
          Positioned(
            left: shadowPosition *
                    (MediaQuery.of(context).size.width - margin * 2) +
                ((MediaQuery.of(context).size.width - margin * 2) / 8 -
                    widget.height / 2),
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedBuilder(
                animation: _opacityController,
                builder: (context, child) => CustomPaint(
                  painter: LightPainter(animation: _opacityController , color: widget.highLightColor),
                  child: Container(
                    height: widget.height,
                    width:
                        MediaQuery.of(context).size.width / widget.icons.length,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _positionController,
            builder: (context, child) => Positioned(
              left: _positionController.value *
                      (MediaQuery.of(context).size.width - margin * 2) +
                  (MediaQuery.of(context).size.width - margin * 2) /
                      (widget.icons.length * 4),
              child: child,
            ),
            child: Container(
              width:
                  MediaQuery.of(context).size.width / widget.icons.length / 2,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
