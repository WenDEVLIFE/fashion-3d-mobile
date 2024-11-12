import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/profile/controllers/updated_info/updated_info_cubit.dart';
import '/utils/language_string.dart';
import '/utils/utils.dart';
import '/widgets/capitalized_word.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/please_sign_in_widget.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../authentication/controller/login/login_bloc.dart';
import '../home/controller/cubit/home_controller_cubit.dart';
import 'component/profile_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final _className = 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final settingModel = context.read<AppSettingCubit>().settingModel;
    const double appBarHeight = 180;
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    // context.read<UserProfileInfoCubit>().getUserProfileInfo();

    if (userData == null) {
      return const PleaseSignInWidget();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            iconTheme: IconThemeData(color: Utils.dynamicPrimaryColor(context)),
            automaticallyImplyLeading: routeName != RouteNames.mainPage,
            expandedHeight: appBarHeight,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Utils.dynamicPrimaryColor(context),
            ),
            flexibleSpace:
                BlocBuilder<UserProfileInfoCubit, UserProfilenfoState>(
              builder: (context, state) {
                if (state is UpdatedLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is UpdatedLoaded) {
                  return ProfileAppBar(
                    height: appBarHeight,

                    logo:
                        RemoteUrls.imageUrl(settingModel?.setting!.logo ?? ''),
                    userUpdateInfo: state.updatedInfo,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          _buildProfileOptions(context),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }

  SliverPadding _buildProfileOptions(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final homeModel = context.read<HomeControllerCubit>().homeModel;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ElementTile(
              title: Language.yourAddress.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.addressScreen);
              },
              iconPath: KImages.profileLocationIcon,
            ),
            ElementTile(
              title: Language.allCategories.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.allCategoryListScreen,
                    arguments: {
                      "app_bar": homeModel.sectionTitle[0].custom ??
                          homeModel.sectionTitle[0].defaultTitle
                    });
              },
              iconPath: KImages.profileCategoryIcon,
            ),
            ElementTile(
              title: Language.termsCon.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.termsConditionScreen);
              },
              iconPath: KImages.profileTermsConditionIcon,
            ),
            ElementTile(
              title: Language.privacyPolicy.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
              },
              iconPath: KImages.profilePrivacyIcon,
            ),
            ElementTile(
              title: Language.faq,
              press: () {
                Navigator.pushNamed(context, RouteNames.faqScreen);
              },
              iconPath: KImages.profileFaqIcon,
            ),
            ElementTile(
              title: Language.aboutUs.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.aboutUsScreen);
              },
              iconPath: KImages.profileAboutUsIcon,
            ),
            ElementTile(
              title: Language.contactUs.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.contactUsScreen);
              },
              iconPath: KImages.profileContactIcon,
            ),

            BlocConsumer<LoginBloc, LoginModelState>(builder: (context, state) {
              return ElementTile(
                title: Language.logout.capitalizeByWord(),
                press: () {
                  // Navigator.pushReplacementNamed(
                  //     context, RouteNames.authenticationScreen);
                  Utils.showCustomDialog(
                    context,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // const SizedBox(height: 40.0),
                          const SizedBox(
                            height: 120.0,
                            width: 120.0,
                            child: CustomImage(
                                path: KImages.exitImage, color: primaryColor),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            Language.areYouSure.capitalizeByWord(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: blackColor,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'You want to Signout?',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: blackColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              exitButton(() => Navigator.pop(context),
                                  Language.cancel, blackColor),
                              const SizedBox(width: 20.0),
                              exitButton(
                                () {
                                  //Navigator.pop(context);
                                  loginBloc.add(const LoginEventLogout());
                                },
                                Language.logout.capitalizeByWord(),
                                Utils.dynamicPrimaryColor(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                iconPath: KImages.profileLogOutIcon,
              );
            }, listener: (context, state) {
              final logout = state.state;
              if (logout is LoginStateLogOutLoading) {
                Utils.loadingDialog(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, RouteNames.authenticationScreen, (route) => false);
              } else {
                Utils.closeDialog(context);
                if (logout is LoginStateSignOutError) {
                  Utils.errorSnackBar(context, logout.errorMsg);
                } else if (logout is LoginStateLogOut) {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteNames.authenticationScreen, (route) => false);
                  Utils.showSnackBar(context, logout.msg);
                }
              }
            }),
            // ElementTile(
            //   title: "Sign Out",
            //   press: () {
            //     Navigator.pushReplacementNamed(
            //         context, RouteNames.authenticationScreen);
            //   },
            //   iconPath: Kimages.profileLogOutIcon,
            // ),
          ],
        ),
      ),
    );
  }

  Widget exitButton(VoidCallback onTap, String text, Color bgColor) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        minimumSize: MaterialStateProperty.all(const Size(104, 40)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0)
                .copyWith(bottom: 6.0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: white,
          ),
        ),
      ),
    );
  }
}

class ElementTile extends StatelessWidget {
  const ElementTile({
    super.key,
    this.title,
    this.press,
    this.iconPath,
  });

  final String? title;
  final VoidCallback? press;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      onTap: press,
      contentPadding: EdgeInsets.zero,
      leading: CustomImage(
        path: iconPath!,
        height: 20.0,
        color: Utils.dynamicPrimaryColor(context),
      ),
      title: Text(title!,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: buttonTextColor,
          )),
    );
  }
}
