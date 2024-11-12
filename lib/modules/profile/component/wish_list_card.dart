import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../profile_offer/controllers/wish_list/wish_list_cubit.dart';
import '../profile_offer/model/wish_list_model.dart';

class WishListCard extends StatefulWidget {
  const WishListCard({
    super.key,
    required this.product,
  });

  final WishListModel product;

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  @override
  Widget build(BuildContext context) {
    final wishListCubit = context.read<WishListCubit>();

    bool isSelected = wishListCubit.selectedId.contains(widget.product.id);

    final width = MediaQuery.of(context).size.width - 40;
    const double height = 120;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.productDetailsScreen,
            arguments: widget.product.slug);
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: white,
          //border: Border.all(color: primaryColor.withOpacity(0.6)),
          //borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: [
            Container(
              width: 125.0,
              height: height,
              padding: const EdgeInsets.symmetric(vertical: 5.0)
                  .copyWith(right: 6.0),
              // color: Colors.red,
              child: CustomImage(
                path: RemoteUrls.imageUrl(widget.product.thumbImage),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jost(
                      height: 1.4, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  Utils.formatPrice(widget.product.price, context),
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
