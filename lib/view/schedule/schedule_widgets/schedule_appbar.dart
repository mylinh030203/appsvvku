import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';

import 'package:app_sinh_vien_vku/view_model/schedule/schedule.view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleAppBarWidget extends StatelessWidget {
  const ScheduleAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppInfo.isMobileSmall(context) ? 0 : AppSize.xs, right: AppSize.md),
      child: AppBarComponent(
        leadingIcon: null,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch học',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeXl, 24.0),
                    color: AppColors.secondPrimary,
                  ),
            ),
            const SizedBox(height: AppSize.xs),
            Consumer<HomeViewModel>(
              builder: (context, value, child) {
                switch (value.namHocHocKyService.dsNamhocHocKy.status) {
                  case Status.LOADING:
                    return CircularProgressIndicator();

                  case Status.COMPLETED:
                    var now = DateTime.now();
                    return Text('Tuần ${value.getWeekByDay(now, value.namHocHocKyService.namhocHockyHienTai!.ngayBatDau)}, thứ ${now.weekday + 1}  ${now.day + 1}/${now.month}/${now.year}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500, fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd)));

                  case Status.ERROR:
                    return Text("Error");
                  default:
                    return Container();
                }
              },
            )
          ],
        ),
        actions: [
          Consumer<ScheduleViewModel>(
            builder: (context, value, child) => ElevatedButton(
              onPressed: () => value.changeUIViewDaysorWeekly(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.lg),
                child: Text(
                  value.isDaily ? 'Ngày' : "Tuần",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
