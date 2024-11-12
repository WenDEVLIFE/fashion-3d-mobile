import 'package:flutter/material.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';

class EmptyOrderComponent extends StatelessWidget {
  const EmptyOrderComponent(
      {super.key, this.iconColor = primaryColor, this.emptySubTitle});

  final Color iconColor;
  final String? emptySubTitle;

  @override
  Widget build(BuildContext context) {
    final text = emptySubTitle ?? Language.noCartItem.capitalizeByWord();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            CustomImage(path: KImages.emptyOrder, color: iconColor),
            const SizedBox(height: 34),
            Text(
              Language.noItemsFound.capitalizeByWord(),
              style: headlineTextStyle(22.0),
            ),
            const SizedBox(height: 9),
            Text(
              text,
              textAlign: TextAlign.center,
              style: paragraphTextStyle(16.0),
            ),
            const SizedBox(height: 30),
            // SizedBox(
            //   width: 200,
            //   child: PrimaryButton(
            //     text: 'Order Products Now',
            //     onPressed: () {},
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
