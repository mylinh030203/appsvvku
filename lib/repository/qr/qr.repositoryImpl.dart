import 'dart:convert';

import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/repository/qr/qr.repository.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../data/network/model/qr/qr.model.dart';

class QrRepositoryImpl implements QrRepository {
  Logger _logger = Logger();
  final BaseApisService _apisService = NetworkApiService();
  // @override
  // Future<GetScheduleModel> fetchQrScheduleStudent(int id) async {
  //   // Call the API without providing a token
  //   try {
  //     dynamic result =
  //         await _apisService.getApiResponse("${AppInfo.qrEndPoint}$id", null);
  //     _logger.d("data : ${GetScheduleModel.fromJson(result).toString()}");
  //     return GetScheduleModel.fromJson(result);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  @override
  Future<bool> rollCallStudent(String token, int idTkb) async {
    try {
      bool result = await _apisService.postApiResponse(
          "${AppInfo.qrEndPoint}${idTkb}", null, token);
          _logger.d(result);
      return result;
      
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<GetScheduleModel?> fetchQrScheduleStudent(int id) async {
    try {
      Response data =
          await get(Uri.parse("${AppInfo.getScheduleQrEndPoint}${id}"));
      dynamic rs = jsonDecode(utf8.decode(data.bodyBytes));
      _logger.d("data : ${GetScheduleModel.fromJson(rs).toString()}");
      return GetScheduleModel.fromJson(rs);
    } catch (e) {
      throw e;
    }
  }
}