import 'package:flutter/material.dart';

class DashedLineDividerWidget extends StatelessWidget {
  final double dashHeight;
  final double dashWith;
  final Color dashColor;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;
  final EdgeInsets margin;

  const DashedLineDividerWidget({
    super.key,
    this.dashHeight = 1,
    this.dashWith = 8,
    this.dashColor = Colors.grey,
    this.fillRate = 0.5,
    this.direction = Axis.horizontal,
    this.margin = const EdgeInsets.symmetric(
      vertical: 6,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxSize = direction == Axis.horizontal
              ? constraints.constrainWidth()
              : constraints.constrainHeight();
          final dCount = (boxSize * fillRate / dashWith).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: direction,
            children: List.generate(
              dCount,
              (_) => SizedBox(
                width: direction == Axis.horizontal ? dashWith : dashHeight,
                height: direction == Axis.horizontal ? dashHeight : dashWith,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: dashColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
