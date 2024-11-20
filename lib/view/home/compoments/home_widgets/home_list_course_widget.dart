import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_course_card.dart';
import 'package:app_sinh_vien_vku/view/home/compoments/home_widgets/home_filter_button.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeDSHocPhanWidget extends StatelessWidget {
  const HomeDSHocPhanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Nút lọc danh sách
          const HomeFilterWidget(),
          // Danh sách lớp học phần
          Consumer<HomeViewModel>(
            builder: (context, value, child) {
              switch (value.hocphanService.dsThoiKhoaBieu.status) {
                case Status.LOADING:
                  return CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.hocphanService.dsThoiKhoaBieu.message.toString());
                case Status.COMPLETED:
                  List<ThoiKhoaBieu> dsTKB = value.hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;
                  if (dsTKB.isEmpty) {
                    Text(
                      "Không có thông tin lớp hoc phần trong học kỳ này. Vui lòng chọn học kỳ khác",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                          ),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: AppSize.spaceBtwSections),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dsTKB.length,
                    itemBuilder: (context, index) {
                      return HomeCourseCardWidget(
                        thoiKhoaBieu: dsTKB[index],
                        onPress: () {
                          value.hocphanService.setThoiKhoaBieu(dsTKB[index]);
                          AppHelperFunctions.navigateToScreenName(context, RoutesName.coruse_details);
                        },
                      );
                    },
                  );
                case null:
                  return Container();
                // TODO: Handle this case.
              }
            },
          ),
        ],
      ),
    );
  }
}
