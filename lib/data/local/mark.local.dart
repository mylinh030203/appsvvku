import 'package:hive/hive.dart';

part 'mark.local.g.dart';

@HiveType(typeId: 1)
class MarkLocal extends HiveObject {
  @HiveField(0)
  final List<DiemTongKet> listDiemTongKet;

  @HiveField(1)
  final List<DiemHocPhanTheoKy> listDiemHocPhanTheoKy;

  MarkLocal({
    required this.listDiemTongKet,
    required this.listDiemHocPhanTheoKy,
  });

  factory MarkLocal.fromJson(Map<String, dynamic> json) {
    return MarkLocal(
      listDiemTongKet: (json['list_diem_tong_ket'] as List)
          .map((item) => DiemTongKet.fromJson(item))
          .toList(),
      listDiemHocPhanTheoKy: (json['list_diem_hoc_phan_theo_ky'] as List)
          .map((item) => DiemHocPhanTheoKy.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list_diem_tong_ket': listDiemTongKet.map((item) => item.toJson()).toList(),
      'list_diem_hoc_phan_theo_ky': listDiemHocPhanTheoKy.map((item) => item.toJson()).toList(),
    };
  }

 @override
  String toString() {
    return 'MarkLocal(listDiemTongKet: ${listDiemTongKet.map((e) => e.toString()).toList()}, listDiemHocPhanTheoKy: ${listDiemHocPhanTheoKy.map((e) => e.toString()).toList()})';
  }
  
}

@HiveType(typeId: 2)
class DiemTongKet {
  @HiveField(0)
  final int namBatDau;
  @HiveField(1)
  final int namKetThuc;
  @HiveField(2)
  final int hocKi;
  @HiveField(3)
  final int soTinChi;
  @HiveField(4)
  final double diem4;
  @HiveField(5)
  final double diem10;
  @HiveField(6)
  final double diemHb;
  @HiveField(7)
  final int tinChiTichLuyHocKi;
  @HiveField(8)
  final String xepLoai;
  @HiveField(9)
  final double diem4TichLuy;
  @HiveField(10)
  final double diem10TichLuy;
  @HiveField(11)
  final int tongTinChiTichLuy;

  DiemTongKet({
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

  factory DiemTongKet.fromJson(Map<String, dynamic> json) {
    return DiemTongKet(
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
   @override
  String toString() {
    return 'DiemTongKet(hocKi: $hocKi)';
  }
}

@HiveType(typeId: 3)
class DiemHocPhanTheoKy {
  @HiveField(0)
  final int namBatDau;
  @HiveField(1)
  final int namKetThuc;
  @HiveField(2)
  final int hocKi;
  @HiveField(3)
  final List<DiemHocPhan> listDiemHocPhan;

  DiemHocPhanTheoKy({
    required this.namBatDau,
    required this.namKetThuc,
    required this.hocKi,
    required this.listDiemHocPhan,
  });

  factory DiemHocPhanTheoKy.fromJson(Map<String, dynamic> json) {
    return DiemHocPhanTheoKy(
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      hocKi: json['hoc_ki'],
      listDiemHocPhan: (json['list_diem_hoc_phan'] as List)
          .map((item) => DiemHocPhan.fromJson(item))
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
  @override
  String toString() {
    return 'DiemHocPhanTheoKy(hocKy: $hocKi, listDiemHocPhan: $listDiemHocPhan)';
  }
}

@HiveType(typeId: 4)
class DiemHocPhan {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double tbm;
  @HiveField(2)
  final double chuyenCan;
  @HiveField(3)
  final double baiTap;
  @HiveField(4)
  final double giuaKi;
  @HiveField(5)
  final double cuoiKi;
  @HiveField(6)
  final int soTinChi;
  @HiveField(7)
  final String tenHocPhan;

  DiemHocPhan({
    required this.id,
    required this.tbm,
    required this.chuyenCan,
    required this.baiTap,
    required this.giuaKi,
    required this.cuoiKi,
    required this.soTinChi,
    required this.tenHocPhan,
  });

  factory DiemHocPhan.fromJson(Map<String, dynamic> json) {
    return DiemHocPhan(
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
