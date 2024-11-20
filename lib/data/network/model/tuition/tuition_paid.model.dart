class TuitionPaidResponseModel {
  final String namHocHocKy;
  final double soTien;
  final String? bienLai; // Có thể là null
  final String? nguoiThu; // Có thể là null
  final String? ngayThu; // Có thể là null

  TuitionPaidResponseModel({
    required this.namHocHocKy,
    required this.soTien,
    this.bienLai,
    this.nguoiThu,
    this.ngayThu,
  });

  factory TuitionPaidResponseModel.fromJson(Map<String, dynamic> json) {
    return TuitionPaidResponseModel(
      namHocHocKy: json['nam_hoc_hoc_ky'] as String,
      soTien: json['so_tien'] as double,
      bienLai: json['bien_lai'] as String?, // Có thể là null
      nguoiThu: json['nguoi_thu'] as String?, // Có thể là null
      ngayThu: json['ngay_thu'] as String?, // Có thể là null
    );
  }
}
