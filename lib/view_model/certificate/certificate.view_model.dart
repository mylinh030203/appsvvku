import 'dart:io';

import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/data/network/model/proof/chung_chi.dart';
import 'package:app_sinh_vien_vku/data/response/ApiResponse.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/repository/proof/proof.repositoryImpl.dart';
import 'package:app_sinh_vien_vku/utils/dataLocal.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class CertificateViewModel with ChangeNotifier {
  final Logger _logger = Logger();
  final _myRepoMinhChung = ProofRepositoryImpl();

  ApiResponse<DSChungChi> dsChungChi = ApiResponse.loading();
  int _selectedMinhchung = 0;
  int get selectedMinhchung => _selectedMinhchung;
  ChungChi? chungchi;

  Status? _statusUploadMinhChung = null;
  Status? get statusUploadMinhChung => _statusUploadMinhChung;

  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;

  final Map<int?, dynamic> statusMap = {
    null: ["Chưa có", AppColors.gray2],
    0: ["Chờ xử lý", AppColors.secondPrimary.withOpacity(0.6)],
    1: ["Xác nhận", AppColors.sixthPrimary.withOpacity(0.6)],
    2: ["Từ chối", AppColors.fifthPrimary.withOpacity(0.6)],
  };

  setSelectedMinhchung(index) {
    chungchi = dsChungChi.data!.dsChungChi![index];
    notifyListeners();
  }

  setstatusUploadMinhChung() {
    _statusUploadMinhChung = null;
    notifyListeners();
  }

  Future<void> fetchDSChungchi() async {
    String? token = await Datalocal.getAccessToken();
    dsChungChi.status = Status.COMPLETED;

    _myRepoMinhChung.fetchDSChungChi(token!).then((value) {
      dsChungChi = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      dsChungChi = ApiResponse.error(error.toString());
      notifyListeners();
    });
  }

  Future<void> uploadMinhChungChungChi() async {
    _statusUploadMinhChung = Status.LOADING;
    notifyListeners();
    try {
      FilePickerResult? reslut = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf']);
      if (reslut == null) {
        _statusUploadMinhChung = null;
        notifyListeners();
        return;
      }

      File file = File(reslut.files.single.path!);
      await uploadMinhchung(file);
    } catch (e) {
      print(e);
      _statusUploadMinhChung = null;
      notifyListeners();
    }
  }

  Future<void> openCamera() async {
    _statusUploadMinhChung = Status.LOADING;
    notifyListeners();

    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 45);
      if (pickedFile == null) {
        _statusUploadMinhChung = null;
        notifyListeners();
        return;
      }

      File imageFile = File(pickedFile.path);
      await uploadMinhchung(imageFile);
    } catch (e) {
      print(e);
      _statusUploadMinhChung = null;
      notifyListeners();
    }
  }

  Future<void> uploadMinhchung(File file) async {
    try {
      String? token = await Datalocal.getAccessToken();
      ChungChiResponseModel response = await _myRepoMinhChung.uploadMinhchung(file, chungchi!.id, token!);

      // await Future.delayed(Duration(seconds: 3));
      // print(response);
      _statusUploadMinhChung = Status.COMPLETED;
    } catch (e) {
      _statusUploadMinhChung = Status.ERROR;
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> downloadImage(BuildContext context, String url) async {
    _isDownloading = true;
    notifyListeners();

    try {
      // Tạo đường dẫn lưu trữ hình ảnh
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download'); // Android Download directory
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory(); // iOS Documents directory
      } else {
        throw UnsupportedError('Unsupported platform');
      }
      String fileName = chungchi!.tenLoaiChungChi + ".jpg";
      String filePath = '${directory.path}/$fileName';

      // Tải xuống hình ảnh
      final Response response = await get(Uri.parse(url));
      final File file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);
      int fileSizeInBytes = file.lengthSync();
      _isDownloading = false;
      Utils.snackBar("Tải hình ảnh thành công", context, false);
    } catch (e) {
      _isDownloading = false;
      Utils.snackBar("Có lỗi xảy ra! Vui lòng tải lại", context, true);
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
