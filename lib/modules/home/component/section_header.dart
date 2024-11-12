import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.color = buttonTextColor,
    this.onTap,
    required this.headerText,
    this.isSeeAll = true,
  });
  final Color? color;
  final String headerText;
  final VoidCallback? onTap;
  final bool isSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: headlineTextStyle(16.0),
          ),
          isSeeAll? InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                Language.seeAll.capitalizeByWord(),
                style: paragraphTextStyle(16.0),
              ),
            ),
          ):const SizedBox(),
        ],
      ),
    );
  }
}
