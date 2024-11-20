

import 'package:flutter/material.dart';

import '../../../components/SectionComponent.dart';
import '../../../components/TextComponent.dart';
import '../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';

class TableTitle extends StatelessWidget {
  final String title;
  final bool? isSliverToBoxAdapter;
  const TableTitle({
    super.key, required this.title, this.isSliverToBoxAdapter,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    return isSliverToBoxAdapter!=false ? SliverToBoxAdapter(
      child: SectionComponent(
        child: TextComponent(
          text: title,
          type: TextType.bold,
          fontSize: isSmall? 12 : 14,
          color: AppColors.secondPrimary,
        ),
      ),
    ) : SectionComponent(
        child: TextComponent(
          text: title,
          type: TextType.bold,
          fontSize: isSmall? 12 : 14,
          color: AppColors.secondPrimary,
        ),
      );
  }
}
