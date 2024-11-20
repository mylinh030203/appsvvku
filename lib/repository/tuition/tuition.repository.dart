import 'package:app_sinh_vien_vku/data/network/model/tuition/tuition_paid.model.dart';

import '../../data/network/model/tuition/tuition_up_coming.model.dart';

abstract class TuitionRepository {
  Future<List<TuitionPaidResponseModel>> getListTuitionPaid(String token);
  Future<List<TuitionUpComingResponseModel>> getListTuitionUpComing(String token);
}