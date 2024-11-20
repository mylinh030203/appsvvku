import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.iconColor,
    required this.iconSize,
  });
  final IconData icon;
  final Color? iconColor;
  final double iconSize;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkmode(context);
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: isDark ? Colors.white : Colors.black,
                    offset: const Offset(0.0, 0.0), //Offset
                    blurRadius: 2.0,
                    spreadRadius: 0.0), //BoxShadow
                BoxShadow(color: isDark ? Colors.black : Colors.white, offset: const Offset(0.0, 0.0), blurRadius: 3.0, spreadRadius: 2.0) //BoxShadow
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: isSmall ? AppSize.sm : AppSize.md, vertical: isSmall ? AppSize.sm : AppSize.md),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
        const SizedBox(height: AppSize.xs),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isSmall
                  ? 10
                  : isMedium
                      ? 12
                      : 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
