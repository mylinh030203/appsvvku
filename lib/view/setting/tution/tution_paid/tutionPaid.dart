import 'package:app_sinh_vien_vku/components/TextComponent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../view_model/tution/tuition.view_model.dart';
import '../../components/TableDataCustom.dart';
import '../../components/TableTitle.dart';

class TutionPaidTab extends StatelessWidget {
  const TutionPaidTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch data on widget build
    final tuitionViewModel = Provider.of<TuitionViewModel>(context, listen: false);
    Future.microtask(() => {
          if (tuitionViewModel.dataHocPhiDaNop == null || tuitionViewModel.dataHocPhiDaNop!.isEmpty) {tuitionViewModel.fetchTuitionPaid(context)} else {print("ko call da nop")}
        });

    final List<String> listTitleRowDaNop = ["#", "Năm học - học kì", "Số tiền", "Biên lai", "Người thu", "Ngày thu"];

    return Scaffold(
      body: Consumer<TuitionViewModel>(
        builder: (context, tuitionViewModel, child) {
          if (tuitionViewModel.statusPaid == Status.LOADING) {
            return Center(child: CircularProgressIndicator());
          } else if (tuitionViewModel.statusPaid == Status.ERROR) {
            return Center(child: TextComponent(text: "Có lỗi xảy ra khi tải dữ liệu"));
          } else if (tuitionViewModel.statusPaid == Status.COMPLETED && tuitionViewModel.dataHocPhiDaNop != null) {
            final data = tuitionViewModel.dataHocPhiDaNop;

            return CustomScrollView(
              slivers: [
                TableTitle(title: "Danh sách học phí đã nộp"),
                TableDataCustom(
                  listTitleRow: listTitleRowDaNop,
                  data: data!,
                  extraData: [
                    {"Tổng:": tuitionViewModel.formatCurrency(tuitionViewModel.tongTien)}
                  ],
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
