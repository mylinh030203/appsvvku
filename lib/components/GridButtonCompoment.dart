import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppImageString.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';

import 'package:flutter/material.dart';

class ChosseSendProofWidget extends StatelessWidget {
  const ChosseSendProofWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> listIcon = [
      [AppImage.iconChungchiNgoainguSGV, "Xác nhận chứng chỉ\nNgoại Ngữ"],
      [AppImage.iconChungchiQuocphongSGV, "Xác nhận chứng chỉ\nQuốc Phòng"],
      [AppImage.iconChungchiThechatSGV, "Xác nhận chứng chỉ\nThể chất"],
      [AppImage.iconChungchiTinhocSGV, "Xác nhận chứng chỉ\nTin học"],
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.black,
              title: Column(
                children: [
                  Text(
                    'Lựa chọn loại chứng chỉ xác thực',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeXl, AppSize.fontSizeXl),
                          color: AppColors.secondPrimary,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.xl, vertical: AppSize.md),
              child: GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  mainAxisSpacing: 15.0, // Vertical space between grid items
                  crossAxisSpacing: 15.0, // Horizontal space between grid items
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final imagePath = listIcon[index][0];
                  Color color = AppColors.listSelectedCardColor[index % AppColors.listSelectedCardColor.length];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color.withOpacity(0.65),
                      border: Border.all(
                        color: AppColors.gray2, // Set the border color
                        width: 2.0, // Set the border width
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle, border: Border.all(width: 7, color: AppColors.white.withOpacity(0.5))),
                          child: Image.asset(
                            imagePath,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        SizedBox(height: AppSize.spaceBtwSections),
                        Center(
                          child: Text(
                            "${listIcon[index][1]}",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    // height: AppValues.getSizeReponsite(150.0, 200.0, 250.0, context: context),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
