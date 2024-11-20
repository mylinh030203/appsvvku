import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/network/model/course_info/diem_danh.dart';
import 'package:app_sinh_vien_vku/data/network/model/course_info/lich_trinh_hoc_phan.dart';

import 'package:app_sinh_vien_vku/data/response/ApiResponse.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_sinh_vien_vku/repository/course_info/lichtrinhhocphan.repository.dart';
import 'package:app_sinh_vien_vku/utils/DataLocal.dart';
import 'package:app_sinh_vien_vku/view_model/home/services/lophocphan.service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CourseDetailsViewModel with ChangeNotifier {
  final LopHocPhanService hocphanService;
  final LichtrinhHocPhanRepository lichtrinhHocPhanRepoImpl;

  // Contructor
  CourseDetailsViewModel({required this.hocphanService, required this.lichtrinhHocPhanRepoImpl});

  final Logger _logger = Logger();
  ApiResponse<DSLichTrinhHocPhan> dsLichtrinhHocPhan = ApiResponse.loading();
  ApiResponse<DSSinhVienDiemDanh> dsSVDiemDanh = ApiResponse.loading();

  final List listTinhhinhvangnghi = [
    ["Buổi", 5],
    ["Có mặt", 4],
    ["Vắng", 1],
    ["Đi trễ", 0],
    ["Phép", 0],
  ];

  // changeSeletadTabIndex(int tabIndex) {
  //   _selectedTabIndex = tabIndex;
  //   notifyListeners();
  // }

  changeCheckbox(int index) {
    dsSVDiemDanh.data!.dsSinhVienDiemDanh![index].isCheckBox = !dsSVDiemDanh.data!.dsSinhVienDiemDanh![index].isCheckBox;
    notifyListeners();
  }

  Future<void> getLichtrinhHocphan() async {
    String? token = await Datalocal.getAccessToken();

    lichtrinhHocPhanRepoImpl.fetchDSLichtrinhHocPhanByIdTKB(token!, hocphanService.selectedThoiKhoaBieu!.idHocPhan.toString()).then((value) {
      dsLichtrinhHocPhan = ApiResponse.completed(value);

      notifyListeners();
    }).onError((error, stackTrace) {
      dsLichtrinhHocPhan = ApiResponse.error(error.toString());
    });
  }

  //   // Gọi api lấy ds sinh viên điểm danh
  // Future<void> getSinhvienDiemDanh() async {
  //   dsSVDiemDanh.status = Status.LOADING;
  //   notifyListeners();
  //   String? token = await Datalocal.getAccessToken();
  //   final selectedThoiKhoaBieu = hocphanService.selectedThoiKhoaBieu;

  //   await lichtrinhHocPhanRepoImpl.fetchDSLichtrinhHocPhanByIdTKB(token!, selectedThoiKhoaBieu!.idHocPhan.toString()).then((value) {
  //     dsSVDiemDanh = ApiResponse.completed(value);
  //     resetDSFilterSinhVien();
  //     createMapWithLabelSinhVien();
  //     setUpFunctionWhenKeyPressEnd();
  //   }).onError((error, stackTrace) {
  //     dsSVDiemDanh = ApiResponse.error(error.toString());
  //   }).whenComplete(() => notifyListeners());
  // }

  Map<LoaiDiemDanh, List<String>> getMapLoaiDiemDanh(int index) {
    var dsDiemDanh = dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan![index].dsDiemDanhChiTiet;
    Map<LoaiDiemDanh, List<String>> mapLoaiDiemDanh = {LoaiDiemDanh.DI_TRE: [], LoaiDiemDanh.VANG_PHEP: [], LoaiDiemDanh.VANG: []};
    for (var diemdanh in dsDiemDanh) {
      mapLoaiDiemDanh[diemdanh.loaiDiemDanh]?.add('- ${diemdanh.hoTen} - Mã SV: ${diemdanh.maSV}');
    }
    return mapLoaiDiemDanh;
  }
}
