import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/components/certificate_card.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraduationCertificateScreen extends StatelessWidget {
  const GraduationCertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CertificateViewModel certificateViewModel = Provider.of<CertificateViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await certificateViewModel.fetchDSChungchi();
    });

    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 0,
        color: AppColors.secondPrimary,
        onRefresh: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await certificateViewModel.fetchDSChungchi();
          });
        },
        child: ListView(
          children: [
            // Hiển thị thông tin trang app bar
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.black,
              title: Column(
                children: [
                  Text(
                    'Chứng chỉ tốt nghiệp',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeXl, AppSize.fontSizeXl),
                          color: AppColors.secondPrimary,
                        ),
                  ),
                ],
              ),
            ),

            // Hiển thị danh sách minh chứng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
              child: Consumer<CertificateViewModel>(
                builder: (context, value, child) {
                  switch (value.dsChungChi.status!) {
                    case Status.LOADING:
                      return Container(
                        width: AppInfo.getScreenWidth(context),
                        height: AppInfo.getScreenWidth(context),
                        child: const CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    case Status.ERROR:
                      return Text('Error: ');
                    case Status.COMPLETED:
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CertificateCard(
                            chungchi: value.dsChungChi.data!.dsChungChi![index],
                            guiMinhChung: () {
                              value.setSelectedMinhchung(index);
                              AppHelperFunctions.navigateToScreenName(context, RoutesName.proof);
                            },
                            minhChungDetails: () {
                              if (value.dsChungChi.data!.dsChungChi![index].minhChung != null) {
                                value.setSelectedMinhchung(index);
                                AppHelperFunctions.navigateToScreenName(context, RoutesName.certificate_details);
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),
                        itemCount: value.dsChungChi.data!.dsChungChi!.length,
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
