import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:flutter/material.dart';

class CertificateDividerWidgets extends StatelessWidget {
  const CertificateDividerWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Divider(
            color: AppColors.gray,
            thickness: 2,
            indent: 35,
            endIndent: 5,
          ),
        ),
        Text(
          "Hoặc",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                color: AppColors.gray,
              ),
        ),
        Flexible(
          child: Divider(
            color: AppColors.gray,
            thickness: 2,
            indent: 5,
            endIndent: 35,
          ),
        ),
      ],
    );
  }
}
