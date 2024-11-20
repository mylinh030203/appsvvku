// ignore: file_names
import 'package:flutter/material.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomModal({super.key, 
    required this.title,
    required this.content,
     this.onConfirm,
     this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondPrimary,
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          // ignore: prefer_const_constructors
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
