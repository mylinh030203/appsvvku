import 'dart:io';

import 'package:app_sinh_vien_vku/data/network/model/proof/chung_chi.dart';

abstract class ProofRepository {
  Future<DSChungChi> fetchDSChungChi(String token);
  Future<ChungChiResponseModel> uploadMinhchung(File data, int loaiChungchi, String token);
}
