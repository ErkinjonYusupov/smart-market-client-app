import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  ListAnimation(
      {super.key, required this.index, required this.child, this.time = 50});
  int index;
  int time;
  Widget child;
  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> {
  bool startAnimation = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        startAnimation = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    startAnimation = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(
          milliseconds:
              300 + (widget.index > 10 ? 1 : widget.index * widget.time)),
      transform: Matrix4.translationValues(
          0, startAnimation ? 0 : MediaQuery.of(context).size.height, 0),
      child: widget.child,
    );
  }
}
