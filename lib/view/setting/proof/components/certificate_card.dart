import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/network/model/proof/chung_chi.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    super.key,
    required this.chungchi,
    required this.guiMinhChung,
    required this.minhChungDetails,
  });
  final ChungChi chungchi;
  final Function() guiMinhChung;
  final Function() minhChungDetails;

  @override
  Widget build(BuildContext context) {
    CertificateViewModel certificateViewModel = Provider.of<CertificateViewModel>(context, listen: false);
    return GestureDetector(
      onTap: () => minhChungDetails(),
      child: Container(
        color: AppColors.gray2.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chungchi.tenLoaiChungChi}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, 18.0), fontWeight: FontWeight.w800),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: AppSize.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Trạng thái: ', style: TextStyle(fontSize: AppValues.getResponsive(AppSize.iconXs, AppSize.iconSm, AppSize.iconSm))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.xs),
                        decoration: BoxDecoration(color: certificateViewModel.statusMap[chungchi.status][1], borderRadius: BorderRadius.circular(15)),
                        child: Text(certificateViewModel.statusMap[chungchi.status][0],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: chungchi.status != null ? AppColors.white : AppColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd))),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (chungchi.status != 1)
              GestureDetector(
                onTap: () => guiMinhChung(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.secondPrimary, borderRadius: BorderRadius.circular(10)),
                  child: Icon(CupertinoIcons.paperplane_fill, color: AppColors.white, size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
