import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/data/network/BaseApiService.dart';
import 'package:app_sinh_vien_vku/data/network/NetworkApiService.dart';
import 'package:app_sinh_vien_vku/data/network/model/course_info/lich_trinh_hoc_phan.dart';
import 'package:app_sinh_vien_vku/repository/course_info/lichtrinhhocphan.repository.dart';

class LichtrinhHocPhanRepoImpl implements LichtrinhHocPhanRepository {
  final BaseApisService apiService;

  LichtrinhHocPhanRepoImpl({required this.apiService});

  @override
  Future<DSLichTrinhHocPhan> fetchDSLichtrinhHocPhanByIdTKB(String token, String id_tkb) async {
    try {
      var url = AppInfo.LICHTRINH_NOIDUNG_BUOIHOC + '?idLophp=' + id_tkb;

      final res = await apiService.getApiResponse(url, token);
      print(res);
      return DSLichTrinhHocPhan.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
