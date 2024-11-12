import 'package:flutter/material.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      // width: double.infinity,
      decoration: const BoxDecoration(
        color: scaffoldBGColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: TextFormField(
        onTap: () {
          Utils.closeKeyBoard(context);
          Navigator.pushNamed(context, RouteNames.productSearchScreen);
        },
        decoration: inputDecorationTheme.copyWith(
          prefixIcon: Icon(Icons.search_rounded, color: grayColor, size: 20),
          hintText: 'Search Products',
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: grayColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 16,
          ),
          // suffixIconConstraints:
          //     const BoxConstraints(maxHeight: 32, minWidth: 32),
        ),
      ),
    );
  }
}
