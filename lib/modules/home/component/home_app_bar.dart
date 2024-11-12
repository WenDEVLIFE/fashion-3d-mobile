import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_us/utils/language_string.dart';
import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../dummy_data/all_dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../cart/controllers/cart/cart_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String logo;

  const HomeAppBar({super.key, this.height = 160, required this.logo});

  @override
  Widget build(BuildContext context) {
    print(RemoteUrls.imageUrl(logo));
    final cartProducts = context.read<CartCubit>();
    return SliverAppBar(
      toolbarHeight: 140.0,
      pinned: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          Row(
            children: [
              //const Spacer(),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomImage(
                    path: "https://admin.extremeassult.online/uploads/website-images/logo-2024-10-29-11-46-29-9387.png",
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.cartScreen),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return CartBadge(
                      count: cartProducts.cartCount.toString(),
                      iconColor: blackColor,
                      badgeColor: Utils.dynamicPrimaryColor(context),
                      //countColor: Utils.dynamicPrimaryColor(context),
                      countColor: white,
                    );
                  },
                ),
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.productSearchScreen),
            child: Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: inputFieldBgColor,
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child:
                          Icon(Icons.search, color: textGreyColor, size: 20.0)),
                  const SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      Language.searchProduct.capitalizeByWord(),
                      style: simpleTextStyle(textGreyColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(124.0);
}

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
    required this.count,
    this.iconColor = white,
    this.badgeColor = lightningYellowColor,
    this.countColor = white,
  });

  final String? count;
  final Color iconColor;
  final Color badgeColor;
  final Color countColor;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        badgeColor: badgeColor,
      ),
      badgeContent: Text(
        count!,
        style: TextStyle(fontSize: 12.0, color: countColor, height: 1.5),
      ),
      child: SvgPicture.asset(KImages.shoppingIcon, color: iconColor),
    );
  }
}

class LocationSelector extends StatefulWidget {
  const LocationSelector({
    super.key,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String selectCity = "Select Location";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomImage(path: KImages.locationIcon),
        const SizedBox(width: 8),
        DropdownButton<String>(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: SvgPicture.asset(KImages.expandIcon, height: 8),
            ),
            underline: const SizedBox(),
            hint: Text(
              selectCity,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            items: dropDownItem
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (v) {
              setState(() {
                selectCity = v!;
              });
            }),
      ],
    );
  }
}
