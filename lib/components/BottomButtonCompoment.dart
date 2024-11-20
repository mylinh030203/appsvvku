import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotttomButtonsCompoment extends StatelessWidget {
  const BotttomButtonsCompoment({
    super.key,
    required this.outLinedOnPress,
    required this.elevatedOnPress,
    required this.outlineString,
    required this.elevatedString,
  });
  final Function() outLinedOnPress;
  final Function() elevatedOnPress;
  final String outlineString;
  final String elevatedString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => outLinedOnPress(),
              child: Text(
                outlineString,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),
          ),
          const SizedBox(width: AppSize.sm),
          Expanded(
            child: ElevatedButton(
              onPressed: () => elevatedOnPress(),
              child: Text(
                elevatedString,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),
          ),
          const SizedBox(width: AppSize.sm),
        ],
      ),
    );
  }
}
