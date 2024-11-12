import 'package:shop_us/widgets/capitalized_word.dart';

import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import 'onboarding_model.dart';

final onBoardingList = [
  OnBordingModel(
    image: KImages.onBoarding01,
    title: Language.onBoardingTitle1.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
  OnBordingModel(
    image: KImages.onBoarding02,
    title: Language.onBoardingTitle2.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
  OnBordingModel(
    image: KImages.onBoarding03,
    title: Language.onBoardingTitle3.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
  // OnBordingModel(
  //   image: KImages.onBoardingLocation,
  //   title: Language.enabledLocation.capitalizeByWord(),
  //   paragraph:
  //       Language.onBoardingSubTitle,
  // ),
];
