import 'package:app_sinh_vien_vku/data/network/model/course_info/diem_danh.dart';

class BuoiHoc {
  final int id;
  final int idLophp;
  final String noiDung;
  final DateTime ngayDay;

  BuoiHoc({
    required this.id,
    required this.idLophp,
    required this.noiDung,
    required this.ngayDay,
  });

  // Factory method to create a DiemDanh object from JSON
  factory BuoiHoc.fromJson(Map<String, dynamic> json) {
    return BuoiHoc(
      id: json['id'],
      idLophp: json['idLophp'],
      noiDung: json['noiDung'],
      ngayDay: DateTime.parse(json['ngayDay']),
    );
  }

  // Method to convert a DiemDanh object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idLophp': idLophp,
      'noiDung': noiDung,
      'ngayDay': ngayDay.toIso8601String(),
    };
  }
}

class LichTrinhHocPhan extends BuoiHoc {
  final List<DiemDanh> dsDiemDanhChiTiet;

  LichTrinhHocPhan({
    required super.id,
    required super.idLophp,
    required super.noiDung,
    required super.ngayDay,
    required this.dsDiemDanhChiTiet,
  });

  // Factory method to create a DiemDanh object from JSON
  factory LichTrinhHocPhan.fromJson(Map<String, dynamic> json) {
    var list = json['dsDiemDanhChiTiet'] as List;
    List<DiemDanh> sinhVienList = list.map((i) => DiemDanh.fromJson(i)).toList();

    return LichTrinhHocPhan(
      id: json['id'],
      idLophp: json['idLophp'],
      noiDung: json['noiDung'],
      ngayDay: DateTime.parse(json['ngayDay']),
      dsDiemDanhChiTiet: sinhVienList,
    );
  }

  // Method to convert a DiemDanh object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idLophp': idLophp,
      'noiDung': noiDung,
      'ngayDay': ngayDay.toIso8601String(),
      'dsDiemDanhChiTiet': dsDiemDanhChiTiet.map((sinhVien) => sinhVien.toJson()).toList(),
    };
  }
}

class DSLichTrinhHocPhan {
  List<LichTrinhHocPhan>? dsLichTrinhHocPhan;
  DSLichTrinhHocPhan({this.dsLichTrinhHocPhan});

  DSLichTrinhHocPhan.fromJson(List<dynamic> json) {
    dsLichTrinhHocPhan = <LichTrinhHocPhan>[];
    json.forEach((v) {
      dsLichTrinhHocPhan!.add(LichTrinhHocPhan.fromJson(v));
    });
  }

  List<Map<String, dynamic>> toJson() {
    if (this.dsLichTrinhHocPhan != null) return this.dsLichTrinhHocPhan!.map((v) => v.toJson()).toList();
    return [];
  }
}
