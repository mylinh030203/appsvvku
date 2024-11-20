import 'package:app_sinh_vien_vku/data/network/model/tuition/tuition_paid.model.dart';
import 'package:app_sinh_vien_vku/repository/tuition/tuition.repository.dart';
import 'package:logger/logger.dart';
import '../../constants/AppInfo.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../data/network/model/tuition/tuition_up_coming.model.dart';

class TuitionRepositoryImpl implements TuitionRepository {
   final BaseApisService _apisService = NetworkApiService();
  Logger _logger = Logger();
  @override
  Future<List<TuitionPaidResponseModel>> getListTuitionPaid(String token) async{
  try {

      final res = await _apisService.getApiResponse(AppInfo.fetchTuitionPaidEndPoint, token);
     
      List<TuitionPaidResponseModel> tuitionList = (res as List)
          .map((item) => TuitionPaidResponseModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return tuitionList;
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      throw e;
    }
  }
  
  @override
  Future<List<TuitionUpComingResponseModel>> getListTuitionUpComing(String token) async{
    try {

      final res = await _apisService.getApiResponse(AppInfo.fetchTuitionUpComingEndPoint, token);
     
      List<TuitionUpComingResponseModel> tuitionList = (res as List)
          .map((item) => TuitionUpComingResponseModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return tuitionList;
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      throw e;
    }
  }
  
}