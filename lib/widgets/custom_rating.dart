import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({super.key,required this.count,required this.initial});
  final int count;
  final double initial;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initial,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: count,
      itemSize: 14.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 18.0,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
