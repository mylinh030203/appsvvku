import 'dart:io';

import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/data/network/BaseApiService.dart';
import 'package:app_sinh_vien_vku/data/network/NetworkApiService.dart';
import 'package:app_sinh_vien_vku/data/network/model/proof/chung_chi.dart';
import 'package:app_sinh_vien_vku/repository/proof/proof.repository.dart';

class ProofRepositoryImpl implements ProofRepository {
  final BaseApisService _apisService = NetworkApiService();

  @override
  Future<DSChungChi> fetchDSChungChi(String token) async {
    try {
      final res = await _apisService.getApiResponse(AppInfo.CHUNGCHI_FETCH_ENDPOINT, token);
      print("data sau laay ${DSChungChi.fromJson(res)}");
      return DSChungChi.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      throw e;
    }
  }

  @override
  Future<ChungChiResponseModel> uploadMinhchung(File data, int idloaichungchi, String token) async {
    try {
      final url = AppInfo.CHUNGCHI_FETCH_ENDPOINT + "/$idloaichungchi";
      final res = await _apisService.fileApiResponse(url, data, token);
      // print("data sau laay ${DSChungChi.fromJson(res)}");
      return ChungChiResponseModel.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      throw e;
    }
  }
}
