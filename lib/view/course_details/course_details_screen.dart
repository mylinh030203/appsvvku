import 'dart:async';

import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';

import 'package:app_sinh_vien_vku/view/course_details/widget/course_bottom_sheet_widget.dart';
import 'package:app_sinh_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_sinh_vien_vku/view/course_details/widget/course_lesson_list_widget.dart';
import 'package:app_sinh_vien_vku/view_model/cousre_information/cousre_details.view_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CourseDetailsScreen extends StatelessWidget {
  CourseDetailsScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);

    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 0,
        color: AppColors.secondPrimary,
        onRefresh: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await courseDetailsViewModel.getLichtrinhHocphan();
          });
        },
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.secondPrimary,
              title: Text(
                "Thông tin học phần",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      color: AppColors.secondPrimary,
                    ),
              ),
            ),
            // Thông tin cơ bản học phần
            CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

            // Lịch thi kết thúc học phần
            // const CourseFinalExamWidget(),
            // Lịch trình học phần
            CourseLesssonListWidget(scrollController: _scrollController, thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),
            const SizedBox(height: AppSize.md),
          ],
        ),
      ),
      bottomNavigationBar: BotttomButtonsCompoment(
        outlineString: "Danh sách SV",
        outLinedOnPress: () => Utils.toastDev(),
        elevatedString: "Thông kê",
        elevatedOnPress: () => Utils.toastDev(),
      ),
    );
  }

  showBotttomSheet(context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: false,
        isScrollControlled: true,
        builder: (context) {
          return Container();
        });
  }
  // CourseBottomSheetWidget()
}
