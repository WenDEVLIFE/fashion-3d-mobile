import '../modules/category/single_category_product_screen.dart';
import 'router_package_names.dart';

class RouteNames {
  static const String splashScreen = '/';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String mainPage = '/mainPage';
  static const String homeScreen = '/homeScreen';
  static const String authenticationScreen = '/authenticationScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setpasswordScreen = '/setpasswordScreen';
  static const String allCategoryListScreen = '/allCategoryListScreen';
  static const String allSellerList = '/allSellerList';
  static const String allPopulerProductScreen = '/allPopulerProductScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String messageScreen = '/messageScreen';
  static const String chatListScreen = '/chatListScreen';
  static const String singleCategoryProductScreen =
      '/singleCategoryProductScreen';
  static const String brandProductScreen = '/brandProductScreen';
  static const String subCategoryProductScreen = '/subCategoryProductScreen';
  static const String orderScreen = '/orderScreen';
  static const String singleOrderScreen = '/singleOrder';
  static const String settingScreen = '/settingScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String profileEditScreen = '/profileEditScreen';
  static const String profileOfferScreen = '/profileOfferScreen';
  static const String wishlistOfferScreen = '/wishlistOfferScreen';
  static const String addAddressScreen = '/addAddressScreen';
  static const String addNewPaymentCardScreen = '/addNewPaymentCardScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String submitFeedBackScreen = '/submitFeedBackScreen';
  static const String addressScreen = '/addressScreen';
  static const String paymentsScreen = '/paymentsScreen';
  static const String productSearchScreen = '/productSearchScreen';
  static const String allFlashDealProductScreen = '/allFlashDealProductScreen';
  static const String reviewListScreen = '/reviewListScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String placeOrderScreen = '/placeOrderScreen';
  static const String paypalScreen = '/paypalScreen';
  static const String razorpayScreen = '/razorpayScreen';
  static const String flutterWaveScreen = '/flutterWaveScreen';
  static const String sslCommerceScreen = '/sslCommerceScreen';
  static const String molliePaymentScreen = '/molliePaymentScreen';
  static const String instamojoPaymentScreen = '/instamojoPaymentScreen';
  static const String paystackPaymentScreen = '/paystackPaymentScreen';
  static const String stripeScreen = '/stripeScreen';
  static const String bankScreen = '/bankScreen';
  static const String flashScreen = '/flashScreen';
  static const String bestSellerScreen = '/bestSellerScreen';
  static const String profileScreen = '/profileScreen';
  static const String errorScreen = '/errorScreen';
  static const String editAddressScreen = '/editAddressScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());
      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.productSearchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProductSearchScreen());

      case RouteNames.profileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());

      case RouteNames.editAddressScreen:
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            settings: settings, builder: (_) => EditAddressScreen(map: map));

      case RouteNames.errorScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ErrorScreen());

      case RouteNames.mainPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainPage());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotScreen());
      case RouteNames.verificationCodeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VerificationCodeScreen());
      case RouteNames.setpasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SetpasswordScreen());

      case RouteNames.allCategoryListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryListScreen());

      case RouteNames.allSellerList:
        final sellerList = settings.arguments as List<HomeSellerModel>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AllSellerList(sellers: sellerList));

      case RouteNames.bestSellerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BestSellerInformation());

      case RouteNames.allPopulerProductScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AllPopularProductScreen());
      case RouteNames.singleCategoryProductScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SingleCategoryProductScreen(),
        );
      case RouteNames.brandProductScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BrandProductScreen(slug: slug),
        );

      case RouteNames.subCategoryProductScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SubCategoryProductScreen(slug: slug),
        );
      case RouteNames.allFlashDealProductScreen:
        final products = settings.arguments as List<ProductModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllFlashDealProductScreen(products: products),
        );
      case RouteNames.notificationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NotificationScreen());
      case RouteNames.messageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MessageScreen());
      case RouteNames.chatListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChatListScreen());
      case RouteNames.orderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OrderScreen());
      case RouteNames.singleOrderScreen:
        final trackNumber = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SingleOrderDetails(trackNumber: trackNumber));
      case RouteNames.settingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());
      case RouteNames.termsConditionScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TermsConditionScreen());
      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutUsScreen());
      case RouteNames.contactUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsScreen());
      case RouteNames.profileEditScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileEditScreen());
      case RouteNames.profileOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileOfferScreen());
      case RouteNames.wishlistOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistOfferScreen());
      case RouteNames.paymentsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentsScreen());
      case RouteNames.addressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AddressScreen());
      case RouteNames.addAddressScreen:
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AddAddressScreen());
      case RouteNames.addNewPaymentCardScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AddNewPaymentCardScreen());
      case RouteNames.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
      case RouteNames.checkoutScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CheckoutScreen());
      case RouteNames.productDetailsScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetailsScreen(slug: slug));
      case RouteNames.reviewListScreen:
        final productReviews =
            settings.arguments as List<DetailsProductReviewModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SeelAllReviewsScreen(productReviews: productReviews),
        );

      case RouteNames.submitFeedBackScreen:
        final orderItem = settings.arguments as OrderedProductModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SubmitFeedBackScreen(orderItem: orderItem),
        );

      case RouteNames.placeOrderScreen:
        // final shippingMethod = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PlaceOrderScreen(),
        );

      case RouteNames.paypalScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaypalScreen(url: paypalUrl),
        );
      case RouteNames.razorpayScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RazorpayScreen(url: paypalUrl),
        );
      case RouteNames.flutterWaveScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FlutterWaveScreen(url: paypalUrl),
        );
      case RouteNames.molliePaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MolliePaymentScreen(url: paypalUrl),
        );
      case RouteNames.instamojoPaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => InstamojoPaymentScreen(url: paypalUrl),
        );
      case RouteNames.paystackPaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaystackPaymentScreen(url: paypalUrl),
        );
      case RouteNames.sslCommerceScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SslCommerceScreen(url: paypalUrl),
        );
      case RouteNames.stripeScreen:
        final body = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StripeScreen(mapBody: body),
        );

      case RouteNames.bankScreen:
        final body = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BankPaymentScreen(mapBody: body),
        );

      case RouteNames.flashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FlashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
