import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraButtonWidgets extends StatelessWidget {
  const CameraButtonWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CertificateViewModel certificateViewModel = Provider.of<CertificateViewModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async => await certificateViewModel.openCamera(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.camera_fill, color: AppColors.secondPrimary),
                  const SizedBox(width: AppSize.sm),
                  Text(
                    "Sử dụng máy ảnh",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w700, fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg), color: AppColors.secondPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
