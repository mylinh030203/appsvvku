import 'package:flutter/material.dart';
import '../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';

class DataDiemHPTheoKyTable extends StatelessWidget {
  final List<Map<String, Object>> data;

  const DataDiemHPTheoKyTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề bảng chỉ xuất hiện một lần
            Container(
              color: AppColors.titleAuth,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.white),
                  columns: [
                    DataColumn(label: Text('#')),
                    DataColumn(label: Text('Tên lớp học phần')),
                    DataColumn(label: Text('Số TC')),
                    DataColumn(label: Text('Lần học')),
                    DataColumn(label: Text('Điểm CC/GVHD')),
                    DataColumn(label: Text('Điểm bài tập')),
                    DataColumn(label: Text('Điểm giữa kỳ')),
                    DataColumn(label: Text('Điểm cuối kỳ')),
                    DataColumn(label: Text('Điểm T10')),
                    DataColumn(label: Text('Điểm chữ')),
                  ],
                  rows: [], // Tiêu đề bảng chỉ xuất hiện một lần, không có dữ liệu ở đây
                ),
              ),
            ),
            // Dữ liệu bảng cho từng học kỳ, không có tiêu đề cột
            ...data.map((semesterData) {
              String hocKy = semesterData['Học kỳ'] as String;
              var listDiemHocPhan = semesterData['list_diem_hoc_phan']
                  as List<Map<String, Object>>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: isSmall? 40 : 55,
                    color: AppColors.secondPrimary,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        hocKy,
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
                      ),
                    ),
                  ),
                  // DataTable cho từng học kỳ với dữ liệu, không có tiêu đề cột ở đây
                  Container(                  
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowHeight: 0,
                        headingTextStyle:
                            TextStyle(fontSize: isSmall ? 14 : 18),
                        dataRowColor:
                            WidgetStateProperty.all(AppColors.primary),
                        columns: [
                          DataColumn(label: Text('#')),
                          DataColumn(label: Text('Tên lớp học phần')),
                          DataColumn(label: Text('Số TC')),
                          DataColumn(label: Text('Lần học')),
                          DataColumn(label: Text('Điểm CC/GVHD')),
                          DataColumn(label: Text('Điểm bài tập')),
                          DataColumn(label: Text('Điểm giữa kỳ')),
                          DataColumn(label: Text('Điểm cuối kỳ')),
                          DataColumn(label: Text('Điểm T10')),
                          DataColumn(label: Text('Điểm chữ')),
                        ],
                        rows: listDiemHocPhan.asMap().entries.map((entry) {
                          int index = entry.key;
                          var item = entry.value;

                          return DataRow(
                            cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(
                                  Text(item['Tên lớp học phần'].toString())),
                              DataCell(Text(item['Số TC'].toString())),
                              DataCell(Text(item['Lần học'].toString())),
                              DataCell(Text(item['Điểm CC/GVHD'].toString())),
                              DataCell(Text(
                                  item['Điểm bài tập']?.toString() ?? 'N/A')),
                              DataCell(Text(item['Điểm giữa kỳ'].toString())),
                              DataCell(Text(item['Điểm cuối kỳ'].toString())),
                              DataCell(Text(item['Điểm T10'].toString())),
                              DataCell(Text(item['Điểm chữ'].toString())),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
