import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseInfomationWidget extends StatelessWidget {
  const CourseInfomationWidget({super.key, required this.thoiKhoaBieu});
  final ThoiKhoaBieu thoiKhoaBieu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.md),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 2, offset: const Offset(0.0, 1.0)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên học phần
            SizedBox(
              width: double.infinity,
              child: Text(
                thoiKhoaBieu.tenThoiKhoaBieu,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, 18.0),
                    ),
              ),
            ),
            const SizedBox(height: AppSize.sm),
            // Trạng thái học phần
            Row(
              children: [
                Text(
                  "Trạng thái:",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sixthPrimary,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    'Đã kết thúc',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.md),
            // TKB Học phần

            Row(
              children: [
                const Icon(CupertinoIcons.time, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Thứ ${thoiKhoaBieu.thu} | Tiết ${thoiKhoaBieu.tietBatDau} -> ${thoiKhoaBieu.tietKetThuc} | Tuần ${thoiKhoaBieu.getDisplayWeek()}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.xs),
            // Phòng học
            Row(
              children: [
                const Icon(CupertinoIcons.location, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  thoiKhoaBieu.phong,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.person, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  thoiKhoaBieu.giangVienDay,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
