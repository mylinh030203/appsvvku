import 'package:app_sinh_vien_vku/repository/auth/auth.repository.dart';
import 'package:app_sinh_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:flutter/material.dart';
import '../../data/AppException.dart';
import '../../data/network/model/auth/signin.model.dart';
import '../../repository/auth/auth.repositoryImpl.dart';
import '../../utils/dataLocal.dart';
import 'package:logger/logger.dart';

import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class SigninViewModel with ChangeNotifier {
  final BaseLocal<String> jwtTokenBox;
  final AuthRepository authRepositoryImpl;

  SigninViewModel({required this.jwtTokenBox, required this.authRepositoryImpl});

  final Logger _logger = Logger();

  bool _loading = false;
  bool get loading => _loading;

  setLoadingg(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(String email, String password, BuildContext context) async {
    setLoadingg(true);
    Utils.showLoading(context);
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await authRepositoryImpl.loginApi(LoginRequestModel(username: email, password: password));
      _logger.d(response.toString());
      await Datalocal.setAccessToken(response.token);

      setLoadingg(false);
      Navigator.pop(context);
      String? token = await Datalocal.getAccessToken();
      print("token da lay $token");

      Navigator.popAndPushNamed(context, RoutesName.menuBar);
    } catch (e) {
      _logger.e(e.toString());
      setLoadingg(false);
      Navigator.pop(context);
      // Hiển thị thông báo lỗi từ server
      if (e is BadRequestException || e is UnauthorisedException || e is FetchDataException) {
        Utils.snackBar(e.toString(), context, true);
      } else {
        Utils.snackBar("An unexpected error occurred", context, true);
      }
    }
  }
}
