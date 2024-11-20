
import 'package:hive/hive.dart';

part 'tuition_up_coming.local.g.dart';

@HiveType(typeId: 6)
class TuitionUpComingLocal extends HiveObject {
  @HiveField(0)
  String tenHocPhan;

  @HiveField(1)
  int soTinChi;

  @HiveField(2)
  double soTien;

  TuitionUpComingLocal({required this.tenHocPhan, required this.soTinChi, required this.soTien});

  Map<String, dynamic> toJson() => {
        'ten_hoc_phan': tenHocPhan,
        'so_tin_chi': soTinChi,
        'so_tien': soTien,
      };
}