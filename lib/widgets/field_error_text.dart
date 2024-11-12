import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.text,
    this.space = 6.0,
  });
  final String text;
  final double space;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: space),
      child: Text(
        "* $text",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: redColor,
            ),
      ),
    );
  }
}
