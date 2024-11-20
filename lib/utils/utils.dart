import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 40,
    );
  }

  static toastDev() {
    Fluttertoast.showToast(
      msg: "Hiện chức năng này chưa được phát triển!.",
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: AppSize.fontSizeLg,
    );
  }

  static toastError(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 40,
    );
  }

  static toastWarn(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 2500),
      backgroundColor: Colors.orange,
    ));
  }

  static snackBar(String message, BuildContext context, bool isError) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 2500),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      //barrierColor: const Color.fromARGB(255, 149, 149, 149),
      builder: (BuildContext context) {
        // return LoadingModal();
        return Center(child: Container(height: 60, width: 60, child: CircularProgressIndicator()));
      },
    );
  }
}
