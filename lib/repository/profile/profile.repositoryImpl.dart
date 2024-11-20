import 'package:app_sinh_vien_vku/data/network/model/user/user.model.dart';
import 'package:app_sinh_vien_vku/repository/profile/profile.repository.dart';

import '../../constants/AppInfo.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../data/network/model/user/user_update.model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final BaseApisService _apisService = NetworkApiService();
  @override
  Future<UserResponseModel> getUserProfile(String token) async {
    try {
      final res = await _apisService.getApiResponse(AppInfo.fetchProfileEndPoint, token);
      print("data sau laay ${UserResponseModel.fromJson(res)}");
      return UserResponseModel.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      throw e;
    }
  }

  Future<UserResponseModel> updateUserProfile(UserPutRequestModel data, String token) async {
    try {
      print("Status   ${data.status}");
      await _apisService.putApiResponse("${AppInfo.updateProfileEndPoint}/${data.id}", data.toJson(), token);
      return data;
    } catch (e) {
      throw e;
    }
  }
}
