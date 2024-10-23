import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  TCircularContainer({
    super.key,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = TColors.white,
    this.width = 400,
    this.margin,
    this.child,
    this.height = 400,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,

      ),
      child: child,
    );
  }
}
