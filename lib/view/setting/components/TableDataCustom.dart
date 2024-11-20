import 'package:flutter/material.dart';
import '../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/components/TextComponent.dart';

class TableDataCustom extends StatelessWidget {
  const TableDataCustom({
    super.key,
    required this.listTitleRow,
    required this.data,
    this.extraData,
  });

  final List<String> listTitleRow;
  final List<Map<String, Object>> data;
  final List<Map<String, Object>>? extraData;

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.titleAuth,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: DataTable(
                headingTextStyle: TextStyle(fontSize: isSmall ? 14 : 18),
                dataRowColor: WidgetStateProperty.all(AppColors.white),
                columns: listTitleRow.map((item) => DataColumn(
                  label: Text(item, style: TextStyle(color:  Colors.white)),
                )).toList(),
                rows: data.map((item) {
                  return DataRow(
                    cells: item.entries.map((e) => DataCell(Text(e.value.toString(),))).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
          if (extraData != null) ...[
            SizedBox(height: 10),
            Column(
              children: extraData!.map((row) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: AppColors.gray2), // Border color and width
                    ),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    horizontalTitleGap: 20,
                    title: TextComponent(text: row.values.first.toString()),
                    leading: TextComponent(text: row.keys.first.toString(), type: TextType.semibold,),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
