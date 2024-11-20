import 'package:app_sinh_vien_vku/components/IconComponent.dart';
import 'package:app_sinh_vien_vku/components/TextComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/AppInfo.dart';
import 'tution_paid/tuitionUpComing.dart';
import 'tution_paid/tutionPaid.dart';

class TuitionScreen extends StatelessWidget {
  const TuitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
        bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0,),
              child: Iconcomponent(
                background: AppColors.gray2,
                    size: isSmall? 28 : isMedium ? 32 : 36,
                icon: Icon(CupertinoIcons.back),
                isCircles: true,
                onPress: () =>   AppHelperFunctions.navigateback(context),      
              ),
            ),
            backgroundColor: AppColors.primary,
            shadowColor: AppColors.secondPrimary,
            bottom: const TabBar(
              dividerColor: AppColors.secondPrimary,
              indicatorColor: AppColors.secondPrimary,
              labelColor: AppColors.secondPrimary,
              tabs: [
                Tab(text: "Đã nộp", ),
                Tab(text: "Sắp tới",),
             

              ],
            ),
            centerTitle: false,
            title: Container(padding: EdgeInsets.only(left: isSmall? 5 : 10), child: TextComponent(text: 'Xem học phí', type: TextType.bold, fontSize: isSmall? 22 : 25,)),
          ),
          body: TabBarView(
            children: [
              TutionPaidTab(),
             TutionUpComingTab(),
            
            ],
          ),
        ));
  }
}