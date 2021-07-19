import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  LoadingScreen({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = Center(
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 30.0,
                    width: 30.0,
                  ),
                )));
      } else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset.dx,
          top: offset.dy,
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
