import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/network/model/course_info/lich_trinh_hoc_phan.dart';
import 'package:app_sinh_vien_vku/view/course_details/component/course_lesson_deitals_card.dart';
import 'package:app_sinh_vien_vku/view_model/cousre_information/cousre_details.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';

class CourseLesssonListWidget extends StatelessWidget {
  const CourseLesssonListWidget({
    super.key,
    required this.scrollController,
    required this.thoiKhoaBieu,
  });
  final ThoiKhoaBieu thoiKhoaBieu;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
      await courseDetailsViewModel.getLichtrinhHocphan();
    });
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
                "Lịch trình học phần",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),

            Consumer<CourseDetailsViewModel>(builder: (context, value, child) {
              switch (value.dsLichtrinhHocPhan.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Text(value.dsLichtrinhHocPhan.message.toString());
                case Status.COMPLETED:
                  value.dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan?.sort((a, b) => b.ngayDay.compareTo(a.ngayDay));
                  List<LichTrinhHocPhan> dsLichTrinh = value.dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan!;
                  return dsLichTrinh.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: AppSize.md),
                          itemCount: dsLichTrinh.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return CourseLessonDetailsCard(
                              mapdiemdanh: value.getMapLoaiDiemDanh(index),
                              length: dsLichTrinh.length,
                              index: index + 1,
                              controller: scrollController,
                              lichTrinhHocPhan: value.dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan![index],
                              tkb: thoiKhoaBieu,
                            );
                          },
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: AppSize.xl, bottom: AppSize.md),
                          child: Text(
                            'Chưa có lịch trình giảng dạy.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppColors.secondPrimary,
                                  fontSize: AppValues.getResponsive(AppSize.sm, AppSize.md, AppSize.md),
                                ),
                          ),
                        );
                case null:
                  return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
