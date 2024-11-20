import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../components/TextComponent.dart';
// ignore: unused_import
import '../../../../constants/AppColor.dart';
import '../../../../data/response/status.dart';
import '../../../../view_model/tution/tuition.view_model.dart';
import '../../components/TableDataCustom.dart';
import '../../components/TableTitle.dart';

class TutionUpComingTab extends StatelessWidget {
  const TutionUpComingTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data on widget build
    final tuitionViewModel = Provider.of<TuitionViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (tuitionViewModel.dataHocPhiSapToi == [] || tuitionViewModel.dataHocPhiSapToi!.isEmpty) {
        tuitionViewModel.fetchTuitionUpcoming(context);
      } else {
        print("ko call");
      }
    });

    final List<String> listTitleRowSapToi = ["#", "Tên học phần", "Số tín chỉ", "Số tiền"];

    return Scaffold(
      body: Consumer<TuitionViewModel>(
        builder: (context, tuitionViewModel, child) {
          if (tuitionViewModel.statusComing == Status.LOADING) {
            return Center(child: CircularProgressIndicator());
          } else if (tuitionViewModel.statusComing == Status.ERROR) {
            return Center(child: TextComponent(text: "Có lỗi xảy ra khi tải dữ liệu"));
          } else if (tuitionViewModel.statusComing == Status.COMPLETED && tuitionViewModel.dataHocPhiSapToi != null) {
            return CustomScrollView(
              slivers: [
                TableTitle(title: "Danh sách học phí sắp tới"),
                TableDataCustom(
                  listTitleRow: listTitleRowSapToi,
                  data: tuitionViewModel.dataHocPhiSapToi!,
                  extraData: tuitionViewModel.subDataUTC.entries.map((entry) {
                    return {entry.key: tuitionViewModel.formatCurrency(entry.value)};
                  }).toList(),
                ),
              ],
            );
          } else {
            return Center(child: TextComponent(text: "Không có dữ liệu để hiển thị"));
          }
        },
      ),
    );
  }
}
