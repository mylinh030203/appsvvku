import 'package:app_sinh_vien_vku/components/RowComponent.dart';
import 'package:app_sinh_vien_vku/utils/imageString.dart';
import 'package:flutter/material.dart';

import '../../../components/SectionComponent.dart';
import '../../../components/SpaceComponent.dart';
import '../../../components/TextComponent.dart';
import '../../../constants/AppInfo.dart';
import '../../../utils/routes/routes_name.dart';

class InfoStudent extends StatelessWidget {
  final String idStudent, nameStudent, className, schoolYear, major;
  final Future<void> Function() pressReload; // Đổi kiểu về Future<void> Function()
  
  const InfoStudent({
    super.key,
    required this.idStudent,
    required this.className,
    required this.schoolYear,
    required this.major,
    required this.nameStudent,
    required this.pressReload,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return SectionComponent(
      padding: EdgeInsets.all(0),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(ImageString.icon_user),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: 20,
                right: 0,
                child: GestureDetector(
                  child: Container(
                    height: 50, 
                    width: 50, 
                    child: Image.asset(ImageString.user_edit),
                  ),
                  onTap: () async => await Navigator.pushNamed(context, RoutesName.editProfile),
                ),
              ),
              Positioned(
                top: 20,
                left: 0,
                child: GestureDetector(
                  child: Container(
                    height: 50, 
                    width: 50, 
                    child: Icon(Icons.refresh, size: 40,),
                  ),
                  onTap: () async => await pressReload(), // Gọi pressReload() mà không cần await
                ),
              ),
            ],
          ),
        ),
        SpaceComponent(height: 20),
        TextComponent(
          text: nameStudent,
          type: TextType.bold,
          fontSize: isSmall
              ? 20
              : isMedium
                  ? 24
                  : 26,
        ),
        SpaceComponent(height: 20),
        RowComponent(
          justify: MainAxisAlignment.spaceBetween,
          padding: EdgeInsets.only(right: 5),
          children: [
            TextComponent(
              text: 'MSV',
              type: TextType.bold,
              fontSize: isSmall
                  ? 14
                  : isMedium ? 17.5 : 19,
            ),
            SpaceComponent(width: 5),
            TextComponent(
              text: idStudent,
              type: TextType.regular,
              fontSize: isSmall
                  ? 14
                  : isMedium ? 17.5 : 19,
            ),
            SpaceComponent(width: isSmall ? 10 : 25),
            TextComponent(
              text: 'Lớp',
              type: TextType.bold,
              fontSize: isSmall
                  ? 14
                  : isMedium ? 17.5 : 19,
            ),
            SpaceComponent(width: 5),
            TextComponent(
              text: className,
              type: TextType.regular,
              fontSize: isSmall
                  ? 14
                  : isMedium ? 17.5 : 19,
            ),
            SpaceComponent(width: isSmall ?  10 : 25),
            TextComponent(
              text: 'Khóa',
              type: TextType.bold,
              fontSize: isSmall
                  ? 13
                  : isMedium ? 17.5 : 19,
            ),
            SpaceComponent(width: 5),
            TextComponent(
              text: schoolYear,
              type: TextType.regular,
              fontSize: isSmall
                  ? 14
                  : isMedium ? 17.5 : 19,
            ),
          ],
        ),
        SpaceComponent(height: 10),
        Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              children: [
                TextComponent(
                  text: 'Chuyên ngành',
                  type: TextType.bold,
                   fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 17,
                ),
                Text(
                  major,
                  style: TextStyle(fontSize: isSmall
                  ? 14
                  : isMedium
                      ? 16
                      : 17),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
