import 'dart:developer';
import 'dart:io';

import 'package:app_sinh_vien_vku/components/PopUpAnnouncemnentCompoment.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/utils.dart';
import 'package:app_sinh_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import '../../view_model/qr/qr.view_model.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Logger _l = Logger();
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    BotttomNavigatorService botttomNavigatorService = Provider.of(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(flex: 4, child: _buildQrView(context)),
            ],
          ),
          Consumer<QrViewModel>(
            builder: (context, value, child) {
              switch (value.statusQR) {
                case Status.COMPLETED:
                  HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
                  // var hocphan = homeViewModel.dsHocPhan.data!.dsHocPhan!.firstWhere((e) => e.id == value.idTKb);
                  return PopUpAnnouncementComponent(
                    buttonText: "Trở về trang chủ",
                    bodyText: "Điểm danh thời khóa biểu cho học phần  thành công",
                    onPress: () async {
                      value.setStatusQR();
                      botttomNavigatorService.onRedirectScreen(BottomNavScreen.TRANGCHU);
                    },
                    status: Status.COMPLETED,
                  );
                case Status.LOADING:
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondPrimary,
                      ),
                    ),
                  );
                case Status.ERROR:
                  return PopUpAnnouncementComponent(
                    buttonText: "Thử lại",
                    bodyText: "Rất tiếc! ${value.error}",
                    onPress: () async {
                      value.setStatusQR();
                      controller!.resumeCamera();
                    },
                    status: Status.ERROR,
                  );
                case null:
                  return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = AppInfo.isMobileSmall(context) ? 200.0 : 250.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) async {
        _onPermissionSet(context, ctrl, p);
        try {
          await _onPermissonSetGeolocator();
        } catch (e) {}
      },
    );
  }

  void checkType(dynamic value) {
    if (value is int) {
      _l.d("The value is an integer. ${value}");
    } else if (value is String) {
      _l.d("The value is a string. ${value}");
    } else {
      _l.d("The value is of type: ${value.runtimeType}");
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        print("Scanned data: $scanData");
        controller.pauseCamera();
      });
      checkType(scanData);
      final qrViewModel = context.read<QrViewModel>();
      await qrViewModel.scanQRCode(scanData);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  Future<void> _onPermissonSetGeolocator() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled return an error message
      return Future.error('Location services are disabled.');
    }
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
