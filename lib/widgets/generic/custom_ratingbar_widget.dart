import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'
    show RatingBar, RatingWidget;

import '../../config/constants.dart' show ColorConstants;

class CustomRatingBar extends StatelessWidget {
  final double initial;
  final Function(double) onRatingUpdate;
  final bool isWhite;
  final double itemSize;
  final bool tap;
  final Color? color;
  const CustomRatingBar({
    super.key,
    required this.initial,
    required this.onRatingUpdate,
    this.isWhite = false,
    this.itemSize = 13,
    this.tap = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color color1 = !isWhite ? ColorConstants.primary : Colors.white;
    return RatingBar(
      itemCount: 5,
      initialRating: initial,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star,
          color: color ?? color1,
        ),
        half: Icon(
          Icons.star_half,
          color: color ?? color1,
        ),
        empty: Icon(
          Icons.star_border,
          color: color ?? color1,
        ),
      ),
      ignoreGestures: tap,
      itemSize: itemSize,
      onRatingUpdate: onRatingUpdate,
    );
  }
}
