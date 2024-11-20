import 'package:app_sinh_vien_vku/constants/AppSizes.dart';

import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/view/schedule/schedule_widgets/schedule_appbar.dart';
import 'package:app_sinh_vien_vku/view/schedule/schedule_widgets/schedule_calendar.dart';

import 'package:app_sinh_vien_vku/view_model/schedule/schedule.view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppHelperFunctions.isDarkmode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
      scheduleViewModel.getAppointments(context);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScheduleAppBarWidget(),
            SizedBox(height: AppSize.spaceBtwItems / 2),
            ScheduleCalendarViewWidget(),
          ],
        ),
      ),
    );
  }
}
