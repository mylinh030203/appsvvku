import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';

import 'package:app_sinh_vien_vku/data/network/BaseApiService.dart';
import 'package:app_sinh_vien_vku/data/network/NetworkApiService.dart';

abstract class HocphanRepository {
  Future<DSThoiKhoaBieu> fetchHocphanByNamhocHocky(String token, String year, String hocKy);
  Future<DSThoiKhoaBieu> fecthDSHocphanTheoTuan(String token, String tuan, String namBatdau, String hocky);
}

class HocPhanRepositoryImpl implements HocphanRepository {
  final BaseApisService apiService;

  HocPhanRepositoryImpl({required this.apiService});

  @override
  Future<DSThoiKhoaBieu> fetchHocphanByNamhocHocky(String token, String year, String hocKy) async {
    try {
      var url = AppInfo.HOCPHAN_TKB_GETALL_ENDPOINT + year + "&hocKy=$hocKy";

      final res = await apiService.getApiResponse(url, token);

      return DSThoiKhoaBieu.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<DSThoiKhoaBieu> fecthDSHocphanTheoTuan(String token, String tuan, String namBatdau, String hocky) async {
    try {
      final res = await apiService.getApiResponse("${AppInfo.HOCPHAN_TKB_WEEK_FECTH_ENDPOINT}tuan=$tuan&namBatDau=$namBatdau&hocKy=$hocky", token);
      return DSThoiKhoaBieu.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
