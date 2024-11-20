import '../../data/network/model/qr/qr.model.dart';

abstract class QrRepository {
  Future<GetScheduleModel?> fetchQrScheduleStudent( int id);
  Future<bool> rollCallStudent(String token, int idTkb);
}