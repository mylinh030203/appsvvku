import 'package:app_sinh_vien_vku/data/network/model/course_info/lich_trinh_hoc_phan.dart';

abstract class LichtrinhHocPhanRepository {
  Future<DSLichTrinhHocPhan> fetchDSLichtrinhHocPhanByIdTKB(String token, String id_tkb);

  // Future<SignupResponseModel> verifyCode(String code);
}
