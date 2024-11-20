import 'package:flutter/widgets.dart';

class AppInfo {
  // static const baseUrl = 'http://192.168.106.143:3333/api';
  static const baseUrl = 'http://192.168.10.7:3333/api';
  // static const baseUrl = 'https://training.vku.udn.vn:8443/api/api';

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobileLarge(BuildContext context) {
    return getScreenHeight(context) >= 830;
  }

  static bool isMobileMedium(BuildContext context) {
    return getScreenHeight(context) >= 660 && getScreenHeight(context) < 830;
  }

  static bool isMobileSmall(BuildContext context) {
    return getScreenHeight(context) < 660;
  }

  static const loginEndPoint = "$baseUrl/auth/signin";
  static const registerEndPoint = "$baseUrl/auth/register";
  static const verifyEndPoint = "$baseUrl/auth/verify";
  static const fetchProfileEndPoint = "$baseUrl/sinhvien/get-current";
  static const updateProfileEndPoint = "$baseUrl/sinhvien/cap-nhat";
  static const fetchMarkEndPoint = "$baseUrl/diem/current-student";
  static const fetchTuitionPaidEndPoint = "$baseUrl/hocphi/hoc-phi-da-nop";
  static const fetchTuitionUpComingEndPoint = "$baseUrl/hocphi/hoc-phi-sap-nop";
  static const HOCPHAN_TKB_WEEK_FECTH_ENDPOINT = "$baseUrl/tkb/tkbct-sv?";
  static const HOCPHAN_TKB_GETALL_ENDPOINT = "$baseUrl/tkb/tkbct-sv?namBatDau=";
  static const LICHTRINH_NOIDUNG_BUOIHOC = "$baseUrl/lich-trinh";
  static const NAMHOC_HOCKY_ENDPOINT = "$baseUrl/namhoc_hocky";
  static const CHUNGCHI_FETCH_ENDPOINT = "$baseUrl/minh-chung-tot-nghiep";
  static const qrEndPoint = "$baseUrl/sinhvien/diem-danh-QR?idTkb=";
  static const getScheduleQrEndPoint = "$baseUrl/lich-trinh/";
}
