import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/profile/controllers/updated_info/updated_info_cubit.dart';
import '/modules/profile/model/user_info/user_updated_info.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';

class ProfileAppBar extends StatelessWidget {
  final double height;

  const ProfileAppBar({
    super.key,
    this.height = 160,
    required this.userUpdateInfo,
    required this.logo,
  });
  final String logo;
  final UserProfileInfo userUpdateInfo;

  @override
  Widget build(BuildContext context) {
    void gotoNext(String route) => Navigator.pushNamed(context, route);
    final image = context.read<UserProfileInfoCubit>().updatedInfo;
    String profileImage = image.updateUserInfo!.image.isNotEmpty
        ? RemoteUrls.imageUrl(image.updateUserInfo!.image)
        : RemoteUrls.imageUrl(image.defaultImage!.image);

    final List<Map<String, dynamic>> headerItem = [
      {
        "image": KImages.profileOrderIcon,
        "title": Language.other.capitalizeByWord(),
        "on_tap": () => gotoNext(RouteNames.orderScreen)
      },
      {
        "image": KImages.profileCartIcon,
        "title": Language.cart.capitalizeByWord(),
        "on_tap": () => gotoNext(RouteNames.cartScreen)
      },
      {
        "image": KImages.profileofferIcon,
        "title": Language.offers,
        "on_tap": () => gotoNext(RouteNames.flashScreen),
        // "on_tap": () => gotoNext(RouteNames.profileOfferScreen),
      },
      {
        "image": KImages.profileWishListIcon,
        "title": Language.wishlist,
        "on_tap": () => gotoNext(RouteNames.wishlistOfferScreen)
      },
    ];
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildUserInfo(context),
            // Positioned(
            //     top: 40.0,
            //     left: 20.0,
            //     child: CustomImage(
            //       path: RemoteUrls.imageUrl(context
            //           .read<AppSettingCubit>()
            //           .settingModel!
            //           .setting!
            //           .logo),
            //       height: 30,
            //       width: 130,
            //       color: redColor.withOpacity(0.5),
            //     )),
            // Positioned(
            //   top: 32.0,
            //   right: 20.0,
            //   child: Row(
            //     // crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         userUpdateInfo.updateUserInfo!.name,
            //         style: const TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.white),
            //       ),
            //       const SizedBox(width: 10.0),
            //       InkWell(
            //         onTap: () {
            //           // context.read<CountryStateByIdCubit>().stateLoadIdCountryId(userUpdateInfo.updateUserInfo.countryId);
            //           // context.read<CountryStateByIdCubit>().cityLoadIdStateId(userUpdateInfo.updateUserInfo.stateId);
            //
            //           Navigator.pushNamed(
            //             context,
            //             RouteNames.profileEditScreen,
            //           );
            //         },
            //         // child: buildCircleAvatar(),
            //         child: _profileImage(profileImage),
            //       ),
            //     ],
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Container(
                alignment: Alignment.center,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    headerItem.length,
                    (index) => _headerItem(
                      headerItem[index]['image'],
                      headerItem[index]['title'],
                      headerItem[index]['on_tap'],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCircleAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: grayColor,
      backgroundImage: NetworkImage(
          RemoteUrls.imageUrl(userUpdateInfo.updateUserInfo!.image ?? '')),
    );
  }

  Widget _profileImage(String image) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: CustomImage(path: image, fit: BoxFit.cover)),
    );
  }

  Widget _headerItem(String icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: const BoxDecoration(
              color: Color(0xffE8EEF2),
              shape: BoxShape.circle,
            ),
            child: Center(child: CustomImage(path: icon)),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildUserInfo(BuildContext context) {
  //   return const CustomImage(
  //     path: KImages.settingAppBarImage,
  //     fit: BoxFit.cover,
  //   );
  // }
  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: height - 60,
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
              path: RemoteUrls.imageUrl(
                  context.read<AppSettingCubit>().settingModel!.setting!.logo),
              height: 30.0,
              width: 100.0,
             color:Colors.transparent ), // ook n ato?
          Row(
            children: [
              Text(
                userUpdateInfo.updateUserInfo!.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.profileEditScreen);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: grayColor,
                  backgroundImage: NetworkImage(RemoteUrls.imageUrl(
                      userUpdateInfo.updateUserInfo!.image ?? '')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
