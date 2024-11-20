import 'package:app_sinh_vien_vku/data/local/mark.local.dart';
import 'package:app_sinh_vien_vku/data/network/BaseApiService.dart';
import 'package:app_sinh_vien_vku/repository/setting/mark.repository.dart';

import '../../constants/AppInfo.dart';
import '../../data/network/NetworkApiService.dart';
import 'package:logger/logger.dart';

class MarkRepositoryImpl extends MarkRepository {
  final BaseApisService _apisService = NetworkApiService();
  Logger _logger = Logger();
  @override
  Future<MarkLocal> fetchMarkUser(String token) async {
    try {
      final res = await _apisService.getApiResponse(AppInfo.fetchMarkEndPoint, token);
      _logger.d(MarkLocal.fromJson(res));
      return MarkLocal.fromJson(res);
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      throw e;
    }
  }
}
