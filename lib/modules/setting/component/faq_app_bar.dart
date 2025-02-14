import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class FaqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const FaqAppBar({
    super.key,
    this.onTap,
    this.height = 82,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height - 20,
                decoration: const BoxDecoration(
                  color: scaffoldBGColor,
                ),
              ),
            /*  Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: TextFormField(
                    decoration: inputDecorationTheme.copyWith(
                      prefixIcon: const Icon(Icons.search, size: 26),
                      hintText: 'Search Name...',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
