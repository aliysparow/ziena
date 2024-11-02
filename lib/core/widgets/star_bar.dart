import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/extensions.dart';

class CustomStarBar extends StatelessWidget {
  final double initialRating;
  final double? size;
  final EdgeInsetsGeometry? itemPadding;
  final void Function(double)? onRatingUpdate;
  const CustomStarBar({super.key, required this.initialRating, this.itemPadding, this.onRatingUpdate, this.size});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: initialRating,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: size ?? 40.h,
      ignoreGestures: onRatingUpdate == null,
      ratingWidget: RatingWidget(
        empty: Icon(
          CupertinoIcons.star,
          size: size,
          color: context.indicatorColor,
        ),
        half: Icon(
          CupertinoIcons.star_lefthalf_fill,
          size: size,
          color: context.indicatorColor,
        ),
        full: Icon(
          CupertinoIcons.star_fill,
          size: size,
          color: context.indicatorColor,
        ),
      ),
      itemPadding: itemPadding ?? EdgeInsets.zero,
      onRatingUpdate: (rating) {
        onRatingUpdate?.call(rating);
      },
    );
  }
}
