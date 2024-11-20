import 'package:app_sinh_vien_vku/data/network/model/user/user_update.model.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../data/AppException.dart';
import '../../repository/profile/profile.repository.dart';
import '../../repository/profile/profile.repositoryImpl.dart';
import '../../data/local/user.local.dart';
import '../../utils/DataLocal.dart';
import '../../utils/utils.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileRepository _myRepo = ProfileRepositoryImpl();

  UserLocal? _userLocal;
  UserLocal? get userLocal => _userLocal;

  Status _status = Status.LOADING;
  Status get status => _status;

  Future<void> fetchUserProfile(BuildContext context) async {
    _status = Status.LOADING;
    notifyListeners();

    try {
      final token = await Datalocal.getAccessToken();
      print("dang lay data tu internet");
      final response = await _myRepo.getUserProfile(token!);
      _userLocal = UserLocal.fromUserResponseModel(response);

      _status = Status.COMPLETED;
      notifyListeners();
      await Datalocal.setUser(_userLocal!);
    } catch (e) {
      try {
        final token = await Datalocal.getAccessToken();
        final response = await _myRepo.getUserProfile(token!);
        _userLocal = UserLocal.fromUserResponseModel(response);

        _status = Status.COMPLETED;
        notifyListeners();
        await Datalocal.setUser(_userLocal!);
      } catch (e) {
        if (e is FetchDataException) {
          print("lay data local");
          Utils.toastWarn(e.toString(), context);
          final localUser = await Datalocal.getUser();
          if (localUser != null) {
            _userLocal = localUser;
            print(localUser);
            _status = Status.COMPLETED;
            notifyListeners();
          }
        } else {
          _status = Status.ERROR;
          Utils.snackBar(e.toString(), context, true);
        }
      }
    }
  }

  Future<void> refreshProfile(context) async {
    print("Refreshing profile...");
    _userLocal = null;
    await fetchUserProfile(context);
  }

  Future<void> deleteProfile() async {
    _userLocal = null;
    _status = Status.LOADING;
  }

  Future<void> updateProfile(
    BuildContext context,
    String? newEmail,
    String? newPhone,
    String? newNgayCapCCCD,
    String? newNoiCap,
    String? newTonGiao,
    String? newMaBYHT,
  ) async {
    _status = Status.LOADING;
    notifyListeners();

    try {
      final token = await Datalocal.getAccessToken();

      // Tạo bản sao của _userLocal với các trường mới cập nhật
      final dataRequest = UserPutRequestModel(
        id: _userLocal!.id,
        maSV: _userLocal!.maSV,
        hoTen: _userLocal!.hoTen,
        lopSinhHoat: _userLocal!.lopSinhHoat ?? "",
        nien_khoa: _userLocal!.nien_khoa,
        nganh: _userLocal!.nganh,
        chuyenNganh: _userLocal!.chuyenNganh ?? "",
        hocKyHienTai: _userLocal!.hocKyHienTai,
        numberCIC: _userLocal!.numberCIC,
        ngaySinh: _userLocal!.ngaySinh ?? "",
        noiSinh: _userLocal!.noiSinh ?? "",
        gioiTinh: _userLocal!.gioiTinh,
        queQuan: _userLocal!.queQuan ?? "",
        danToc: _userLocal!.danToc ?? "",
        dienThoai: newPhone ?? _userLocal!.dienThoai,
        email: newEmail ?? _userLocal!.email,
        doanVien: _userLocal!.doanVien ?? null,
        dienChinhSach: _userLocal!.dienChinhSach ?? "",
        dienThoaiGD: _userLocal!.dienThoaiGD,
        namTotNghiep: _userLocal!.namTotNghiep,
        truongThptTotNghiep: _userLocal!.truongThptTotNghiep,
        maTruongThptTotNghiep: _userLocal!.maTruongThptTotNghiep,
        status: _userLocal!.status ?? null,
        ngayCapCccd: newNgayCapCCCD ?? _userLocal!.ngayCapCccd,
        noiCapCccd: newNoiCap ?? _userLocal!.noiCapCccd,
        tonGiao: newTonGiao ?? _userLocal!.tonGiao,
        cuTruTinh: _userLocal!.cuTruTinh,
        cuTruQuanHuyen: _userLocal!.cuTruQuanHuyen,
        cuTruXaPhuong: _userLocal!.cuTruXaPhuong,
        cuTruToThon: _userLocal!.cuTruToThon,
        maSoBHYT: newMaBYHT ?? _userLocal!.maSoBHYT,
        emailVku: _userLocal!.emailVku,
        ngayKetNap: _userLocal!.ngayKetNap,
      );

      await _myRepo.updateUserProfile(dataRequest, token!);

      // Cập nhật lại _userLocal với thông tin mới
      _userLocal = UserLocal.updateField(dataRequest);
      _status = Status.COMPLETED;
      Utils.snackBar('Cập nhật thành công', context, false);
      await Datalocal.setUser(_userLocal!);
      AppHelperFunctions.navigateback(context);
    } catch (e) {
      _status = Status.ERROR;
      Utils.snackBar('Cập nhật thất bại: $e', context, true);
    } finally {
      notifyListeners();
    }
  }
}
