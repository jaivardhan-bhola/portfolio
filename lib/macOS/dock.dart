import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:html' as html;

import 'package:portfolio/frosted_glass.dart';
import 'package:portfolio/macOS/store.dart';

class Dock extends StatefulWidget {
  final String active;
  final Function(dynamic newActive) onActiveChanged;

  const Dock({super.key, required this.active, required this.onActiveChanged});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  late int? hoveredIndex;
  late double baseItemHeight;
  late double baseTranslationY;
  late double verticlItemsPadding;

  double getScaledSize(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseItemHeight,
      maxValue: 70,
      nonHoveredMaxValue: 50,
    );
  }

  double getTranslationY(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseTranslationY,
      maxValue: -22,
      nonHoveredMaxValue: -14,
    );
  }

  double getPropertyValue({
    required int index,
    required double baseValue,
    required double maxValue,
    required double nonHoveredMaxValue,
  }) {
    late final double propertyValue;

    if (hoveredIndex == null) {
      return baseValue;
    }
    final difference = (hoveredIndex! - index).abs();

    const itemsAffected = 4;

    if (difference == 0) {
      propertyValue = maxValue;
    } else if (difference <= itemsAffected) {
      final ratio = (itemsAffected - difference) / itemsAffected;

      propertyValue = lerpDouble(baseValue, nonHoveredMaxValue, ratio)!;
    } else {
      propertyValue = baseValue;
    }

    return propertyValue;
  }

  @override
  void initState() {
    super.initState();
    hoveredIndex = null;
    baseItemHeight = 50;

    verticlItemsPadding = 10;
    baseTranslationY = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [
      {
        'imgSrc': '/icons/acrobat',
        'onPressed': () {
          html.window.open(
              'https://drive.google.com/file/d/18rltwqG_Tm2paUyemvSNF4HRClGZoYQO/view?usp=sharing',
              'new tab');
        },
      },
      {
        'imgSrc': '/icons/github',
        'onPressed': () {
          html.window
              .open('https://www.github.com/jaivardhan-bhola', 'new tab');
        },
      },
      {
        'imgSrc': '/icons/projects',
        'onPressed': () async {
          widget.onActiveChanged('Projects');
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => MacStore(
                    active: 'Projects',
                    onActiveChanged: (newActive) {
                      widget.onActiveChanged(newActive);
                    },
                  ));
          setState(() {
            widget.onActiveChanged('Finder');
          });
        }
      },
      {
        'imgSrc': '/mac/mail',
        'onPressed': () {
          html.window.open('mailto:jaivardhan.bhola@gmail.com', 'new tab');
        }
      }
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            height: baseItemHeight,
            left: 0,
            right: 0,
            child: FrostedGlassBox(
              width: screenWidth * 0.04,
              height: baseItemHeight,
              sigma: 20,
              borderRadius: screenWidth * 0.002,
              child: Container(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(verticlItemsPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                items.length,
                (index) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: ((event) {
                      setState(() {
                        hoveredIndex = index;
                      });
                    }),
                    onExit: (event) {
                      setState(() {
                        hoveredIndex = null;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      transform: Matrix4.identity()
                        ..translate(
                          0.0,
                          getTranslationY(index),
                          0.0,
                        ),
                      height: getScaledSize(index),
                      width: getScaledSize(index),
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          style: TextStyle(
                            fontSize: getScaledSize(index),
                          ),
                          child: IconButton(
                            onPressed: () {
                              items[index]['onPressed']();
                            },
                            icon: Image(
                                image: Image.asset(
                                        'assets/${items[index]['imgSrc']}.png')
                                    .image),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
