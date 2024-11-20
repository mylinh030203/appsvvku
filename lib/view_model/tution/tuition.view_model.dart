import 'package:app_sinh_vien_vku/data/local/tuition_up_coming.local.dart';
import 'package:app_sinh_vien_vku/data/network/model/tuition/tuition_paid.model.dart';
import 'package:app_sinh_vien_vku/data/network/model/tuition/tuition_up_coming.model.dart';
import 'package:app_sinh_vien_vku/repository/tuition/tuition.repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import '../../data/AppException.dart';
import '../../data/local/tuition_paid.local.dart';
import '../../data/response/status.dart';
import '../../utils/DataLocal.dart';
import '../../utils/utils.dart';

class TuitionViewModel with ChangeNotifier {
  final Logger _logger = Logger();
  final TuitionRepository _myRepo;

  TuitionViewModel(this._myRepo);

  Status _statusPaid = Status.LOADING;
  Status get statusPaid => _statusPaid;

  Status _statusComing = Status.LOADING;
  Status get statusComing => _statusComing;

  List<Map<String, Object>>? _dataHocPhiDaNop = [];
  List<Map<String, Object>>? get dataHocPhiDaNop => _dataHocPhiDaNop;

  List<Map<String, Object>>? _dataHocPhiSapToi = [];
  List<Map<String, Object>>? get dataHocPhiSapToi => _dataHocPhiSapToi;

  double _tongTien = 0;
  double get tongTien => _tongTien;

  Map<String, dynamic> _subDataUTC = {
    "Tổng tiền": 0,
    "Tổng tín chỉ": 0,
    "Giảm học phí": 0,
    "Số tiền thực nộp": 0
  };
  Map<String, dynamic> get subDataUTC => _subDataUTC;

  Future<void> fetchTuitionPaid(BuildContext context) async {
    _statusPaid = Status.LOADING;
    notifyListeners();

    try {
      final token = await Datalocal.getAccessToken();
      _logger.d("dang lay data tu internet");
      final response = await _myRepo.getListTuitionPaid(token!);
      _dataHocPhiDaNop = _formatDataTPaid(response);
      _statusPaid = Status.COMPLETED;
      notifyListeners();
      List<TuitionPaidLocal> tuitionPaidList =
          _formatDataTPaidToLocal(response);
      await Datalocal.setTuitionPaidList(tuitionPaidList);
    } catch (e) {
      _logger.d("dang lay data tu internet lan 2");
      try {
        final token = await Datalocal.getAccessToken();
        final response = await _myRepo.getListTuitionPaid(token!);
        _dataHocPhiDaNop = _formatDataTPaid(response);
        _statusPaid = Status.COMPLETED;
        notifyListeners();
        List<TuitionPaidLocal> tuitionPaidList =
            _formatDataTPaidToLocal(response);
        await Datalocal.setTuitionPaidList(tuitionPaidList);
      } catch (e) {
        if (e is FetchDataException) {
          _logger.d("lay data local");
          Utils.toastWarn(e.toString(), context);
          final tuitionPaidLocal = await Datalocal.getTuitionPaidList();
          if (tuitionPaidLocal != null) {
            _dataHocPhiDaNop = _formatDataTPaidFromLocal(tuitionPaidLocal);
            _logger.d(_dataHocPhiDaNop);
            _statusPaid = Status.COMPLETED;
            notifyListeners();
          }
        } else {
          _statusPaid = Status.ERROR;
          Utils.snackBar(e.toString(), context, true);
        }
      }
    }
  }

  Future<void> fetchTuitionUpcoming(BuildContext context) async {
    _statusComing = Status.LOADING;
    notifyListeners();

    try {
      final token = await Datalocal.getAccessToken();
      _logger.d("dang lay data tu internet");
      final response = await _myRepo.getListTuitionUpComing(token!);
      _dataHocPhiSapToi = _formatDataTUC(response);
      _statusComing = Status.COMPLETED;
      notifyListeners();
      // List<TuitionUpComingLocal> tuitionUCList = _formatDataTUCToLocal(response);
      // await Datalocal.setTuitionUpComingList(tuitionUCList);
    } catch (e) {
      _logger.d("dang lay data tu internet lan 2");
      try {
        final token = await Datalocal.getAccessToken();
        final response = await _myRepo.getListTuitionUpComing(token!);
        _dataHocPhiSapToi = _formatDataTUC(response);
        _statusComing = Status.COMPLETED;
        notifyListeners();
      //   List<TuitionUpComingLocal> tuitionUCList = _formatDataTUCToLocal(response);
      // await Datalocal.setTuitionUpComingList(tuitionUCList);
      } catch (e) {
        if (e is FetchDataException) {
          _logger.d("lay data local");
          Utils.toastWarn(e.toString(), context);
          final data = await Datalocal.getTuitionUpComingList();
          if (data != null) {
            _dataHocPhiSapToi = _formatDataTUCFromLocal(data);
            _logger.d(_dataHocPhiSapToi);
            _statusComing = Status.COMPLETED;
            notifyListeners();
          }
        } else {
          _statusComing = Status.ERROR;
          Utils.snackBar(e.toString(), context, true);
        }
      }
    }
  }

 List<Map<String, String>> _formatDataTPaid(
  List<TuitionPaidResponseModel> data) {
  return data.asMap().entries.map((entry) {
    int index = entry.key + 1;
    var item = entry.value;
    _tongTien += item.soTien;
    return {
      '#': '$index',
      'Năm học - học kì': '${item.namHocHocKy}',
      'Số tiền': '${formatCurrency(item.soTien)}',
      'Biên lai': item.bienLai ?? 'N/A', // Thêm giá trị mặc định nếu cần
      'Người thu': item.nguoiThu ?? 'N/A', // Thêm giá trị mặc định nếu cần
      'Ngày thu': item.ngayThu ?? 'N/A', // Thêm giá trị mặc định nếu cần
    };
  }).toList();
}

List<TuitionPaidLocal> _formatDataTPaidToLocal(
  List<TuitionPaidResponseModel> data) {
  return data.map((item) {
    _tongTien += item.soTien;
    return TuitionPaidLocal(
      namHocHocKy: item.namHocHocKy,
      soTien: item.soTien,
      bienLai: item.bienLai,
      nguoiThu: item.nguoiThu,
      ngayThu: item.ngayThu,
    );
  }).toList();
}

List<Map<String, String>> _formatDataTPaidFromLocal(
  List<TuitionPaidLocal> data) {
  return data.asMap().entries.map((entry) {
    int index = entry.key + 1;
    var item = entry.value;
    _tongTien += item.soTien;
    return {
      '#': '$index',
      'Năm học - học kì': '${item.namHocHocKy}',
      'Số tiền': '${formatCurrency(item.soTien)}',
      'Biên lai': item.bienLai ?? 'N/A', // Thêm giá trị mặc định nếu cần
      'Người thu': item.nguoiThu ?? 'N/A', // Thêm giá trị mặc định nếu cần
      'Ngày thu': item.ngayThu ?? 'N/A', // Thêm giá trị mặc định nếu cần
    };
  }).toList();
}

  List<Map<String, String>> _formatDataTUC(List<TuitionUpComingResponseModel> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key + 1;
      var item = entry.value;
      _subDataUTC['Tổng tiền']+= item.soTien;
      return {
        '#': '$index',
        'Lớp học phần': '${item.tenHocPhan}',
        'Số tín chỉ': '${item.soTinChi}',
        'Số tiền': '${formatCurrency(item.soTien)}'
      };
    }).toList();
  }

  List<TuitionUpComingLocal> _formatDataTUCToLocal(
      List<TuitionUpComingResponseModel> data) {
    return data.map((item) {
      return TuitionUpComingLocal(
        soTinChi: 2,
        tenHocPhan: item.tenHocPhan,
        soTien: item.soTien,
      );
    }).toList();
  }

  List<Map<String, String>> _formatDataTUCFromLocal(
      List<TuitionUpComingLocal> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key + 1;
      var item = entry.value;
      return {
        '#': '$index',
        'Lớp học phần': '${item.tenHocPhan}',
        'Số tiền': '${formatCurrency(item.soTien)}'
      };
    }).toList();
  }

  String formatCurrency(num amount) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return formatter.format(amount);
  }
}
