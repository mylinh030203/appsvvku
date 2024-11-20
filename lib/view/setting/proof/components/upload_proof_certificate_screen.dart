import 'package:app_sinh_vien_vku/components/ButtonComponent.dart';
import 'package:app_sinh_vien_vku/components/ContainerComponent.dart';
import 'package:app_sinh_vien_vku/components/SectionComponent.dart';
import 'package:app_sinh_vien_vku/components/SpaceComponent.dart';
import 'package:app_sinh_vien_vku/components/TextComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/components/certificate_camera_button.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/components/certificate_divider.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/components/certificate_popup_status.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:open_file/open_file.dart';

import '../../../../constants/AppInfo.dart';
import 'dashedBorderPainter.dart';

class ProofScreen extends StatelessWidget {
  const ProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);

    CertificateViewModel certificateViewModel = Provider.of<CertificateViewModel>(context, listen: false);
    return Stack(
      children: [
        ContainerComponent(isScroll: true, isBack: true, title: "Upload minh chứng", children: [
          SectionComponent(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            children: [
              // Hiện thị chỗ upload file
              TextComponent(
                text: "Gửi minh chứng ${certificateViewModel.chungchi!.tenLoaiChungChi}",
                color: AppColors.secondPrimary,
                type: TextType.bold,
                fontSize: isSmall ? 16 : 18,
                softWrap: true,
              ),
              SizedBox(height: 20),

              // Hiển thị vị trí chọn file
              DashedBorderContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmall ? 70 : 80, vertical: 30),
                  child: Column(
                    children: [
                      Icon(Icons.cloud_upload, size: isSmall ? 60 : 90, color: AppColors.secondPrimary),
                      SpaceComponent(
                        height: isSmall ? 20 : 40,
                      ),
                      Buttoncomponent(
                        onPress: () async => await certificateViewModel.uploadMinhChungChungChi(),
                        textFont: 12,
                        text: "Chọn file",
                        type: "primary",
                        height: 36,
                        width: 148,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.spaceBtwItems),
              WaringFileLimitWidget(),
              // Hiển thi divider
              const SizedBox(height: AppSize.spaceBtwItems),
              CertificateDividerWidgets(),
              // Hiển thi nút camera
              const SizedBox(height: AppSize.spaceBtwSections),
              CameraButtonWidgets()
            ],
          ),
        ]),
        // Hiển thi thông tin xử lý
        CertificatePopUpStatusWidget(),
      ],
    );
  }
}

class WaringFileLimitWidget extends StatelessWidget {
  const WaringFileLimitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.exclamationmark_triangle_fill, color: Colors.red),
        SizedBox(width: AppSize.xs),
        Text(
          'Giới hạn dung lượng: 1 MB, Giới hạn file: 1',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                color: Colors.red,
              ),
        ),
      ],
    );
  }
}
