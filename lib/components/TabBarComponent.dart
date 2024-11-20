import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabControlWidget extends StatefulWidget {
  const TabControlWidget({
    super.key,
    required this.listTabName,
    required this.children,
    required this.height,
    this.tabTextStyle,
    this.tabColor,
  });
  final double height;
  final Color? tabColor;
  final TextStyle? tabTextStyle;
  final List<String> listTabName;
  final List<Widget> children;

  @override
  State<TabControlWidget> createState() => _TabControlWidgetState();
}

class _TabControlWidgetState extends State<TabControlWidget> {
  int selectedTabItem = 0;

  changeSeletadTabIndex(int tabIndex) {
    setState(() {
      selectedTabItem = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var length = widget.listTabName.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: AppColors.gray2.withOpacity(0.3),
            child: Stack(
              children: [
                AnimatedPositioned(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 300),
                  left: (MediaQuery.of(context).size.width / length) * selectedTabItem - AppSize.lg * (selectedTabItem + 1) / length,
                  right: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / length) * (selectedTabItem + 1) - AppSize.lg * (length - selectedTabItem) / length,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: widget.tabColor ?? AppColors.secondPrimary),
                    height: widget.height,
                  ),
                ),
                Row(
                  children: List.generate(
                    widget.listTabName.length,
                    (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => changeSeletadTabIndex(index),
                          child: Container(
                            height: widget.height,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                widget.listTabName[index],
                                style: widget.tabTextStyle!.copyWith(color: selectedTabItem == index ? AppColors.white : AppColors.black, fontSize: AppValues.getResponsive(11.0, 14.0, 16.0)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSize.spaceBtwItems),
        widget.children[selectedTabItem]
      ],
    );
  }
}
