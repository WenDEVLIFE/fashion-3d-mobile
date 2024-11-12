import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/details_product_reviews_model.dart';
import 'signle_review_card_component.dart';

class ReviewListComponent extends StatelessWidget {
  const ReviewListComponent(
    this.productReviews, {
    super.key,
  });

  final List<DetailsProductReviewModel> productReviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildRatingHeader(),
          const SizedBox(height: 30),
          ...productReviews.take(3).map((e) => SingleReviewCardComponent(e)),
          if (productReviews.length > 3)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.reviewListScreen,
                  //     arguments: productReviews);
                },
                child: const Text(
                  "See all reviews",
                  style: TextStyle(color: redColor),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildRatingHeader() {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: borderColor,
        //borderRadius: BorderRadius.circular(50.0)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Utils.getRating(productReviews).toStringAsFixed(1),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: Utils.getRating(productReviews),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              // const SizedBox(height: 12),
              Text(
                '${productReviews.length} Review',
                style: const TextStyle(fontSize: 16, color: textGreyColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
