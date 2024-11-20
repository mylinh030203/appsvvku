import 'package:app_sinh_vien_vku/components/PopUpAnnouncemnentCompoment.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificatePopUpStatusWidget extends StatelessWidget {
  const CertificatePopUpStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CertificateViewModel>(
      builder: (context, value, child) {
        switch (value.statusUploadMinhChung) {
          case Status.COMPLETED:
            return PopUpAnnouncementComponent(
              buttonText: "Trở về trang chứng chỉ",
              bodyText: "Gửi minh chứng thành công. Vui lòng chờ để bên đào tạo xét duyệt",
              onPress: () async {
                value.setstatusUploadMinhChung();
                Navigator.pop(context);
                await value.fetchDSChungchi();
              },
              status: Status.COMPLETED,
            );
          case Status.LOADING:
            return Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.black.withOpacity(0.5),
                child: Center(
                  child: const CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ));
          case Status.ERROR:
            return PopUpAnnouncementComponent(
              buttonText: "Trở về trang chứng chỉ",
              bodyText: "Rất tiếc! Đã xảy ra lỗi. Vui lòng hãy gửi minh chứng lại",
              onPress: () async {
                value.setstatusUploadMinhChung();
                Navigator.pop(context);
                await value.fetchDSChungchi();
              },
              status: Status.ERROR,
            );
          case null:
            return Container();
        }
      },
    );
  }
}
