import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';

import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/stack_decoration/circular_container.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/AppInfo.dart';

class HomeCourseCardWidget extends StatelessWidget {
  const HomeCourseCardWidget({super.key, required this.thoiKhoaBieu, required this.onPress});

  final ThoiKhoaBieu thoiKhoaBieu;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkmode(context);

    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          color: AppColors.secondPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: isDark ? Colors.white : Colors.black,
                offset: const Offset(0.0, 0.0), //Offset
                blurRadius: 3.0,
                spreadRadius: 0.0), //BoxShadow
            BoxShadow(color: isDark ? Colors.black : Colors.white, offset: const Offset(0.0, 0.0), blurRadius: 2.0, spreadRadius: 1.0), //BoxShadow
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            Positioned(
                bottom: -50,
                right: -10,
                child: TCircularContainer(
                  width: AppSize.productItemHeight,
                  height: AppSize.productItemHeight,
                  backgroundColor: AppColors.white.withOpacity(0.2),
                )),
            Positioned(
                top: -100,
                left: -20,
                child: TCircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.2),
                  width: AppSize.imageCarouselHeight,
                  height: AppSize.imageCarouselHeight,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.lg, vertical: AppSize.xs),
              child: Column(
                children: [
                  const SizedBox(height: AppSize.spaceBtwItems),
                  // Tên học phần
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          thoiKhoaBieu.tenThoiKhoaBieu,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl),
                              ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  // Phòng học và Thời gian (Tiết học)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.clock, color: AppColors.white, size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd)),
                            const SizedBox(width: AppSize.sm),
                            Text(
                              "Thứ ${thoiKhoaBieu.thu}, ${thoiKhoaBieu.tietBatDau} -> ${thoiKhoaBieu.tietKetThuc}",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                    fontSize: AppValues.getResponsive(
                                      AppSize.fontSizeSm,
                                      AppSize.fontSizeMd,
                                      AppSize.fontSizeMd,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.placemark,
                              color: AppColors.white,
                              size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                            ),
                            const SizedBox(width: AppSize.xs),
                            Text(
                              thoiKhoaBieu.phong,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                    fontSize: AppValues.getResponsive(
                                      AppSize.fontSizeSm,
                                      AppSize.fontSizeMd,
                                      AppSize.fontSizeMd,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSize.sm),
                  // Lịch theo tuần
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.calendar,
                        color: AppColors.white,
                        size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                      ),
                      const SizedBox(width: AppSize.sm),
                      Text(
                        thoiKhoaBieu.getDisplayWeek(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: AppValues.getResponsive(
                                AppSize.fontSizeSm,
                                AppSize.fontSizeMd,
                                AppSize.fontSizeMd,
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.sm),
                  // Tên giảng viên
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person,
                        color: AppColors.white,
                        size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                      ),
                      const SizedBox(width: AppSize.sm),
                      Text(
                        thoiKhoaBieu.giangVienDay,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontSize: AppValues.getResponsive(
                                AppSize.fontSizeSm,
                                AppSize.fontSizeMd,
                                AppSize.fontSizeMd,
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
