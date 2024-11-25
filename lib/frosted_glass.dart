import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatefulWidget {
  const FrostedGlassBox({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.sigma,
    this.borderRadius = 0.0,
  });

  final double width;
  final double height;
  final Widget child;
  final double sigma;
  final double borderRadius;

  @override
  _FrostedGlassBoxState createState() => _FrostedGlassBoxState();
}

class _FrostedGlassBoxState extends State<FrostedGlassBox> {
  late double height;

  @override
  void initState() {
    super.initState();
    height = widget.height;
  }

  @override
  void didUpdateWidget(FrostedGlassBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      setState(() {
        height = widget.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
        width: widget.width,
        height: height,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.sigma,
                sigmaY: widget.sigma,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.03),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}