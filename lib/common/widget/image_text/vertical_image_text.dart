import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = (THelperFunction.isDarkMode(context));
    return GestureDetector(
      // onTap: () {
      //   print("j hckjd");
      //   Get.to(() => SubCategoriesScreen());
      // },
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Text
            SizedBox(
              height: 20,
              width: 45,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 56,
              height: 56,
              padding: EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? TColors.white : TColors.black),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  color: dark ? TColors.dark : TColors.light,
                ),
              ),
            ),

            ///  Text
            // SizedBox(
            //   height: TSizes.spaceBtwItems / 2,
            // ),
          ],
        ),
      ),
    );
  }
}
