import 'package:app_sinh_vien_vku/constants/AppColor.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import 'package:app_sinh_vien_vku/constants/AppSizes.dart';
import 'package:app_sinh_vien_vku/constants/AppValue.dart';
import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:app_sinh_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_sinh_vien_vku/utils/routes/routes_name.dart';

import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleCalendarViewWidget extends StatelessWidget {
  const ScheduleCalendarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    var monthDisplay = Padding(
      padding: EdgeInsets.symmetric(horizontal: AppInfo.isMobileSmall(context) ? 5 : AppSize.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer<ScheduleViewModel>(
              builder: (context, scheduleViewModel, child) {
                return Text(
                  "Tuần ${scheduleViewModel.week}, Tháng ${scheduleViewModel.month} Năm ${scheduleViewModel.year}",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondPrimary,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      ),
                );
              },
            ),
          ),
          IconButton(
              onPressed: () => scheduleViewModel.calendarSelectDisplayTime(context),
              icon: Icon(
                CupertinoIcons.calendar,
                color: AppColors.secondPrimary,
                size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
              ))
        ],
      ),
    );
    var weeklyCalendar = Consumer<ScheduleViewModel>(builder: (context, value, child) {
      switch (value.statusCalendar) {
        case Status.LOADING:
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        case Status.ERROR:
          return Text('Error: ');
        case Status.COMPLETED:
          var view = scheduleViewModel.isDaily ? CalendarView.day : CalendarView.week;
          var numberOfDaysInView = scheduleViewModel.isDaily ? 1 : AppValues.getResponsive(3.0, 7.0, 7.0).toInt();

          return Container(
            height: AppInfo.getScreenHeight(context) - (AppSize.spaceBtwSections * (AppInfo.isMobileSmall(context) ? 5.1 : 6.5)),
            child: SfCalendar(
              view: view,
              controller: scheduleViewModel.calendarController,
              headerHeight: 0,
              firstDayOfWeek: DateTime.monday,
              scheduleViewSettings: const ScheduleViewSettings(weekHeaderSettings: WeekHeaderSettings(height: 4000)),
              monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator, showAgenda: true),
              allowedViews: const <CalendarView>[CalendarView.day, CalendarView.week, CalendarView.month],
              appointmentTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeXs, AppSize.fontSizeXs),
              ),
              timeSlotViewSettings: TimeSlotViewSettings(
                numberOfDaysInView: numberOfDaysInView,
                startHour: 6,
                endHour: 18,
                timeFormat: 'HH:mm',
                timeIntervalHeight: AppValues.getResponsive(45.0, 50.0, 55.0),
              ),
              onTap: (calendarTapDetails) => showPopUpDetailsCalendars(calendarTapDetails, context, value),
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.secondPrimary, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
              onViewChanged: (viewChangedDetails) {
                // value.getNamhocHocKyHientai(value.nienKhoa);
                var strDayStemstart = value.namHocHocKyService.namhocHockyHienTai!.ngayBatDau;
                Provider.of<ScheduleViewModel>(context, listen: false).onViewChanged(viewChangedDetails, strDayStemstart);
              },
              appointmentBuilder: (context, calendarAppointmentDetails) {
                final Appointment appointment = calendarAppointmentDetails.appointments.first;

                return DetailsAppointmentsCalendarWidget(appointment: appointment);
              },
              dataSource: MeetingDataSource(value.dsApointment),
            ),
          );
      }
    });

    return Column(
      children: [
        monthDisplay,
        weeklyCalendar,
      ],
    );
  }

  showPopUpDetailsCalendars(calendarTapDetails, BuildContext context, ScheduleViewModel scheduleViewModel) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments?.first;

      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Thông tin buổi học',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl), fontWeight: FontWeight.w800),
              ),
              content: SizedBox(
                width: AppInfo.getScreenWidth(context) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppSize.sm),
                    Text(
                      'Môn học: ${appointment.subject} \n'
                      'Thời gian: ${DateFormat('HH:mm').format(appointment.startTime)} - ${DateFormat('HH:mm').format(appointment.endTime)} \n'
                      'Phòng: ${appointment.location}\n',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                          ),
                    ),
                    const SizedBox(height: AppSize.spaceBtwItems),
                    ElevatedButton(
                      onPressed: () {
                        final dsTKB = scheduleViewModel.hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;
                        scheduleViewModel.hocphanService.setThoiKhoaBieu(dsTKB.firstWhere((e) => e.idHocPhan == appointment.id));
                        Navigator.of(context).pop();
                        AppHelperFunctions.navigateToScreenName(context, RoutesName.coruse_details);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Chi tiết Thời khóa biểu',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: AppColors.white,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.sm),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Thoát',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: AppColors.black,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}

class DetailsAppointmentsCalendarWidget extends StatelessWidget {
  const DetailsAppointmentsCalendarWidget({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxHeight: double.infinity,
      child: Container(
        decoration: BoxDecoration(color: appointment.color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (appointment.recurrenceRule == null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: Text('Bù', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: 10.0, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              // SizedBox(height: AppSize.xs),
              Container(
                color: appointment.color,
                child: Text(
                  "${appointment.subject}",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: 9.0, fontWeight: FontWeight.w800),
                ),
              ),

              SizedBox(height: AppSize.xs),
              Container(
                color: appointment.color,
                child: Text(
                  "${appointment.location}",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
