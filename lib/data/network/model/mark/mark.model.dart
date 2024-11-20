class MarkResponseModel {
  final List<DiemTongKetApi> listDiemTongKet;
  final List<DiemHocPhanTheoKyApi> listDiemHocPhanTheoKy;

  MarkResponseModel({
    required this.listDiemTongKet,
    required this.listDiemHocPhanTheoKy,
  });

  factory MarkResponseModel.fromJson(Map<String, dynamic> json) {
    return MarkResponseModel(
      listDiemTongKet: (json['list_diem_tong_ket'] as List)
          .map((item) => DiemTongKetApi.fromJson(item))
          .toList(),
      listDiemHocPhanTheoKy: (json['list_diem_hoc_phan_theo_ky'] as List)
          .map((item) => DiemHocPhanTheoKyApi.fromJson(item))
          .toList(),
    );
  }

    factory MarkResponseModel.toMarkResponseLocal(Map<String, dynamic> json) {
    return MarkResponseModel(
      listDiemTongKet: (json['list_diem_tong_ket'] as List)
          .map((item) => DiemTongKetApi.fromJson(item))
          .toList(),
      listDiemHocPhanTheoKy: (json['list_diem_hoc_phan_theo_ky'] as List)
          .map((item) => DiemHocPhanTheoKyApi.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list_diem_tong_ket': listDiemTongKet.map((item) => item.toJson()).toList(),
      'list_diem_hoc_phan_theo_ky': listDiemHocPhanTheoKy.map((item) => item.toJson()).toList(),
    };
  }
}

class DiemTongKetApi {
  final int namBatDau;
  final int namKetThuc;
  final int hocKi;
  final int soTinChi;
  final double diem4;
  final double diem10;
  final double diemHb;
  final int tinChiTichLuyHocKi;
  final String xepLoai;
  final double diem4TichLuy;
  final double diem10TichLuy;
  final int tongTinChiTichLuy;

  DiemTongKetApi({
    required this.namBatDau,
    required this.namKetThuc,
    required this.hocKi,
    required this.soTinChi,
    required this.diem4,
    required this.diem10,
    required this.diemHb,
    required this.tinChiTichLuyHocKi,
    required this.xepLoai,
    required this.diem4TichLuy,
    required this.diem10TichLuy,
    required this.tongTinChiTichLuy,
  });

  factory DiemTongKetApi.fromJson(Map<String, dynamic> json) {
    return DiemTongKetApi(
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      hocKi: json['hoc_ki'],
      soTinChi: json['so_tin_chi'],
      diem4: json['diem_4'].toDouble(),
      diem10: json['diem_10'].toDouble(),
      diemHb: json['diem_hb'].toDouble(),
      tinChiTichLuyHocKi: json['tin_chi_tich_luy_hoc_ki'],
      xepLoai: json['xep_loai'],
      diem4TichLuy: json['diem_4_tich_luy'].toDouble(),
      diem10TichLuy: json['diem_10_tich_luy'].toDouble(),
      tongTinChiTichLuy: json['tong_tin_chi_tich_luy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nam_bat_dau': namBatDau,
      'nam_ket_thuc': namKetThuc,
      'hoc_ki': hocKi,
      'so_tin_chi': soTinChi,
      'diem_4': diem4,
      'diem_10': diem10,
      'diem_hb': diemHb,
      'tin_chi_tich_luy_hoc_ki': tinChiTichLuyHocKi,
      'xep_loai': xepLoai,
      'diem_4_tich_luy': diem4TichLuy,
      'diem_10_tich_luy': diem10TichLuy,
      'tong_tin_chi_tich_luy': tongTinChiTichLuy,
    };
  }
}

class DiemHocPhanTheoKyApi {
  final int namBatDau;
  final int namKetThuc;
  final int hocKi;
  final List<DiemHocPhanApi> listDiemHocPhan;

  DiemHocPhanTheoKyApi({
    required this.namBatDau,
    required this.namKetThuc,
    required this.hocKi,
    required this.listDiemHocPhan,
  });

  factory DiemHocPhanTheoKyApi.fromJson(Map<String, dynamic> json) {
    return DiemHocPhanTheoKyApi(
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      hocKi: json['hoc_ki'],
      listDiemHocPhan: (json['list_diem_hoc_phan'] as List)
          .map((item) => DiemHocPhanApi.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nam_bat_dau': namBatDau,
      'nam_ket_thuc': namKetThuc,
      'hoc_ki': hocKi,
      'list_diem_hoc_phan': listDiemHocPhan.map((item) => item.toJson()).toList(),
    };
  }
}

class DiemHocPhanApi {
  final int id;
  final double tbm;
  final double chuyenCan;
  final double baiTap;
  final double giuaKi;
  final double cuoiKi;
  final int soTinChi;
  final String tenHocPhan;

  DiemHocPhanApi({
    required this.id,
    required this.tbm,
    required this.chuyenCan,
    required this.baiTap,
    required this.giuaKi,
    required this.cuoiKi,
    required this.soTinChi,
    required this.tenHocPhan,
  });

  factory DiemHocPhanApi.fromJson(Map<String, dynamic> json) {
    return DiemHocPhanApi(
      id: json['id'],
      tbm: json['tbm'].toDouble(),
      chuyenCan: json['chuyen_can'].toDouble(),
      baiTap: json['bai_tap']?.toDouble() ?? 0.0,
      giuaKi: json['giua_ki'].toDouble(),
      cuoiKi: json['cuoi_ki'].toDouble(),
      soTinChi: json['so_tin_chi'],
      tenHocPhan: json['ten_hoc_phan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tbm': tbm,
      'chuyen_can': chuyenCan,
      'bai_tap': baiTap,
      'giua_ki': giuaKi,
      'cuoi_ki': cuoiKi,
      'so_tin_chi': soTinChi,
      'ten_hoc_phan': tenHocPhan,
    };
  }
}
