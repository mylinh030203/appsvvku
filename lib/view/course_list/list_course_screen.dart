import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/view/course_list/course_list_widget/course_card.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';

class ListCourseScreen extends StatelessWidget {
  const ListCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Appbar
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.secondPrimary,
              title: Text(
                "Học phần giảng dạy",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      color: AppColors.secondPrimary,
                    ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search, color: AppColors.secondPrimary)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
              child: Text(
                "Danh sách lớp học phần giảng dạy vào Học kỳ 1 - Năm học 2024-2025",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),

            Consumer<HomeViewModel>(builder: (context, value, child) {
              switch (value.hocphanService.dsThoiKhoaBieu.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.hocphanService.dsThoiKhoaBieu.message.toString());
                case Status.COMPLETED:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
                    child: ListView.builder(
                      itemCount: value.hocphanService.dsLopHocPhan.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indexRow) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 4 != indexRow ? 3 : 0,
                                color: AppColors.secondPrimary,
                              ),
                              bottom: BorderSide(
                                width: 4 - 1 == indexRow ? 3 : 0,
                                color: AppColors.secondPrimary,
                              ),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: value.hocphanService.dsLopHocPhan[indexRow].dsTKB.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DSHocPhanCard(
                                indexRow: indexRow,
                                index: index,
                                isSeparate: false,
                                tkb: value.hocphanService.dsLopHocPhan[indexRow].dsTKB[index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                case null:
                  return Container();
              }
            }),

            const SizedBox(height: AppSize.md)
          ],
        ),
      ),
    );
  }
}
