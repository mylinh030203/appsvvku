import 'package:flutter/material.dart';

import '../../../components/SpaceComponent.dart';
import '../../../components/TextComponent.dart';
import '../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';


class InfoPersonal extends StatelessWidget {
  final String birthDate;
  final String birthPlace;
  final String ethnicity;
  final String gender;
  final String idNumber;
  final String issueDate;
  final String issuePlace;
  final String religion;

  InfoPersonal({
    required this.birthDate,
    required this.birthPlace,
    required this.ethnicity,
    required this.gender,
    required this.idNumber,
    required this.issueDate,
    required this.issuePlace,
    required this.religion,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: isSmall? 20: 23,),
            TextComponent(
              text: 'Thông tin cá nhân',
              type: TextType.bold,
               fontSize: isSmall
                  ? 16
                  : isMedium
                      ? 18
                      : 20
            ),
          ],
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Ngày sinh',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
          
        ),
        TextComponent(
          text: birthDate,
          type: TextType.regular,
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Nơi sinh',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        TextComponent(
          text: birthPlace,
          type: TextType.regular,
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Dân tộc',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        TextComponent(
          text: ethnicity,
          type: TextType.regular,
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Giới tính',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        TextComponent(
          text: gender,
          type: TextType.regular,
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'CCCD',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        TextComponent(
          text: idNumber,
          type: TextType.regular,
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Ngày cấp',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        TextComponent(
          text: issueDate,
          type: TextType.regular,
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Nơi cấp',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        Text(
          issuePlace,
          style: TextStyle(fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Tôn giáo',
           fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        Text(
          religion,
          style: TextStyle( fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
