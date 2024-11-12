import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../utils/utils.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../cart/controllers/cart/add_to_cart/add_to_cart_cubit.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import 'component/best_seller_grid_view.dart';
import 'component/category_and_list_component.dart';
import 'component/category_grid_view.dart';
import 'component/flash_sale_component.dart';
import 'component/home_app_bar.dart';
import 'component/hot_deal_banner_slider.dart';
import 'component/new_arrival_component.dart';
import 'component/offer_banner_slider.dart';
import 'component/populer_product_component.dart';
import 'controller/cubit/home_controller_cubit.dart';
import 'model/banner_model.dart';
import 'model/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final _className = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is AddToCartStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is AddToCartStateAdded) {
            context.read<CartCubit>().getCartProducts();
            Utils.showSnackBar(context, state.message);
          } else if (state is AddToCartStateError) {
            Utils.errorSnackBar(context, state.message);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: scaffoldBGColor,
          // appBar: HomeAppBar(
          //   logo: context.read<AppSettingCubit>().settingModel!.setting!.logo,
          // ),
          body: BlocBuilder<HomeControllerCubit, HomeControllerState>(
            builder: (context, state) {
              log(state.toString(), name: _className);
              if (state is HomeControllerLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeControllerError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        style: const TextStyle(color: redColor),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          context.read<HomeControllerCubit>().getHomeData();
                        },
                        icon: const Icon(Icons.refresh_outlined),
                      ),
                    ],
                  ),
                );
              }

              if (state is HomeControllerLoaded) {
                return _LoadedHomePage(homeModel: state.homeModel);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class _LoadedHomePage extends StatelessWidget {
  const _LoadedHomePage({
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    final appSetting = context.read<AppSettingCubit>().settingModel!.setting;
    const double appBarHeight = 160;
    final combineBannerList = <BannerModel>[];
    if (homeModel.sliderBannerOne != null) {
      combineBannerList.add(homeModel.sliderBannerOne!);
    }
    if (homeModel.sliderBannerTwo != null) {
      combineBannerList.add(homeModel.sliderBannerTwo!);
    }
    if (homeModel.twoColumnBannerOne != null) {
      combineBannerList.add(homeModel.twoColumnBannerOne!);
    }
    if (homeModel.twoColumnBannerTwo != null) {
      combineBannerList.add(homeModel.twoColumnBannerTwo!);
    }
    // if (homeModel.singleBannerOne != null) {
    //   combineBannerList.add(homeModel.singleBannerOne!);
    // }
    // if (homeModel.singleBannerTwo != null) {
    //   combineBannerList.add(homeModel.singleBannerTwo!);
    // }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        HomeAppBar(
          logo: context.read<AppSettingCubit>().settingModel!.setting!.logo,
        ),
        //const SliverToBoxAdapter(child: SizedBox(height: 20)),
        CategoryGridView(
          homeCategories: homeModel.homeCategories,
          sectionTitle:
              '${homeModel.sectionTitle[0].custom ?? homeModel.sectionTitle[0].defaultTitle}',
        ),

        ///Banner slider start
        if (homeModel.sliderVisibilty is bool ||
            homeModel.sliderVisibilty is int ||
            homeModel.sliderVisibilty is String) ...[
          if (homeModel.sliderVisibilty == true ||
              homeModel.sliderVisibilty == 1 ||
              homeModel.sliderVisibilty == '1') ...[
            SliverToBoxAdapter(
                child: OfferBannerSlider(sliders: homeModel.sliders))
          ],
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        ///Banner slider end
        const SliverToBoxAdapter(child: SizedBox(height: 10)),

        ///popular product slider start
        if (homeModel.popularCategoryVisibilty is bool ||
            homeModel.popularCategoryVisibilty is int ||
            homeModel.popularCategoryVisibilty is String) ...[
          if (homeModel.popularCategoryVisibilty == true ||
              homeModel.popularCategoryVisibilty == 1 ||
              homeModel.popularCategoryVisibilty == '1') ...[
            HorizontalProductComponent(
              productList: homeModel.popularCategoryProducts,
              bgColor: const Color(0xffF6F6F6),
              category:
                  '${homeModel.sectionTitle[1].custom ?? homeModel.sectionTitle[1].defaultTitle}',
              onTap: () => Navigator.pushNamed(
                context,
                RouteNames.allPopulerProductScreen,
                arguments: {
                  'keyword': "popular_category",
                  'app_bar':
                      '${homeModel.sectionTitle[1].custom ?? homeModel.sectionTitle[1].defaultTitle}',
                },
              ),
            ),
          ]
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        ///popular product slider end
        SliverToBoxAdapter(
            child: FlashSaleComponent(flashSale: homeModel.flashSale)),

        if (appSetting!.enableMultivendor == 1) ...[
          if (homeModel.sellerVisibility is bool ||
              homeModel.sellerVisibility is int ||
              homeModel.sellerVisibility is String) ...[
            if (homeModel.sellerVisibility == true ||
                homeModel.sellerVisibility == 1 ||
                homeModel.sellerVisibility == '1') ...[
              BestSellerGridView(
                sellers: homeModel.sellers,
                sectionTitle:
                    '${homeModel.sectionTitle[3].custom ?? homeModel.sectionTitle[3].defaultTitle}',
              )
            ]
          ] else ...[
            const SliverToBoxAdapter(child: SizedBox.shrink())
          ],
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        // ///top rated product slider start
        // if (homeModel.topRatedVisibility is bool ||
        //     homeModel.topRatedVisibility is int ||
        //     homeModel.topRatedVisibility is String) ...[
        //   if (homeModel.topRatedVisibility == true ||
        //       homeModel.topRatedVisibility == 1 ||
        //       homeModel.topRatedVisibility == '1') ...[
        //     CategoryAndListComponent(
        //       productList: homeModel.topRatedProducts,
        //       bgColor: const Color(0xffF6F6F6),
        //       category:
        //           '${homeModel.sectionTitle[3].custom ?? homeModel.sectionTitle[3].defaultTitle}',
        //       onTap: () {
        //         Navigator.pushNamed(
        //           context,
        //           RouteNames.allPopulerProductScreen,
        //           arguments: {
        //             'keyword': "popular_category",
        //             'app_bar':
        //                 '${homeModel.sectionTitle[3].custom ?? homeModel.sectionTitle[3].defaultTitle}'
        //           },
        //         );
        //       },
        //     ),
        //   ]
        // ] else ...[
        //   const SliverToBoxAdapter(child: SizedBox.shrink())
        // ],

        ///top rated product slider end
        // WidthBannerComponent(banner: homeModel.popularCategorySidebarBanner),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),

        if (homeModel.topRatedVisibility is bool ||
            homeModel.topRatedVisibility is int ||
            homeModel.topRatedVisibility is String) ...[
          if (homeModel.topRatedVisibility == true ||
              homeModel.topRatedVisibility == 1 ||
              homeModel.topRatedVisibility == '1') ...[
            CategoryAndListComponent(
              productList: homeModel.topRatedProducts,
              bgColor: const Color(0xffF6F6F6),
              category:
                  '${homeModel.sectionTitle[2].custom ?? homeModel.sectionTitle[2].defaultTitle}',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.allPopulerProductScreen,
                  arguments: {
                    'keyword': "popular_category",
                    'app_bar':
                        '${homeModel.sectionTitle[3].custom ?? homeModel.sectionTitle[3].defaultTitle}'
                  },
                );
              },
            ),
          ]
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        if (homeModel.featuredProductVisibility is bool ||
            homeModel.featuredProductVisibility is int ||
            homeModel.featuredProductVisibility is String) ...[
          if (homeModel.featuredProductVisibility == true ||
              homeModel.featuredProductVisibility == 1 ||
              homeModel.featuredProductVisibility == '1') ...[
            HorizontalProductComponent(
              productList: homeModel.featuredCategoryProducts,
              bgColor: const Color(0xffF6F6F6),
              category:
                  '${homeModel.sectionTitle[5].custom ?? homeModel.sectionTitle[5].defaultTitle}',
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allPopulerProductScreen,
                    arguments: {
                      'keyword': "featured_product",
                      'app_bar':
                          '${homeModel.sectionTitle[5].custom ?? homeModel.sectionTitle[5].defaultTitle}'
                    });
              },
            ),
          ]
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        if (homeModel.newArrivalProductVisibility is bool ||
            homeModel.newArrivalProductVisibility is int ||
            homeModel.newArrivalProductVisibility is String) ...[
          if (homeModel.newArrivalProductVisibility == true ||
              homeModel.newArrivalProductVisibility == 1 ||
              homeModel.newArrivalProductVisibility == '1') ...[
            HorizontalProductComponent(
              productList: homeModel.bestProducts,
              bgColor: const Color(0xffF6F6F6),
              category:
                  '${homeModel.sectionTitle[4].custom ?? homeModel.sectionTitle[4].defaultTitle}',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.allPopulerProductScreen,
                  arguments: {
                    'keyword': "best_product",
                    'app_bar':
                        '${homeModel.sectionTitle[6].custom ?? homeModel.sectionTitle[6].defaultTitle}'
                  },
                );
              },
            ),
          ]
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        SliverToBoxAdapter(
          child: CombineBannerSlider(banners: combineBannerList),
        ),

        if (homeModel.bestProductVisibility is bool ||
            homeModel.bestProductVisibility is int ||
            homeModel.bestProductVisibility is String) ...[
          if (homeModel.bestProductVisibility == true ||
              homeModel.bestProductVisibility == 1 ||
              homeModel.bestProductVisibility == '1') ...[
            NewArrivalComponent(
              productList: homeModel.newArrivalProducts,
              sectionTitle:
                  '${homeModel.sectionTitle[5].custom ?? homeModel.sectionTitle[5].defaultTitle}',
            ),
          ]
        ] else ...[
          const SliverToBoxAdapter(child: SizedBox.shrink())
        ],

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
