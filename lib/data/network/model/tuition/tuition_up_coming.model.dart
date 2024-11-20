class TuitionUpComingResponseModel {
  final String tenHocPhan;
  final int soTinChi;
  final double soTien;

  TuitionUpComingResponseModel({required this.tenHocPhan, required this.soTinChi, required this.soTien});

  factory TuitionUpComingResponseModel.fromJson(Map<String, dynamic> json) {
    return TuitionUpComingResponseModel(
      soTinChi: json['so_tin_chi'],
      tenHocPhan: json['ten_hoc_phan'] as String,
      soTien: (json['so_tien'] is int) ? (json['so_tien'] as int).toDouble() : json['so_tien'] as double,
    );
  }

}
