import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/components/BackgroundAppCompoment.dart';
import 'package:app_sinh_vien_vku/components/IconComponent.dart';
import 'package:app_sinh_vien_vku/components/RowComponent.dart';
import 'package:app_sinh_vien_vku/components/SectionComponent.dart';
import 'package:app_sinh_vien_vku/components/SpaceComponent.dart';
import 'package:app_sinh_vien_vku/components/TextComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/utils/dataLocal.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/imageString.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';
import 'package:app_sinh_vien_vku/view/setting/setting_widget/setting_app_bar.dart';
import 'package:app_sinh_vien_vku/view/setting/setting_widget/setting_grid_quick_access.dart';
import 'package:app_sinh_vien_vku/view/setting/setting_widget/setting_list_other_tool.dart';
import 'package:app_sinh_vien_vku/view/setting/setting_widget/setting_profile.dart';
import 'package:app_sinh_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../view_model/profile/profile.view_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Logger _logger = Logger();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Future<void> handleLogout() async {
  //   HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
  //   Provider.of<BotttomNavigatorService>(context, listen: false).onRedirectScreen(BottomNavScreen.TRANGCHU);
  //   List<int> semtember = AppValues.getCurrentSemester();
  //   homeViewModel.nienKhoa = semtember[0];
  //   homeViewModel.hocky = semtember[1];

  //   Future.wait(
  //     [
  //       Datalocal.clearMark(),
  //       Datalocal.clearUser(),
  //       Datalocal.clearAccessToken(),
  //       Datalocal.clearDSHocPhanLocal(),
  //       Provider.of<ProfileViewModel>(context, listen: false).deleteProfile(),
  //     ],
  //   );
  //   AppHelperFunctions.navigateToScreenAndRemoveAll(context, RoutesName.login);
  // }

  @override
  Widget build(BuildContext context) {
    final settingViewModel = Provider.of<SettingViewModel>(context);
    final List otherToolsGrid = [
      [CupertinoIcons.phone, "Liên hệ giảng viên", () => Utils.toastDev()],
      [CupertinoIcons.info, "Danh bạ sinh viên", () => Utils.toastDev()],
      [CupertinoIcons.doc_person, "Chứng chỉ tốt nghiệp", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.graduation_certificate)],
      [CupertinoIcons.calendar, "Thời khóa biểu toàn trường", () => Utils.toastDev()],
      [CupertinoIcons.archivebox, "Đăng ký nhận bảng điểm", () => Utils.toastDev()],
      [CupertinoIcons.archivebox, "Đăng ký chuyên ngành", () => Utils.toastDev()],
      [CupertinoIcons.archivebox, "Đăng ký giấy xác nhận sinh viên", () => Utils.toastDev()],
      [CupertinoIcons.archivebox, "Minh chứng chuyển đổi tính chỉ", () => Utils.toastDev()],
      [CupertinoIcons.doc, "Khảo sát ý kiến", () => Utils.toastDev()],
    ];

    final List otherToolsGrid2 = [
      [CupertinoIcons.archivebox, "Thư góp ý", () => Utils.toastDev()],
      [CupertinoIcons.hand_thumbsup, "Báo cáo lỗi", () => Utils.toastDev()],
    ];
    final List otherToolsGrid3 = [];

    return Scaffold(
      body: BackgroundAppCompoment(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu cài đặt
              SettingAppBarWidget(),
              // Thông tin tài khoản
              SizedBox(height: AppSize.sm),
              SettingProfileWidget(),
              SizedBox(height: AppSize.xs),
              // Các tiện ích nhanh
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
                child: Text(
                  'Các tiện ích nhanh',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeLg),
                        color: AppColors.white,
                      ),
                ),
              ),
              // Grid các tiện ích nhanh
              SettingGridQuickAccessButton(),
              // Các công cụ khác
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid,
                iconHeader: CupertinoIcons.question_circle_fill,
                text: 'Các công cụ khác',
              ),
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid2,
                iconHeader: CupertinoIcons.question_circle_fill,
                text: 'Hỗ trợ và trợ giúp',
              ),
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid3,
                iconHeader: CupertinoIcons.gear_alt_fill,
                text: "Cài đặt và hiển thị",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.xs, vertical: AppSize.xs),
                child: TextButton(
                  onPressed: () async => await settingViewModel.handleLogout(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppSize.md),
                    decoration: BoxDecoration(
                      color: AppColors.fifthPrimary,
                      borderRadius: BorderRadius.circular(AppSize.sm),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Đăng xuất',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeLg),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration shadowBoxDecoration() {
    return BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(AppSize.sm),
      boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 5, offset: Offset(0.0, 3.0))],
    );
  }
}
