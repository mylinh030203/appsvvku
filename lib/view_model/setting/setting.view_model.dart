import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/utils/dataLocal.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SettingViewModel extends ChangeNotifier {
  final BaseLocal<String> jwtTokenBox;

  SettingViewModel({required this.jwtTokenBox});

  Future<void> handleLogout(BuildContext context) async {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    Provider.of<BotttomNavigatorService>(context, listen: false).onRedirectScreen(BottomNavScreen.TRANGCHU);
    List<int> semtember = AppValues.getCurrentSemester();
    homeViewModel.nienKhoa = semtember[0];
    homeViewModel.hocky = semtember[1];
    Future.wait(
      [
        // Datalocal.clearMark(),
        // Datalocal.clearUser(),
        jwtTokenBox.clearData(),
        // Datalocal.clearDSHocPhanLocal(),
        // Provider.of<ProfileViewModel>(context, listen: false).deleteProfile(),
      ],
    );
    AppHelperFunctions.navigateToScreenAndRemoveAll(context, RoutesName.login);
  }
}
