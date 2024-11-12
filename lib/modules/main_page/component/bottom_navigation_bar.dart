import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_us/utils/constants.dart';

import '/widgets/capitalized_word.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return SizedBox(
      // height: Platform.isAndroid ?  80 : 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedLabelStyle:
                  const TextStyle(fontSize: 14, color: primaryColor),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: Color(0xff85959E)),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(KImages.homeIcon),
                  activeIcon: SvgPicture.asset(KImages.homeActive),
                  label: Language.home.capitalizeByWord(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(KImages.orderIcon),
                  activeIcon: SvgPicture.asset(KImages.orderActive),
                  label: Language.order.capitalizeByWord(),
                ),
                BottomNavigationBarItem(
                  tooltip: Language.profile.capitalizeByWord(),
                  activeIcon: SvgPicture.asset(KImages.profileActive),
                  icon: SvgPicture.asset(KImages.profileIcon),
                  label: Language.profile.capitalizeByWord(),
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }
}
