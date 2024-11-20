import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/repository/qr/qr.repository.dart';
import 'package:app_sinh_vien_vku/repository/qr/qr.repositoryImpl.dart';
import 'package:app_sinh_vien_vku/utils/enum/loai_ma_qr.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../data/network/model/qr/qr.model.dart';
import '../../utils/DataLocal.dart';
import '../../utils/utils.dart';

class QrViewModel with ChangeNotifier {
  final Logger _logger = Logger();
  QrRepository _myRepo = QrRepositoryImpl();

  Status? _statusQR = null;
  Status? get statusQR => _statusQR;

  int? idLophp = null;
  String error = "";

  setStatusQR() {
    _statusQR = null;
    notifyListeners();
  }

  Future<void> scanQRCode(Barcode scanData) async {
    _statusQR = Status.LOADING;
    notifyListeners();

    if (scanData.code == null) {
      return;
    }
    List<String> part = scanData.code!.split(',');
    LoaiMaQR loaiMaQR = LoaiMaQR.fromValue(part[0]);

    // Xác định loại quét mã
    switch (loaiMaQR) {
      case LoaiMaQR.DiemDanh:
        await checkStudentAttendance(int.parse(part[1]));
        break;
      case LoaiMaQR.ThongTin:
        break;
      case LoaiMaQR.Khac:
        break;
      case LoaiMaQR.QRBenNgoai:
        error = "Mã QR không hợp lệ. \n Nội dung: ${scanData.code} ";
        _statusQR = Status.ERROR;
        notifyListeners();
        return;
    }
  }

  Future<void> checkStudentAttendance(int id) async {
    try {
      final token = await Datalocal.getAccessToken();
      GetScheduleModel? response = await _myRepo.fetchQrScheduleStudent(id);

      if (response == null) {
        error = "Mã QR không hợp lệ";
        _statusQR = Status.ERROR;
        notifyListeners();
        return;
      }

      List<String> partQR = response.thongTinQr.split(",");
      if (partQR[0] != 'z') {
        // Kiểm tra khoảng cách 2 điểm
        double radius = 35.0;
        var latituleLec = double.parse(partQR[1]);
        var longituleLec = double.parse(partQR[0]);
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        print("long ${position.longitude}, lati ${position.latitude}");
        double distance = Geolocator.distanceBetween(latituleLec, longituleLec, position.latitude, position.longitude);
        print(distance);
        bool isWithinRadius = distance <= radius;

        if (!isWithinRadius) {
          _statusQR = Status.ERROR;
          error = "Lỗi Vị trí, Hãy lên lớp để điểm danh";
          notifyListeners();
          return;
        }
      }

      // Kiểm tra thời hạn QR
      DateTime now = DateTime.now();
      DateTime timeEndQR = DateTime.parse(partQR[3]);
      if (now.isAfter(timeEndQR)) {
        _statusQR = Status.ERROR;
        error = "Hết thời hạn điểm danh";
        notifyListeners();
        return;
      }

      bool rollCall = await _myRepo.rollCallStudent(token!, response.idLophp);
      if (!rollCall) {
        error = "Lỗi điểm danh không thành công, hãy kiểm tra lại mạng";
        _statusQR = Status.ERROR;
        notifyListeners();
        return;
      }

      idLophp = response.idLophp;
      _statusQR = Status.COMPLETED;
      notifyListeners();
    } catch (err) {
      error = err.toString();
      _statusQR = Status.ERROR;
      notifyListeners();

      _logger.e("------------- \n in qr view model");
      _logger.e(err);
      _logger.e("-------------");
    }
  }
}
