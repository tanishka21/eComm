import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class SettingsMenuTitle extends StatelessWidget {
  const SettingsMenuTitle(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      this.trailing,
      this.onTap});

  final String title, subTitle;
  final IconData image;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        image,
        size: 28,
        color: TColors.primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
