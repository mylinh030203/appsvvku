import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_sinh_vien_vku/utils/local/BoxType.dart';
import 'package:flutter/foundation.dart';

class ThoiKhoaBieuLocalImpl extends BoxLocal<List<ThoiKhoaBieu>> implements BaseLocal<List<ThoiKhoaBieu>> {
  ThoiKhoaBieuLocalImpl() : super(BoxType.THOI_KHOA_BIEU_BOX.name);

  @override
  Future<void> clearData() async {
    await clearValue();
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }

  @override
  Future<List<ThoiKhoaBieu>?> getData() async {
    return await getValue();
  }

  @override
  Future<void> setData(List<ThoiKhoaBieu> data) async {
    await setValue(data);
  }
}
