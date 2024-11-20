import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_upcomming_card.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeUpcommingCourseWidget extends StatelessWidget {
  const HomeUpcommingCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Học phần hôm nay',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondPrimary,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl),
                      ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.list_bullet,
                    color: AppColors.secondPrimary,
                    size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                  )),
            ],
          ),
        ),
        const SizedBox(height: AppSize.spaceBtwItems),
        Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch (value.statusTKBNgay) {
              case Status.COMPLETED:
                return value.dsTKBNgay.isNotEmpty
                    ? SizedBox(
                        height: AppValues.getResponsive(140.0, 160.0, 180.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(width: AppSize.md),
                          padding: EdgeInsets.symmetric(horizontal: AppSize.lg),
                          shrinkWrap: true,
                          itemCount: value.dsTKBNgay.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            int tietHocHientai = AppValues.categorizeCurrentTime();
                            bool isInThisTime = value.dsTKBNgay[index].tietBatDau <= tietHocHientai && tietHocHientai <= value.dsTKBNgay[index].tietKetThuc;

                            bool isNotPassYet = value.dsTKBNgay[index].tietBatDau >= tietHocHientai;
                            String text = isInThisTime
                                ? 'Đang diễn ra'
                                : isNotPassYet
                                    ? 'Sắp diễn ra'
                                    : 'Đã kết thúc';
                            Color statusColor = isInThisTime ? AppColors.sixthPrimary : AppColors.gray;

                            var color = AppColors.listColorTodayCourse[index % 2];
                            return HomeUpcommingCourseCardWidget(
                              onPress: () {
                                value.hocphanService.setThoiKhoaBieu(value.dsTKBNgay[index]);
                                AppHelperFunctions.navigateToScreenName(context, RoutesName.coruse_details);
                              },
                              thoiKhoaBieu: value.dsTKBNgay[index],
                              statusColor: statusColor,
                              backgroundColor: color,
                              text: Text(
                                text,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: isInThisTime ? AppColors.white : AppColors.black,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                                    ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(right: AppSize.lg),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Không có học phần vào hôm nay',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.black, fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg)),
                          ),
                        ),
                      );
              case Status.ERROR:
                return Container(
                  padding: const EdgeInsets.only(right: AppSize.lg),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Không có học phần vào hôm nay',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.black, fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg)),
                    ),
                  ),
                );
              case Status.LOADING:
                return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
