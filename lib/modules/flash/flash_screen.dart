/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/remote_urls.dart';
import '/modules/flash/controller/cubit/flash_cubit.dart';
import '/widgets/custom_image.dart';
import '../category/component/product_card.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FlashCubit>().getFalshSale();
    return Scaffold(
        // appBar: AppBar(title: Text('Flash Products'),backgroundColor: Colors.white.withOpacity(0.5),),
        extendBodyBehindAppBar: true,

        body: BlocBuilder<FlashCubit, FlashState>(builder: (context, state) {
          print(state);
          if (state is FlashSaleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashSaleError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FlashSaleLoaded) {
            return Column(children: [
              SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImage(path: RemoteUrls.imageUrl(state.flashModel.flashSale.flashsalePageImage),fit: BoxFit.cover, ),
                    Positioned(
                      left: 10,top: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded,color: Colors.black,),
                      ),),
                    )
                    // Text(state.flashModel.flashSale.title),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 230,
                    ),
                    itemCount: state.flashModel.products.length,
                    itemBuilder: (context,index){
                      return ProductCard(
                          productModel: state.flashModel.products[index]);
                    }

                ),
              )
            ],);
          } else {
            return const SizedBox();
          }
        }));
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/remote_urls.dart';
import '/modules/flash/controller/cubit/flash_cubit.dart';
import '/utils/constants.dart';
import '/widgets/custom_image.dart';
import '../../utils/language_string.dart';
import '../category/component/product_card.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FlashCubit>().getFalshSale();
    // int endTime = DateTime.parse(flashSale.endTime).millisecondsSinceEpoch + 1000 * 30;
    return Scaffold(
        // appBar: AppBar(title: Text('Flash Products'),backgroundColor: Colors.white.withOpacity(0.5),),
        extendBodyBehindAppBar: true,
        backgroundColor: scaffoldBGColor,
        body: BlocBuilder<FlashCubit, FlashState>(builder: (context, state) {
          debugPrint('FLASH SALE SCREEN ${state.toString()}');
          if (state is FlashSaleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashSaleError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FlashSaleLoaded) {
            int endTime = DateTime.parse(state.flashModel.flashSale.endTime)
                    .millisecondsSinceEpoch +
                1000 * 30;
            return Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImage(
                          path: RemoteUrls.imageUrl(
                            state.flashModel.flashSale.flashsalePageImage,
                          ),
                          fit: BoxFit.fill,
                        ),
                        buildCountdownTimer(endTime),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor,
                            // backgroundColor: greenColor.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.angleLeft,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        )
                        // Text(state.flashModel.flashSale.title),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: singleProductHeight + 60.0,
                    ),
                    itemCount: state.flashModel.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          productModel: state.flashModel.products[index]);
                    },
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }

  Widget buildCountdownTimer(int endTime) {
    return CountdownTimer(
      endTime: endTime,
      widgetBuilder: (_, time) {
        if (time == null) {
          return Text(Language.saleOver);
        }
        return Positioned(
          right: 15.0,
          top: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MyCircularProgressCustomValue(
                maxValue: time.days! + 10,
                title: 'Days',
                value: time.days!,
                key: UniqueKey(),
                // color: const Color(0xffEB5757),
                color: Colors.white,
              ),
              const SizedBox(width: 5.0),
              _MyCircularProgressCustomValue(
                maxValue: 24,
                title: 'Hrs',
                value: time.hours!,
                key: UniqueKey(),
                color: const Color(0xff2F80ED),
              ),
              _MyCircularProgressCustomValue(
                maxValue: 60,
                title: 'Min',
                value: time.min!,
                key: UniqueKey(),
                color: const Color(0xff219653),
              ),
              _MyCircularProgressCustomValue(
                maxValue: 60,
                title: 'Sec',
                value: time.sec!,
                key: UniqueKey(),
                color: Colors.white,
                // color: const Color(0xffEB5757),
              ),
            ],
          ),
        );

        // Text(
        //   'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
      },
    );
  }
}

class _MyCircularProgressCustomValue extends StatelessWidget {
  const _MyCircularProgressCustomValue({
    super.key,
    required this.value,
    required this.title,
    required this.maxValue,
    required this.color,
  }) : assert(maxValue > value, "maxValue must be greater then value");
  final int value;
  final String title;
  final int maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // double percent = 1 - (value / maxValue);
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "$value",
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: color),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              height: 1,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
