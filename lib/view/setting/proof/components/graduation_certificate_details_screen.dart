import 'package:app_sinh_vien_vku/components/AppBarComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateDetailsScreen extends StatelessWidget {
  const CertificateDetailsScreen({super.key});

  Stream<Image> _loadImageStream(String url) async* {
    yield Image.network(url);
  }

  @override
  Widget build(BuildContext context) {
    CertificateViewModel certificateViewModel = Provider.of<CertificateViewModel>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarComponent(
                showBackArrow: true,
                isLeadingIconWhite: AppColors.black,
                title: Column(
                  children: [
                    Text(
                      'Thông tin ${certificateViewModel.chungchi!.tenLoaiChungChi}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeXl, AppSize.fontSizeXl),
                            color: AppColors.secondPrimary,
                          ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: AppSize.spaceBtwSections),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.lg),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: InteractiveViewer(
                      child: Image.network(
                        certificateViewModel.chungchi!.minhChung!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            // Hiển thị hình ảnh sau khi tải xong
                          } else {
                            return child;
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error); // Hiển thị icon lỗi nếu tải không thành công
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.xl),
                child: Container(
                  decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSize.lg),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.share,
                                size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                              ),
                              SizedBox(height: AppSize.sm),
                              Text(
                                'Chia sẻ',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: AppSize.md),
                      GestureDetector(
                        onTap: () async {
                          if (!certificateViewModel.isDownloading) await certificateViewModel.downloadImage(context, certificateViewModel.chungchi!.minhChung!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSize.lg),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.square_arrow_down,
                                size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                              ),
                              SizedBox(height: AppSize.sm),
                              Text(
                                'Tải xuống',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSize.spaceBtwSections)
            ],
          ),
          Consumer<CertificateViewModel>(
            builder: (context, value, child) {
              if (value.isDownloading)
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.lg, vertical: AppSize.lg),
                    decoration: BoxDecoration(color: AppColors.gray2.withOpacity(0.65), borderRadius: BorderRadius.circular(7)),
                    child: CircularProgressIndicator(
                      color: AppColors.secondPrimary,
                      strokeCap: StrokeCap.round,
                    ),
                  )),
                );
              return Container();
            },
          )
        ],
      ),
    );
  }
}
