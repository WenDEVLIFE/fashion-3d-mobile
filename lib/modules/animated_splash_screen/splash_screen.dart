import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/router_name.dart';
import '/utils/constants.dart';
import '/utils/k_images.dart';
import '/widgets/custom_image.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'controller/app_setting_cubit/app_setting_cubit.dart';
import 'widgets/setting_error_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appSettingCubit = context.read<AppSettingCubit>();
    //print('color is ${appSettingCubit.settingModel!.setting!.themeOne}');
    final loginBloc = context.read<LoginBloc>();
    // if (appSettingCubit.settingModel!.setting!.themeOne.isNotEmpty) {
    //   debugPrint('dynamic-color-not-null');
    //   bgColor = Utils.dynamicPrimaryColor(context);
    // } else {
    //   debugPrint('dynamic-color-null');
    //   bgColor = primaryColor;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Utils.dynamicPrimaryColor(context),
      body: BlocConsumer<AppSettingCubit, AppSettingState>(
        builder: (BuildContext context, state) {
          if (state is AppSettingStateError) {
            return SettingErrorWidget(message: state.meg);
          }
          return _buildBodyComponent(size);
        },
        listener: (context, state) {
          log("listener $state", name: 'Splash Screen');
          if (state is AppSettingStateLoaded) {
            log(state.toString(), name: 'loaded');
            if (state.settingModel.maintainTextModel!.status == 0) {
              if (loginBloc.isLogedIn) {
                Navigator.pushReplacementNamed(context, RouteNames.mainPage);
              } else if (appSettingCubit.isOnBoardingShown) {
                Navigator.pushReplacementNamed(
                    context, RouteNames.authenticationScreen);
              } else {
                Navigator.pushReplacementNamed(
                    context, RouteNames.onBoardingScreen);
              }
            } else {
              Navigator.pushReplacementNamed(context, RouteNames.errorScreen);
            }
          }
        },
      ),
    );
  }

  Widget _buildBodyComponent(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Container(
            height: size.height * 0.6,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: const CustomImage(
                path: KImages.logo,
                width: 306.0,
                height: 222.0),
          ),
          Container(
            height: size.height * 0.4,
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomImage(
                    path: KImages.logoName,
                    width: 200.0,
                    height: 35.0,
                    color: const Color(0xFFFFFAFE).withOpacity(0.7)),
                Text(
                  'Buy groceries and feed yourself',
                  style: GoogleFonts.inter(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
