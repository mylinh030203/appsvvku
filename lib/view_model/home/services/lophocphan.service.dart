import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/response/ApiResponse.dart';
import 'package:app_sinh_vien_vku/repository/schedue/hocphan_repositoryImpl.dart';
import 'package:app_sinh_vien_vku/utils/DataLocal.dart';
import 'package:app_sinh_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:flutter/cupertino.dart';

class LopHocPhanService with ChangeNotifier {
  final HocphanRepository hocPhanRepoImpl;
  final BaseLocal<String> jwtTokenBox;
  final BaseLocal<List<ThoiKhoaBieu>> thoiKhoaBieuBox;
  LopHocPhanService({required this.hocPhanRepoImpl, required this.jwtTokenBox, required this.thoiKhoaBieuBox});

  // Variable
  ApiResponse<DSThoiKhoaBieu> _dsThoiKhoaBieu = ApiResponse.loading();
  List<LopHocPhan> _dsLopHocPhan = [];
  ThoiKhoaBieu? _selectedHocPhan;

  // get
  ApiResponse<DSThoiKhoaBieu> get dsThoiKhoaBieu => _dsThoiKhoaBieu;
  List<LopHocPhan> get dsLopHocPhan => _dsLopHocPhan;
  ThoiKhoaBieu? get selectedThoiKhoaBieu => _selectedHocPhan;

  Future<void> fetchDSHocPhanApi(String namhoc, String hocky) async {
    String? token = await Datalocal.getAccessToken();

    await hocPhanRepoImpl.fetchHocphanByNamhocHocky(token!, namhoc, hocky).then((value) async {
      _dsThoiKhoaBieu = ApiResponse.completed(value);
      setDSLopHocPhan(value);
      // await thoiKhoaBieuBox.setData(value.dsThoiKhoaBieu!);
    }).onError((error, stackTrace) async {
      _dsThoiKhoaBieu = ApiResponse.error(error.toString());
      loadDSHocPhanLocal(int.parse(namhoc), int.parse(hocky));
    }).whenComplete(() => notifyListeners());
  }

  void setDSLopHocPhan(DSThoiKhoaBieu dsTKB) {
    dsLopHocPhan.clear();
    Map<int, LopHocPhan> groupedMap = {};
    for (var thoiKhoaBieu in dsTKB.dsThoiKhoaBieu!) {
      if (thoiKhoaBieu.nhom == 0) {
        groupedMap[thoiKhoaBieu.idHocPhan] = LopHocPhan(
          idLopHocPhan: thoiKhoaBieu.idHocPhan,
          dsTKB: [thoiKhoaBieu],
        );
      } else if (groupedMap.containsKey(thoiKhoaBieu.nhom)) {
        groupedMap[thoiKhoaBieu.nhom]?.dsTKB.add(thoiKhoaBieu);
      } else {
        groupedMap[thoiKhoaBieu.nhom] = LopHocPhan(
          idLopHocPhan: thoiKhoaBieu.nhom,
          dsTKB: [thoiKhoaBieu],
        );
      }
    }
    _dsLopHocPhan = groupedMap.values.toList();
    notifyListeners();
  }

  void setThoiKhoaBieu(ThoiKhoaBieu tkb) {
    _selectedHocPhan = tkb;
  }

  Future<void> loadDSHocPhanLocal(int namhoc, int hocky) async {
    var semester = AppValues.getCurrentSemester();
    try {
      final dsThoiKhoaBieuLocal = await thoiKhoaBieuBox.getData();

      if (semester[0] == namhoc && semester[1] == hocky) {
        _dsThoiKhoaBieu = ApiResponse.completed(DSThoiKhoaBieu.fromDSTHoiKhoaBieu(dsThoiKhoaBieuLocal!));
      } else {
        _dsThoiKhoaBieu = ApiResponse.error("Không có kết nối mạng");
      }
    } catch (e) {
      print(e);
    }
  }
}
