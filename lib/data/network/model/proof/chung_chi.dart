import 'dart:io';

class ChungChi {
  int id;
  int? status;
  String tenLoaiChungChi;
  String? maSv;
  String? minhChung;

  ChungChi({
    required this.id,
    this.status,
    required this.tenLoaiChungChi,
    this.maSv,
    this.minhChung,
  });

  // Factory method to create an instance from JSON
  factory ChungChi.fromJson(Map<String, dynamic> json) {
    return ChungChi(
      id: json['id'],
      status: json['status'] as int?,
      tenLoaiChungChi: json['ten_loai_chung_chi'],
      maSv: json['ma_sv'] as String?,
      minhChung: json['minh_chung'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'ten_loai_chung_chi': tenLoaiChungChi,
      'ma_sv': maSv,
      'minh_chung': minhChung,
    };
  }
}

class ChungChiResponseModel {
  final int id;
  final String maSinhVien;
  final int idChungChi;
  final String minhChung;
  final int status;

  ChungChiResponseModel({
    required this.id,
    required this.maSinhVien,
    required this.idChungChi,
    required this.minhChung,
    required this.status,
  });

  // Factory constructor to create an instance from a JSON map
  factory ChungChiResponseModel.fromJson(Map<String, dynamic> json) {
    return ChungChiResponseModel(
      id: json['id'],
      maSinhVien: json['maSinhVien'],
      idChungChi: json['idChungChi'],
      minhChung: json['minhChung'],
      status: json['status'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maSinhVien': maSinhVien,
      'idChungChi': idChungChi,
      'minhChung': minhChung,
      'status': status,
    };
  }
}

class ChungChiRequestModel {
  final File file;

  ChungChiRequestModel({
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'file': file,
    };
  }
}

class DSChungChi {
  List<ChungChi>? dsChungChi;
  DSChungChi({this.dsChungChi});

  DSChungChi.fromJson(List<dynamic> json) {
    dsChungChi = <ChungChi>[];
    json.forEach((v) {
      dsChungChi!.add(ChungChi.fromJson(v));
    });
  }

  List<Map<String, dynamic>> toJson() {
    if (this.dsChungChi != null) return this.dsChungChi!.map((v) => v.toJson()).toList();
    return [];
  }
}
