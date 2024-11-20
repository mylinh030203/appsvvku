import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_button.dart';
import 'package:app_sinh_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

class HomeGridButtonWidget extends StatelessWidget {
  HomeGridButtonWidget({super.key});

  List gridButtonHome = [];
  @override
  Widget build(BuildContext context) {
    final botttomNavigatorService = Provider.of<BotttomNavigatorService>(context, listen: false);
    gridButtonHome = [
      [CupertinoIcons.calendar, "Thời khóa biểu", () => botttomNavigatorService.onRedirectScreen(BottomNavScreen.THOIKHOABIEU)],
      [CupertinoIcons.qrcode_viewfinder, "Quét Mã", () => botttomNavigatorService.onRedirectScreen(BottomNavScreen.QUETQR)],
      [CupertinoIcons.bookmark, "Điểm học phần", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.checkmark)],
      [CupertinoIcons.money_dollar_circle, "Học phí", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.tuition)],
      [CupertinoIcons.archivebox, "Chương trình đào tạo", () => Utils.toastDev()],
      [CupertinoIcons.doc_on_doc, "Nhận bảng điểm", () => Utils.toastDev()],
      [CupertinoIcons.rectangle_stack_badge_person_crop, "Gửi minh chứng", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.graduation_certificate)],
      [CupertinoIcons.compass, "Khám phá", () => Utils.toastDev()]
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.lg),
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          int itemCount = 4 * 2;
          int crossAxisCount = 4;
          double childAspectRatio = AppValues.getResponsive(0.5, 0.6, 0.6);
          // Chiều cao của mỗi item trong grid, tính dựa trên tỷ lệ và chiều rộng của mỗi item
          double itemHeight = (MediaQuery.of(context).size.width - (AppSize.md * 2)) / crossAxisCount / childAspectRatio;
          int rowCount = (itemCount / crossAxisCount).ceil();
          double expandedHeight = itemHeight * rowCount;
          double collapsedHeight = itemHeight;
          return AnimatedContainer(
            curve: Curves.easeInOut,
            height: value.showMoreButton ? expandedHeight : collapsedHeight,
            width: double.infinity,
            duration: const Duration(milliseconds: 500),
            child: GridView.builder(
                itemCount: itemCount,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio),
                itemBuilder: (context, index) {
                  return HomeButtonWidget(
                    icon: gridButtonHome[index][0],
                    iconSize: AppValues.getResponsive(AppSize.iconMd, AppSize.iconLg, AppSize.iconLg),
                    iconColor: AppColors.secondPrimary,
                    text: gridButtonHome[index][1],
                    onPressed: gridButtonHome[index][2],
                  );
                }),
          );
        },
      ),
    );
  }
}
