import '../../data/network/model/user/user.model.dart';
import '../../data/network/model/user/user_update.model.dart';

abstract class ProfileRepository {
  Future<UserResponseModel> getUserProfile(String token);
  Future<UserResponseModel> updateUserProfile(UserPutRequestModel data, String token);
}