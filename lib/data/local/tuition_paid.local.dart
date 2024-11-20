import 'package:hive/hive.dart';

part 'tuition_paid.local.g.dart';

@HiveType(typeId: 5)
class TuitionPaidLocal extends HiveObject {
  @HiveField(0)
  String namHocHocKy;

  @HiveField(1)
  double soTien;

  @HiveField(2)
  String? bienLai; // Có thể là null

  @HiveField(3)
  String? nguoiThu; // Có thể là null

  @HiveField(4)
  String? ngayThu; // Có thể là null

  TuitionPaidLocal({
    required this.namHocHocKy,
    required this.soTien,
    this.bienLai,
    this.nguoiThu,
    this.ngayThu,
  });

  Map<String, dynamic> toJson() => {
        'nam_hoc_hoc_ky': namHocHocKy,
        'so_tien': soTien,
        'bien_lai': bienLai,
        'nguoi_thu': nguoiThu,
        'ngay_thu': ngayThu,
      };
}
