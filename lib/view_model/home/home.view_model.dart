import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/local/namhoc_hocky.local.dart';

import 'package:app_sinh_vien_vku/data/response/ApiResponse.dart';
// import 'package:app_sinh_vien_vku/data/network/model/schedule/hoc_phan.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/repository/schedue/hocphan_repositoryImpl.dart';
import 'package:app_sinh_vien_vku/repository/schedue/namhoc_hocky.repository.dart';
import 'package:app_sinh_vien_vku/utils/dataLocal.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';
import 'package:app_sinh_vien_vku/view_model/home/services/lophocphan.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/services/namhoc_hocky.service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeViewModel with ChangeNotifier {
  // Base variable
  final LopHocPhanService hocphanService;
  final NamHocHocKyService namHocHocKyService;

  // Contructor
  HomeViewModel({required this.hocphanService, required this.namHocHocKyService});

  final Logger _logger = Logger();

  // // Trạng thái ds các cuộc hẹn
  // var _statusCalendar = Status.LOADING;
  // Status get statusCalendar => _statusCalendar;
  // List<Appointment> _dsApointment = [];
  // List<Appointment> get dsApointment => _dsApointment;

  // DS Thời khóa biểu ngày
  List<ThoiKhoaBieu> dsTKBNgay = [];
  Status _statusTKBNgay = Status.LOADING;
  Status get statusTKBNgay => _statusTKBNgay;

  // Dropdown button
  bool _showMoreButton = false;
  bool get showMoreButton => _showMoreButton;

  // Variable storage
  int nienKhoa = AppValues.getCurrentSemester()[0];
  int hocky = AppValues.getCurrentSemester()[1];

  DateTime selectedDate = DateTime.now();

  Future<void> fetchDSHocPhan(String year, String hocky) async {
    // Lưu trữ lại giá trị niên khóa
    this.hocky = int.parse(hocky);
    this.nienKhoa = int.parse(year);

    await hocphanService.fetchDSHocPhanApi(year, hocky).then((value) {
      fetchDSHocPhanNgay(selectedDate);
    }).whenComplete(() => notifyListeners());
  }

  Future<void> fetchNamhocHocky() async {
    await namHocHocKyService.fetchDSNamhocHockyApi().then((value) {
      createDropDownItem();
    }).onError((error, stackTrace) async {
      createDropDownItem();
    }).whenComplete(() => notifyListeners());
  }

  pressShowMoreButton() {
    _showMoreButton = !_showMoreButton;
    notifyListeners();
  }

  void fetchDSHocPhanNgay(DateTime selectedDate) {
    _statusTKBNgay = Status.LOADING;
    dsTKBNgay.clear();
    notifyListeners();
    try {
      if (hocphanService.dsThoiKhoaBieu.data == null) {
        _statusTKBNgay = Status.ERROR;
        notifyListeners();
        return;
      }
      List<ThoiKhoaBieu> dsTKB = hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;

      int tuanHienTai = namHocHocKyService.tuanHienTai;
      int selectedWeekday = selectedDate.weekday + 1;

      // 2 Dk 1, thứ hôm nay = thứ ngày chọn
      // 2 số tuần ko chứa trong 2 chuôi ngày nghỉ hay báo nghỉ
      dsTKBNgay = dsTKB.where((e) {
        // Ngày được chọn có cùng thứ với học phần
        bool isSameWeekday = e.thu == selectedWeekday;
        List<int> dsTuanNghi = e.dsBaoBu.map((obj) => obj.tuanBu).toList() + e.dsBaoNghi.map((obj) => obj.tuanNghi).toList();
        bool isDayOff = dsTuanNghi.contains(tuanHienTai);

        bool isMakeUpClass = false;
        if (e.dsBaoBu.isNotEmpty) {
          for (var buoiBaoBu in e.dsBaoBu) {
            if (buoiBaoBu.thu == selectedDate.weekday + 1 && buoiBaoBu.tuanBu == tuanHienTai) {
              ThoiKhoaBieu tkb = ThoiKhoaBieu(
                  nhom: e.nhom,
                  idHocPhan: e.idHocPhan,
                  thu: buoiBaoBu.thu,
                  tietBatDau: buoiBaoBu.tietBatDau,
                  tietKetThuc: buoiBaoBu.tietKetThuc,
                  tuanBatDau: buoiBaoBu.tietBatDau,
                  tuanKetThuc: 0,
                  phong: buoiBaoBu.tenPhong,
                  tenThoiKhoaBieu: e.tenThoiKhoaBieu,
                  giangVienDay: e.giangVienDay,
                  dsBaoBu: [],
                  dsTuanNghi: [],
                  dsBaoNghi: [],
                  idThoiKhoaBieu: e.idThoiKhoaBieu);
              dsTKBNgay.add(tkb);

              isMakeUpClass = true;
            }
          }
        }
        return isSameWeekday && !isDayOff && !isMakeUpClass;
      }).toList();

      // dsTKBNgay.addAll(arrFilter);
      _statusTKBNgay = Status.COMPLETED;
      this.selectedDate = selectedDate;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _statusTKBNgay = Status.ERROR;
      notifyListeners();
    }
  }

  List createDropDownItem() {
    List initListNamhocHocky = [];

    List<NamhocHocky> dsNamhocHocky = removeDuplicatesByNamBatDau(namHocHocKyService.dsNamhocHocKy.data!.dsNamhocHocKy!);

    for (var namhocHocky in dsNamhocHocky) {
      List content = [namhocHocky.namBatDau, "${namhocHocky.namBatDau} - ${namhocHocky.namKetThuc}"];
      initListNamhocHocky.add(content);

      // DropdownMenuItem newItem =
      DropdownMenuItem(value: namhocHocky.namBatDau, child: Text("${namhocHocky.namBatDau} - ${namhocHocky.namKetThuc}", style: const TextStyle(fontSize: (AppSize.fontSizeSm))));
      // listDropDownMenuItems.add(newItem);
    }
    return initListNamhocHocky;
  }

  List<NamhocHocky> removeDuplicatesByNamBatDau(List<NamhocHocky> items) {
    final seenNamBatDau = <int>{};
    return items.where((item) => seenNamBatDau.add(item.namBatDau)).toList();
  }

  int getWeekByDay(DateTime selectedDate, DateTime startNamhocDate) {
    return ((selectedDate.difference(startNamhocDate).inDays) / 7).floor() + 1;
  }

  DateTime parseStringToDatetime(String date) {
    var timeline = date.split('-'); //[0 ,1 ,2]
    return DateTime(int.parse(timeline[2]), int.parse(timeline[1]), int.parse(timeline[0]));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

int getWeekByDay(DateTime selectedDate, DateTime startNamhocDate) {
  return ((selectedDate.difference(startNamhocDate).inDays) / 7).floor() + 1;
}
