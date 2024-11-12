import 'package:flutter/material.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.mainPage, (route) => false);
      },
      child: const Text(
        'Continue as Guest',
        style: TextStyle(
          fontSize: 16,
          height: 1,
          color: deepGreenColor,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
        ),
      ),

      // style: OutlinedButton.styleFrom(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      //   minimumSize: const Size(200, 44),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(4),
      //   ),
      //   side: const BorderSide(color: paragraphColor, width: 1),
      // ),
    );
  }
}
