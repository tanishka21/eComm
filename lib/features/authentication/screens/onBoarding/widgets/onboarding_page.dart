import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../controllers/onBoarding/onBoarding_controller.dart';
import 'onboarding_do_navigation.dart';
import 'onboarding_next_button.dart';
import 'onboarding_skipbutton.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(onBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              ///Horizontal Scrollable pages
              onBoardingPage(
                image: TImages.onBoardingPage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              onBoardingPage(
                image: TImages.onBoardingPage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              onBoardingPage(
                image: TImages.onBoardingPage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          ///Skip button added for the top of the app
          onBoardingSkipButton(),

          ///Dot Navigation SmoothPageIndicator
          ///
          onBoardingDotNavigation(),

          ///Circular Button
          onBoardingNextButton()
        ],
      ),
    );
  }
}



class onBoardingPage extends StatelessWidget {
  const onBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Padding(
          padding: EdgeInsets.all(
            (TSizes.defaultSpace),
          ),
          child: Column(
            children: [
              Image(
                width: THelperFunction.screenWidth() * 0.8,
                height: THelperFunction.screenHeight() * 0.6,
                image: AssetImage(image),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
