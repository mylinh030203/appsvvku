import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseFinalExamWidget extends StatelessWidget {
  const CourseFinalExamWidget({
    super.key,
  });

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
          children: [
            // Tên học phần
            SizedBox(
              width: double.infinity,
              child: Text(
                "Thông tin lịch thi kết thúc học phần",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
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
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.calendar, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'TKB:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    'Thứ 3 | 15/12/2023',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeSm),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.xs),

            Row(
              children: [
                const Icon(CupertinoIcons.time, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Giờ:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    '13h30',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeSm),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.bookmark, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Hình thức thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    'Vấn đáp',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeSm),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.placemark, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Phòng thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    'KA305',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeSm),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.person_2, color: AppColors.secondPrimary),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Hội đồng coi thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.xs),

            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: AppSize.xs),
              itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.sm)),
                  child: Center(
                    child: Text(
                      'ThS. Trần Đình Sơn',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                          ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
