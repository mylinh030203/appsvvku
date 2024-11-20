// import 'package:app_sinh_vien_vku/components/InputComponent.dart';
// import 'package:app_sinh_vien_vku/constants/AppColor.dart';
// import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
// import 'package:app_sinh_vien_vku/constants/AppValue.dart';
// import 'package:app_sinh_vien_vku/view/course_details/component/course_student_card.dart';
// import 'package:app_sinh_vien_vku/view_model/cousre_information/cousre_details.view_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:app_sinh_vien_vku/data/response/status.dart';

// class CourseBottomSheetWidget extends StatelessWidget {
//   const CourseBottomSheetWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     CourseDetailsViewModel courseDetailsViewModel = Provider.of(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       courseDetailsViewModel.getSinhvienDiemDanh();
//     });
//     return Container(
//       height: AppValues.getResponsive(350, 500, 650),
//       padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: AppSize.md),
//           InputComponent(
//             controller: courseDetailsViewModel.inputSearchSV,
//             placeholder: "Nhập tên hoặc mã sinh viên",
//             affix: const Icon(CupertinoIcons.search),
//           ),
//           const SizedBox(height: AppSize.sm),

//           Text(
//             "Danh sách các học phần đã chọn",
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
//                 ),
//           ),
//           const SizedBox(height: AppSize.sm),

//           // Hiển thị danh sách sinh viên đã tích
//           const DsSinhVienHadCheckBox(),
//           const SizedBox(height: AppSize.xs),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Text(
//                   "Danh sách sinh viên",
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.w600,
//                         fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
//                       ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   courseDetailsViewModel.isSelectedAllSV = !courseDetailsViewModel.isSelectedAllSV;
//                   courseDetailsViewModel.selectedAllCheckBox(courseDetailsViewModel.isSelectedAllSV);
//                 },
//                 child: Consumer<CourseDetailsViewModel>(
//                   builder: (context, value, child) => Row(
//                     children: [
//                       Text(
//                         value.isSelectedAllSV ? "Bỏ chọn tất cả" : "Chọn tất cả",
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
//                             ),
//                       ),
//                       const SizedBox(width: AppSize.sm),
//                       Icon(value.isSelectedAllSV ? CupertinoIcons.square : CupertinoIcons.checkmark_square, color: AppColors.secondPrimary),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),

//           // Hiển thị tất cả sinh viên
//           const Expanded(child: CourseDsSinhVien()),
//           const SizedBox(height: AppSize.xs),

//           // Chọn tất cả và bỏ tất cả
//           // ButtonsSelectedCheckBox(courseDetailsViewModel: courseDetailsViewModel),

//           // Hủy và gửi mail
//           const ButtonsAcceptOrDeny(),
//           const SizedBox(height: AppSize.sm),
//         ],
//       ),
//     );
//   }
// }

// class ButtonsAcceptOrDeny extends StatelessWidget {
//   const ButtonsAcceptOrDeny({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppSize.xs),
//       child: Row(
//         children: [
//           Expanded(
//             child: OutlinedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "Hủy",
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black,
//                       fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
//                     ),
//               ),
//             ),
//           ),
//           const SizedBox(width: AppSize.sm),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {},
//               child: Text(
//                 "Gửi mail",
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                       fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
//                     ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DsSinhVienHadCheckBox extends StatelessWidget {
//   const DsSinhVienHadCheckBox({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CourseDetailsViewModel>(
//       builder: (context, value, child) {
//         switch (value.dsSVDiemDanh.status) {
//           case Status.LOADING:
//             return const Center(child: CircularProgressIndicator());
//           case Status.ERROR:
//             return Text(value.dsLichtrinhHocPhan.message.toString());
//           case Status.COMPLETED:
//             List<SinhVienDiemDanh> ds = value.dsSVDiemDanh.data!.dsSinhVienDiemDanh!.where((element) => element.isCheckBox == true).toList();
//             return SizedBox(
//               height: AppValues.getResponsive(40.0, 50.0, 50.0),
//               child: ListView.separated(
//                 separatorBuilder: (context, index) => const SizedBox(width: AppSize.xs),
//                 shrinkWrap: true,
//                 itemCount: ds.length,
//                 padding: const EdgeInsets.all(AppSize.zero),
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return CourseSinhvienCard(
//                     indexStudent: index,
//                     value: value,
//                     index: index,
//                     dsSinhViewOptional: ds[index],
//                     showCheckBox: false,
//                   );
//                 },
//               ),
//             );
//           case null:
//             return Container();
//         }
//       },
//     );
//   }
// }

// class CourseDsSinhVien extends StatelessWidget {
//   const CourseDsSinhVien({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CourseDetailsViewModel>(
//       builder: (context, value, child) {
//         switch (value.dsSVDiemDanh.status) {
//           case Status.LOADING:
//             return const Center(child: CircularProgressIndicator());
//           case Status.ERROR:
//             return Text(value.dsLichtrinhHocPhan.message.toString());
//           case Status.COMPLETED:
//             return value.dsFilterSinhVien.isNotEmpty
//                 ? ListView.separated(
//                     separatorBuilder: (context, index) => const SizedBox(height: AppSize.xs),
//                     shrinkWrap: true,
//                     itemCount: value.dsFilterSinhVien.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return CourseSinhvienCard(
//                         indexStudent: index,
//                         value: value,
//                         index: index,
//                         dsSinhViewOptional: value.dsFilterSinhVien[index],
//                         showCheckBox: true,
//                       );
//                     },
//                   )
//                 : Center(
//                     child: Text(
//                       'Không tra cứu được kết quả',
//                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                             fontWeight: FontWeight.w600,
//                             fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
//                           ),
//                     ),
//                   );

//           case null:
//             return Container();
//         }
//       },
//     );
//   }
// }
