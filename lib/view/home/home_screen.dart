import 'package:app_sinh_vien_vku/components/InputComponent.dart';
import 'package:app_sinh_vien_vku/components/PrimaryHeaderCompoment.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';

import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_appbar.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_divider.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_grid_button_widget.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_list_course_widget.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_upcomming_course_widget.dart';

import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (homeViewModel.hocphanService.dsThoiKhoaBieu.data == null) {
        await homeViewModel.fetchNamhocHocky();
        await homeViewModel.fetchDSHocPhan(homeViewModel.nienKhoa.toString(), homeViewModel.hocky.toString());
      } else {}
    });
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: RefreshIndicator(
        edgeOffset: 0,
        color: AppColors.secondPrimary,
        onRefresh: () async {
          await homeViewModel.fetchDSHocPhan(homeViewModel.nienKhoa.toString(), homeViewModel.hocky.toString());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              PrimaryHeaderContainer(
                backgroundImage: Image.asset('assets/images/background/vku_landscape.jpg', fit: BoxFit.cover),
                opacity: 0.35,
                height: AppValues.getResponsive(200.0, 240.0, 240.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// AppBar
                    HomeAppBarWiget(),
                    const SizedBox(height: AppSize.spaceBtwSections),
                  ],
                ),
              ),

              /// Body
              // Các nút chức năng truy cập nhanh
              const SizedBox(height: AppSize.sm),
              HomeGridButtonWidget(),

              const HomeDividerWidget(),
              const SizedBox(height: AppSize.spaceBtwItems),

              // Những học phần sắp tới trong tuần
              const HomeUpcommingCourseWidget(),
              const SizedBox(height: AppSize.spaceBtwItems),

              // Những học phần của bạn
              const HomeDSHocPhanWidget()
            ],
          ),
        ),
      ),
    );
  }
}
