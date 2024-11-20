import 'package:app_sinh_vien_vku/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_sinh_vien_vku/components/ContainerComponent.dart';
import 'package:app_sinh_vien_vku/components/SpaceComponent.dart';
import 'package:app_sinh_vien_vku/constants/AppInfo.dart';
import '../../view_model/profile/profile.view_model.dart';
import 'components/infoContact.dart';
import 'components/infoPersonal.dart';
import 'components/infoStudent.dart';
import 'package:flutter/scheduler.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch data using addPostFrameCallback to avoid calling during build
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (profileViewModel.userLocal == null) {
        profileViewModel.fetchUserProfile(context);
      }
    });

    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          switch (profileViewModel.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text('Error loading profile data.'));
            case Status.COMPLETED:
              if (profileViewModel.userLocal != null) {
                bool isSmall = AppInfo.isMobileSmall(context);

                return ContainerComponent(
                  padding: EdgeInsets.symmetric(horizontal: isSmall ? 10 : 20),
                  isScroll: true,
                  children: [
                    InfoStudent(
                      pressReload: () async {
                        await profileViewModel.refreshProfile(context);
                      },
                      idStudent: profileViewModel.userLocal!.id.toString(),
                      className: profileViewModel.userLocal!.lopSinhHoat ?? "",
                      schoolYear: profileViewModel.userLocal!.nien_khoa,
                      major: profileViewModel.userLocal!.chuyenNganh.toString(),
                      nameStudent: profileViewModel.userLocal!.hoTen,
                    ),
                    SpaceComponent(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoPersonal(
                              birthDate: profileViewModel.userLocal!.ngaySinh ?? "",
                              birthPlace: profileViewModel.userLocal!.noiSinh ?? "",
                              ethnicity: profileViewModel.userLocal!.danToc ?? "",
                              gender: profileViewModel.userLocal!.gioiTinh ?? "Không xác định",
                              idNumber: profileViewModel.userLocal!.numberCIC,
                              issueDate: profileViewModel.userLocal!.ngayCapCccd ?? "",
                              issuePlace: profileViewModel.userLocal!.noiCapCccd ?? "",
                              religion: profileViewModel.userLocal!.tonGiao ?? "",
                            ),
                            InfoContact(
                              email: profileViewModel.userLocal!.email ?? "",
                              phone: profileViewModel.userLocal!.dienThoai ?? "",
                              familyPhone: profileViewModel.userLocal!.dienThoaiGD ?? "",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No profile data available.'));
              }
          }
        },
      ),
    );
  }
}
