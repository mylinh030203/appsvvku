import 'package:flutter/material.dart';

import '../../../components/SpaceComponent.dart';
import '../../../components/TextComponent.dart';
import '../../../constants/AppColor.dart';
import '../../../constants/AppInfo.dart';

class InfoContact extends StatelessWidget {
  final String email;
  final String phone;
  final String familyPhone;

  InfoContact({required this.email, required this.phone, required this.familyPhone});

  @override
  Widget build(BuildContext context) {
        bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceComponent(
          height: 20,
        ),
        Row(
          children: [
            Icon(Icons.phone,size: isSmall? 20: 23),
            TextComponent(
              text: 'Thông tin liên hệ',
              type: TextType.bold,
                fontSize: isSmall
                  ? 18
                  : isMedium
                      ? 20
                      : 22
            ),
          ],
        ),
        SpaceComponent(
          height: 20,
        ),
        TextComponent(
          text: 'Email khác ',
            fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        Text(
          email,
          style: TextStyle(  fontSize: isSmall
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
          text: 'Điện thoại',
            fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        Text(
          phone,
          style: TextStyle(  fontSize: isSmall
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
          text: 'Điện thoại gia đình',
            fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 18,
          type: TextType.regular,
          color: AppColors.gray4,
        ),
        Text(
          familyPhone,
          style: TextStyle(  fontSize: isSmall
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
