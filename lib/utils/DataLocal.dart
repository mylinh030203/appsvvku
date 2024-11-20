import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/local/namhoc_hocky.local.dart';

import 'package:app_sinh_vien_vku/data/local/tuition_up_coming.local.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import '../data/local/mark.local.dart';
import '../data/local/tuition_paid.local.dart';
import '../data/local/user.local.dart';

class Datalocal {
  static const String _boxName = 'userBox';

  // Lưu accessToken
  static Future<void> setAccessToken(String token) async {
    var box = await Hive.openBox(_boxName);
    await box.put('token', token);
    if (kDebugMode) {
      // print("AccessToken saved in DataLocal: $token");
    }
  }

  // Lấy accessToken
  static Future<String?> getAccessToken() async {
    var box = await Hive.openBox(_boxName);
    return box.get('token');
  }

  // Xóa accessToken
  static Future<void> clearAccessToken() async {
    var box = await Hive.openBox(_boxName);
    await box.delete('token');
    if (kDebugMode) {
      // print("AccessToken cleared");
    }
  }

  // Lưu User
  static Future<void> setUser(UserLocal user) async {
    var box = await Hive.openBox(_boxName);
    await box.put('user', user);
    if (kDebugMode) {
      print("User saved in DataLocal: ${user.toJson()}");
    }
  }

  // Lấy User
  static Future<UserLocal?> getUser() async {
    var box = await Hive.openBox(_boxName);
    return box.get('user') as UserLocal?;
  }

  static Future<UserLocal?> checkUser() async {
    var box = await Hive.openBox(_boxName);
    return box.get('user') as UserLocal?;
  }

  // Xóa User
  static Future<void> clearUser() async {
    var box = await Hive.openBox(_boxName);
    await box.delete('user');
    if (kDebugMode) {
      print("User cleared from DataLocal");
    }
  }

  static const String _markBox = 'markBox';

  // Lưu điểm số
  static Future<void> setMark(MarkLocal mark) async {
    var box = await Hive.openBox(_markBox);
    await box.put('mark', mark);
    if (kDebugMode) {
      print("Mark saved in DataLocal: ${mark.toJson()}");
    }
  }

  // Lấy điểm số
  static Future<MarkLocal?> getMark() async {
    var box = await Hive.openBox(_markBox);
    return box.get('mark') as MarkLocal?;
  }

  // Xóa điểm số
  static Future<void> clearMark() async {
    var box = await Hive.openBox(_markBox);
    await box.delete('mark');
    if (kDebugMode) {
      print("Mark cleared from DataLocal");
    }
  }

  static const String _tuitionBox = 'tuitionPaidBox';
  // Lưu danh sách học phí
  static Future<void> setTuitionPaidList(List<TuitionPaidLocal> tuitionPaidList) async {
    var box = await Hive.openBox(_tuitionBox);
    await box.put('tuitionPaidList', tuitionPaidList.cast<dynamic>());
  }

  // Lấy danh sách học phí từ Hive
  static Future<List<TuitionPaidLocal>?> getTuitionPaidList() async {
    var box = await Hive.openBox(_tuitionBox);
    List<dynamic>? storedList = box.get('tuitionPaidList');

    if (storedList != null) {
      return storedList.cast<TuitionPaidLocal>();
    }
    return null;
  }

  // Xóa danh sách học phí
  static Future<void> clearTuitionPaidList() async {
    var box = await Hive.openBox<List<TuitionPaidLocal>>(_boxName);
    await box.delete('tuitionUpComingList');
    if (kDebugMode) {
      print("TuitionPaidList cleared from DataLocal");
    }
  }

  //------------
  static Future<void> setTuitionUpComingList(List<TuitionUpComingLocal> tuitionPaidList) async {
    var box = await Hive.openBox(_tuitionBox);
    await box.put('tuitionUpComingList', tuitionPaidList);
  }

  // Lấy danh sách học phí từ Hive
  static Future<List<TuitionUpComingLocal>?> getTuitionUpComingList() async {
    var box = await Hive.openBox(_tuitionBox);
    List<dynamic>? storedList = box.get('tuitionUpComingList');

    if (storedList != null) {
      return storedList.cast<TuitionUpComingLocal>();
    }
    return null;
  }

  // Xóa danh sách học phí
  static Future<void> clearTuitionUpComingList() async {
    var box = await Hive.openBox<List<TuitionUpComingLocal>>(_boxName);
    await box.delete('tuitionUpComingList');
    if (kDebugMode) {
      print("TuitionPaidList cleared from DataLocal");
    }
  }

  static const String _hocPhanBox = 'hocPhanBox';

  // Lưu DS học phần
  static Future<void> setDSHocPhan(List<ThoiKhoaBieu> dsHocphan, int year, int hocky) async {
    var box = await Hive.openBox<List<ThoiKhoaBieu>>(_hocPhanBox);
    var semester = AppValues.getCurrentSemester();
    if (semester[0] == year && semester[1] == hocky) await box.put('dsHocPhan', dsHocphan);
  }

  // Lấy danh sách hocphan
  static Future<List<ThoiKhoaBieu>?> getDSHocPhanLocal() async {
    var box = await Hive.openBox<List<ThoiKhoaBieu>>(_hocPhanBox);
    List<dynamic>? storedList = box.get('dsHocPhan');

    if (storedList != null) {
      return storedList.cast<ThoiKhoaBieu>();
    }
    return null;
  }

  // Xóa danh sách hocphan
  static Future<void> clearDSHocPhanLocal() async {
    var box = await Hive.openBox<List<ThoiKhoaBieu>>(_hocPhanBox);
    await box.delete('dsHocPhan');
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }

  static const String _namhocHockyBox = 'namhocHockyBox';

  // Lưu DS Năm học học kỳ
  static Future<void> setDSNamhocHocKyLocal(List<NamhocHocky> dsNamhocHocky) async {
    var box = await Hive.openBox<List<NamhocHocky>>(_namhocHockyBox);
    await box.put('dsNamhocHocky', dsNamhocHocky);
  }

  // Lấy danh sách Năm học học kỳ
  static Future<List<NamhocHocky>?> getDSNamhocHocKyLocal() async {
    var box = await Hive.openBox<List<NamhocHocky>>(_namhocHockyBox);
    List<dynamic>? storedList = box.get('dsNamhocHocky');

    if (storedList != null) {
      return storedList.cast<NamhocHocky>();
    }
    return null;
  }

  // Xóa danh sách Năm học học kỳ
  static Future<void> clearDSNamhocHocKyLocal() async {
    var box = await Hive.openBox<List<NamhocHocky>>(_namhocHockyBox);
    await box.delete('dsNamhocHocky');
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }
}
