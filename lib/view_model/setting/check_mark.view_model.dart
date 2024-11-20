import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../data/AppException.dart';
import '../../data/local/mark.local.dart';
import '../../data/response/status.dart';
import '../../repository/setting/mark.repository.dart';
import '../../utils/DataLocal.dart';
import '../../utils/utils.dart';

class CheckMarkViewModel with ChangeNotifier {
  final Logger _logger = Logger();
  final MarkRepository _myRepo;

  CheckMarkViewModel(this._myRepo);

  MarkLocal? _markLocal;
  MarkLocal? get markLocal => _markLocal;

  List<Map<String, Object>>? _dataDiemTongKet = [];
  List<Map<String, Object>>? get dataDiemTongKet => _dataDiemTongKet;

  List<Map<String, Object>>? _dataDiemHPTheoKy = [];
  List<Map<String, Object>>? get dataDiemHPTheoKy => _dataDiemHPTheoKy;

  int _selectedSemester = 0;

  int get selectedSemester => _selectedSemester;

  void setSelectedSemester(int value) {
    _selectedSemester = value;
    notifyListeners();
  }

  Status _status = Status.LOADING;
  Status get status => _status;

  Future<void> fetchMark(BuildContext context) async {
    _status = Status.LOADING;
    notifyListeners(); // Gọi để thông báo cập nhật trạng thái

    try {
      final token = await Datalocal.getAccessToken();
      print("dang lay data tu internet");
      final response = await _myRepo.fetchMarkUser(token!);
      _logger.d(response.listDiemTongKet.toString());

      _dataDiemTongKet = response.listDiemTongKet.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;

        return {
          "#": (index + 1),
          "Học kỳ ": "Học kỳ ${e.hocKi}, năm \n ${e.namBatDau}-${e.namKetThuc}",
          "Số TC-ĐK mới": e.soTinChi,
          "Điểm 4": double.parse(e.diem4.toStringAsFixed(2)),
          "Điểm 10": double.parse(e.diem10.toStringAsFixed(2)),
          "Điểm HB": double.parse(e.diemHb.toStringAsFixed(2)),
          "TC TL HK": e.tinChiTichLuyHocKi,
          "Xếp loại": e.xepLoai,
          "Điểm 4 TL": double.parse(e.diem4TichLuy.toStringAsFixed(2)),
          "Điểm 10 TL": double.parse(e.diem10TichLuy.toStringAsFixed(2)),
          "TC Tích luỹ": e.tongTinChiTichLuy
        };
      }).toList();
// Đảm bảo _dataDiemHPTheoKy có cấu trúc phù hợp với TableDataCustom
      _dataDiemHPTheoKy = response.listDiemHocPhanTheoKy.map((entry) {
        return {
          "Học kỳ":
              "Học kỳ ${entry.hocKi}, năm ${entry.namBatDau}-${entry.namKetThuc}",
          "list_diem_hoc_phan": entry.listDiemHocPhan.asMap().entries.map((e) {
            return {
              "#": e.key,
              "Tên lớp học phần": e.value.tenHocPhan,
              "Số TC": e.value.soTinChi,
              "Lần học": 1,
              "Điểm CC/GVHD": e.value.chuyenCan,
              "Điểm bài tập": e.value.baiTap,
              "Điểm giữa kỳ": e.value.giuaKi,
              "Điểm cuối kỳ": e.value.cuoiKi,
              "Điểm T10": e.value.tbm,
              "Điểm chữ": _getLetterGrade(e.value.tbm),
            };
          }).toList(),
        };
      }).toList();

      _logger.d(_dataDiemHPTheoKy);

      _status = Status.COMPLETED;
      notifyListeners();
      await Datalocal.setMark(response);
    } catch (e) {
      if (e is FetchDataException) {
        print("lay data local");
        final mark = await Datalocal.getMark();
        if (mark != null) {
          // Xử lý dữ liệu từ local
          _dataDiemTongKet = mark.listDiemTongKet.asMap().entries.map((entry) {
            int index = entry.key;
            var e = entry.value;

            return {
              "#": (index + 1),
              "Học kỳ ":
                  "Học kỳ ${e.hocKi}, năm ${e.namBatDau}-${e.namKetThuc}",
              "Số TC-ĐK mới": e.soTinChi,
              "Điểm 4": double.parse(e.diem4.toStringAsFixed(2)),
              "Điểm 10": double.parse(e.diem10.toStringAsFixed(2)),
              "Điểm HB": double.parse(e.diemHb.toStringAsFixed(2)),
              "TC TL HK": e.tinChiTichLuyHocKi,
              "Xếp loại": e.xepLoai,
              "Điểm 4 TL": double.parse(e.diem4TichLuy.toStringAsFixed(2)),
              "Điểm 10 TL": double.parse(e.diem10TichLuy.toStringAsFixed(2)),
              "TC Tích luỹ": e.tongTinChiTichLuy
            };
          }).toList();

          _dataDiemHPTheoKy = mark.listDiemHocPhanTheoKy.map((entry) {
            return {
              "Học kỳ":
                  "Học kỳ ${entry.hocKi}, năm ${entry.namBatDau}-${entry.namKetThuc}",
              "list_diem_hoc_phan":
                  entry.listDiemHocPhan.asMap().entries.map((e) {
                return {
                  "#": e.key,
                  "Tên lớp học phần": e.value.tenHocPhan,
                  "Số TC": e.value.soTinChi,
                  "Lần học": 1,
                  "Điểm CC/GVHD": e.value.chuyenCan,
                  "Điểm bài tập": e.value.baiTap,
                  "Điểm giữa kỳ": e.value.giuaKi,
                  "Điểm cuối kỳ": e.value.cuoiKi,
                  "Điểm T10": e.value.tbm,
                  "Điểm chữ": _getLetterGrade(e.value.tbm),
                };
              }).toList(),
            };
          }).toList();
          _status = Status.COMPLETED;
          Utils.toastWarn(e.toString(), context);
          notifyListeners();
        } else {
          _status = Status.ERROR;
          Utils.snackBar(e.toString(), context, true);
          // Utils.toastWarn(e.toString(), context);
        }
      }
    }
  }

  String _getLetterGrade(double tbm) {
    return tbm >= 8.5
        ? "A"
        : tbm >= 7.0
            ? "B"
            : tbm >= 5.5
                ? "C"
                : tbm >= 4.0
                    ? "D"
                    : "F";
  }
}
