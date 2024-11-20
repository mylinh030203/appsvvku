import 'package:app_sinh_vien_vku/components/IconComponent.dart';
import 'package:app_sinh_vien_vku/components/RowComponent.dart';
import 'package:app_sinh_vien_vku/components/SpaceComponent.dart';
import 'package:app_sinh_vien_vku/components/TextComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';
import '../../../data/response/status.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../view_model/setting/check_mark.view_model.dart';
import '../components/TableDataCustom.dart';
import '../components/TableDataDiemHp.dart';
import '../components/TableTitle.dart';
import 'package:provider/provider.dart';

class CheckMarkScreen extends StatefulWidget {
  const CheckMarkScreen({super.key});

  @override
  _CheckMarkScreenState createState() => _CheckMarkScreenState();
}

class _CheckMarkScreenState extends State<CheckMarkScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<CheckMarkViewModel>(context, listen: false);
      await viewModel.fetchMark(context);
    });
    return Scaffold(
      body: Consumer<CheckMarkViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.status) {
            case Status.COMPLETED:
              return Scaffold(
                backgroundColor: AppColors.primary,
                body: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: AppInfo.isMobileSmall(context) ? 10 : 20,
                          ),
                          child: RowComponent(
                            justify: MainAxisAlignment.start,
                            children: [
                              Iconcomponent(
                                size: 40,
                                icon: Icon(CupertinoIcons.back, size: 30),
                                onPress: () => AppHelperFunctions.navigateback(context),
                              ),
                              SpaceComponent(width: 20),
                              TextComponent(
                                text: "Xem điểm sinh viên",
                                type: TextType.bold,
                                fontSize: AppInfo.isMobileSmall(context) ? 20 : 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TableTitle(title: "Điểm tổng kết"),
                      TableDataCustom(
                        listTitleRow: ["#", "Học kỳ", "Số TC-ĐK mới", "Điểm 4", "Điểm 10", "Điểm HB", "TC TL HK", "Xếp loại", "Điểm 4 TL", "Điểm 10 TL", "TC Tích luỹ"],
                        data: viewModel.dataDiemTongKet ?? [],
                      ),
                      SliverToBoxAdapter(
                        child: SpaceComponent(height: 20),
                      ),
                      SliverToBoxAdapter(
                        child: RowComponent(
                          justify: MainAxisAlignment.spaceBetween,
                          children: [
                            TableTitle(
                              title: "Điểm các lớp học phần",
                              isSliverToBoxAdapter: false,
                            ),
                            SpaceComponent(width: AppInfo.isMobileSmall(context) ? 2 : 5),
                            DropDownSemester(
                              initialValue: viewModel.selectedSemester,
                              onChanged: (value) {
                                viewModel.setSelectedSemester(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SpaceComponent(height: 10)),
                      if (viewModel.dataDiemHPTheoKy!.isNotEmpty) DataDiemHPTheoKyTable(data: viewModel.selectedSemester == 1 ? viewModel.dataDiemHPTheoKy ?? [] : [viewModel.dataDiemHPTheoKy!.first])
                    ],
                  ),
                ),
              );
            case Status.LOADING:
              return Scaffold(
                backgroundColor: AppColors.primary,
                body: Center(child: CircularProgressIndicator()),
              );
            case Status.ERROR:
              return Scaffold(
                backgroundColor: AppColors.primary,
                body: Center(child: Text("Lỗi khi tải dữ liệu.")),
              );
          }
          // if (viewModel.status == Status.LOADING) {
          //   return Scaffold(
          //     backgroundColor: AppColors.primary,
          //     body: Center(child: CircularProgressIndicator()),
          //   );
          // }

          // if (viewModel.status == Status.ERROR) {
          //   return Scaffold(
          //     backgroundColor: AppColors.primary,
          //     body: Center(child: Text("Lỗi khi tải dữ liệu.")),
          //   );
          // }

          // if (viewModel.status == Status.COMPLETED) {
          // }

          // return Container();
        },
      ),
    );
  }
}

class DropDownSemester extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int?> onChanged;

  const DropDownSemester({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _DropDownSemesterState createState() => _DropDownSemesterState();
}

class _DropDownSemesterState extends State<DropDownSemester> {
  int? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    return Expanded(
      flex: 1,
      child: DropdownButtonFormField<int>(
        value: _selectedValue,
        decoration: InputDecoration(
          focusColor: AppColors.white,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        dropdownColor: AppColors.white,
        hint: Text('Chọn học kỳ'),
        items: [
          DropdownMenuItem(
            value: 0,
            child: TextComponent(
              text: 'Học kỳ hiện tại',
              fontSize: isSmall ? 10 : 12,
            ),
          ),
          DropdownMenuItem(
            value: 1,
            child: TextComponent(
              text: 'Tất cả hoc kỳ',
              fontSize: isSmall ? 10 : 12,
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
