import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '/widgets/field_error_text.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../order/model/product_order_model.dart';
import 'controller/review/review_cubit.dart';

class SubmitFeedBackScreen extends StatefulWidget {
  const SubmitFeedBackScreen({super.key, required this.orderItem});
  final OrderedProductModel orderItem;

  @override
  State<SubmitFeedBackScreen> createState() => _SubmitFeedBackScreenState();
}

class _SubmitFeedBackScreenState extends State<SubmitFeedBackScreen> {
  final _reviewTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _reviewTextController.dispose();
  }

  final _className = 'SubmitFeedBackScreen';
  double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitReviewCubit, ReviewSubmitState>(
      listener: (context, state) {
        if (state is SubmitReviewStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is SubmitReviewStateError) {
            Utils.errorSnackBar(context, state.errorMessage);
          } else if (state is SubmitReviewStateLoaded) {
            if (state.submitReviewResponseModel.status == 0) {
              Utils.showSnackBar(
                  context, state.submitReviewResponseModel.message);
              Navigator.of(context).pop();
            }
            // else {
            //   Utils.showCustomDialog(context, child: const FeedbackSuccess());
            // }
          }
        }
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          bgColor: Colors.white,
          titleText: Language.backToShop,
          textColor: grayColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // FeedbackProductCard(product: populerProductList.first),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  // color: bgGreyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomImage(
                    //   path: RemoteUrls.imageUrl(widget.orderItem.thumbImage),
                    //   height: 85,
                    //   width: 90,
                    //   fit: BoxFit.cover,
                    // ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orderItem.productName.capitalizeByWord(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              height: 1.3,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'X ${widget.orderItem.qty}',
                            style: GoogleFonts.inter(
                                color: grayColor.withOpacity(.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Text(
                Language.writeYourReviews,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text('${Language.whatIsYourRate} ?',
                  style: GoogleFonts.inter(fontSize: 18)),
              const SizedBox(height: 13),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 28,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {
                  ratingValue = rating;
                },
              ),
              const SizedBox(height: 45),
              Align(
                alignment: Alignment.topLeft,
                child: Text(Language.writeYourReviews,
                    style: GoogleFonts.inter(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 7),
              BlocBuilder<SubmitReviewCubit, ReviewSubmitState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SubmitReviewFormValidate
                      TextFormField(
                        maxLines: null,
                        minLines: 5,
                        controller: _reviewTextController,
                        decoration: InputDecoration(
                          hintText:
                              Language.pleaseWriteSomething.capitalizeByWord(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                                color: Utils.dynamicPrimaryColor(context)),
                          ),
                        ),
                      ),
                      if (state is SubmitReviewFormValidate) ...[
                        if (state.errors.review.isNotEmpty)
                          ErrorText(text: state.errors.review.first),
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 55),
              BlocBuilder<SubmitReviewCubit, ReviewSubmitState>(
                builder: (context, state) {
                  if (state is ReviewStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return PrimaryButton(
                    text: Language.submitReview,
                    onPressed: submit,
                  );
                },
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  Language.notNow.capitalizeByWord(),
                  style: GoogleFonts.roboto(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    late Map<String, dynamic> map = {};
    // if (_reviewTextController.text.isEmpty) {
    //   Utils.errorSnackBar(
    //       context, Language.pleaseWriteSomething.capitalizeByWord());
    // }

    Utils.closeKeyBoard(context);
    map['rating'] = ratingValue.toString();
    map['review'] = _reviewTextController.text;
    map['product_id'] = widget.orderItem.productId.toString();
    map['seller_id'] = widget.orderItem.sellerId.toString();
    log(map.toString(), name: _className);

    context.read<SubmitReviewCubit>().submitReview(map);
    _reviewTextController.clear();
  }
}
