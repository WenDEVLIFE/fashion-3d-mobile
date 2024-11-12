import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'controller/login/login_bloc.dart';
import 'controller/sign_up/sign_up_bloc.dart';
import 'widgets/sign_in_form.dart';
import 'widgets/sign_up_form.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    final size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginModelState>(
          listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            if (state.state is LoginStateError) {
              final status = state.state as LoginStateError;

              if (status.statusCode == 402) {
                Utils.showSnackBarWithAction(
                  context,
                  status.errorMsg,
                  () {
                    context
                        .read<LoginBloc>()
                        .add(const SentAccountActivateCodeSubmit());
                    Navigator.pushNamed(
                        context, RouteNames.verificationCodeScreen);
                  },
                );
              } else {
                Utils.errorSnackBar(context, status.errorMsg);
              }
            } else if (state.state is LoginStateLoaded) {
              Navigator.pushReplacementNamed(context, RouteNames.mainPage);
            } else if (state.state is SendAccountCodeSuccess) {
              final messageState = state.state as SendAccountCodeSuccess;
              Utils.showSnackBar(context, messageState.msg);
            } else if (state.state is AccountActivateSuccess) {
              final messageState = state.state as AccountActivateSuccess;
              Utils.showSnackBar(context, messageState.msg);
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<SignUpBloc, SignUpModelState>(
          listenWhen: (previous, current) {
            return previous.state != current.state;
          },
          listener: (context, state) {
            if (state.state is SignUpStateLoadedError) {
              final status = state.state as SignUpStateLoadedError;
              Utils.errorSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateFormError) {
              final status = state.state as SignUpStateFormError;
              Utils.showSnackBar(context, status.errorMsg);
            } else if (state.state is SignUpStateLoaded) {
              final loadedData = state.state as SignUpStateLoaded;
              Navigator.pushNamed(context, RouteNames.verificationCodeScreen);
              Utils.showSnackBar(context, loadedData.msg);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  //fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0.0,
                      child: AnimatedContainer(
                        duration: kDuration,
                        height: size.height * 0.38,
                        width: size.width,
                        child: CustomImage(
                          path: _currentPage == 0
                              ? KImages.signInBgImage
                              : KImages.signUpInBgImage,
                          fit: BoxFit.cover,
                          width: size.width,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.23,
                      // bottom: size.height * 0.1,
                      child: Container(
                        // height: 590.0,
                        width: size.width,
                        padding: const EdgeInsets.only(top: 10.0),
                        decoration: const BoxDecoration(
                          color: white,
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(34.0),
                          //   topRight: Radius.circular(34.0),
                          // ),
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHeader(),
                            _buildTabText(),
                            pageView(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pageView() {
    return SizedBox(
      // height: 500.0,
      child: ExpandablePageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: const [SigninForm(), SignUpForm()],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      padding: const EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      duration: kDuration,
      child: Text(
        _currentPage == 0
            ? Language.welcomeToProfile.capitalizeByWord()
            : Language.createAccount.capitalizeByWord(),
        style: GoogleFonts.jost(
            fontWeight: FontWeight.w700, fontSize: 30.0, color: blackColor),
      ),
    );
  }

  Widget _buildTabText() {
    const unSelectedTabColor = Color(0xff797979);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _pageController.animateToPage(0,
                duration: kDuration, curve: Curves.bounceInOut),
            child: Text(
              Language.login.capitalizeByWord(),
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _currentPage == 0 ? blackColor : unSelectedTabColor,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 18,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: textGreyColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.0),
                bottom: Radius.circular(15.0),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          InkWell(
            onTap: () => _pageController.animateToPage(1,
                duration: kDuration, curve: Curves.bounceInOut),
            child: Text(
              Language.singUp.capitalizeByWord(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _currentPage == 1 ? blackColor : unSelectedTabColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
