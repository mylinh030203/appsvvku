import 'package:app_sinh_vien_vku/components/ContainerComponent.dart';
import 'package:app_sinh_vien_vku/view/profile/components/AvatarComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/ButtonComponent.dart';
import '../../components/InputComponent.dart';
import '../../components/SpaceComponent.dart';
import '../../constants/AppColor.dart';
import '../../constants/AppInfo.dart';
import '../../view_model/profile/profile.view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idenCardDateController = TextEditingController();
  final idenPlaceController = TextEditingController();
  final religionController = TextEditingController();
  final healthInsuranceNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileViewModel = context.read<ProfileViewModel>();
    final user = profileViewModel.userLocal;
    if (user != null) {
      emailController.text = user.email ?? '';
      phoneController.text = user.dienThoai ?? '';
      idenCardDateController.text = user.ngayCapCccd ?? '';
      idenPlaceController.text = user.noiCapCccd ?? '';
      religionController.text = user.tonGiao ?? '';
      healthInsuranceNumController.text = user.maSoBHYT ?? '';
    }
  }

  String img = "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg";
  @override
  Widget build(BuildContext context) {
    bool isMobileLarge = AppInfo.isMobileLarge(context);
    bool isSmall = AppInfo.isMobileSmall(context);

    return ContainerComponent(
      padding: EdgeInsets.all(20),
      isBack: true,
      isScroll: true,
      title: "Điền thông tin sinh viên",
      children: [
        AvatarComponent(
          imageUrl: img,
          size: isSmall ? 50 : 70,
        ),
        SpaceComponent(
          height: isMobileLarge ? 28 : 25,
        ),
        InputComponent(
          type: TextInputType.phone,
          placeholder: "Số điện thoại ",
          controller: phoneController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(
            CupertinoIcons.phone,
            color: Colors.black,
          ),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        InputComponent(
          placeholder: "Ngày cấp CCCD",
          controller: idenCardDateController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(Icons.date_range_sharp, color: Colors.black),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        InputComponent(
          placeholder: "Nơi cấp CCCD",
          controller: idenPlaceController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(Icons.place_rounded, color: Colors.black),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        InputComponent(
          placeholder: "Tôn giáo",
          controller: religionController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(CupertinoIcons.person_fill, color: Colors.black),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        InputComponent(
          placeholder: "Mã số bảo hiểm y tế",
          controller: healthInsuranceNumController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(CupertinoIcons.creditcard_fill, color: Colors.black),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        InputComponent(
          placeholder: "Email cá nhân",
          controller: emailController,
          colorBackground: AppColors.thirdPrimary,
          affix: const Icon(
            CupertinoIcons.mail_solid,
            color: Colors.black,
          ),
        ),
        SizedBox(height: isMobileLarge ? 28 : 25),
        Buttoncomponent(
          text: "Cập nhật",
          onPress: () {
            final profileViewModel = context.read<ProfileViewModel>();
            profileViewModel.updateProfile(
                context, emailController.text, phoneController.text, idenCardDateController.text, idenPlaceController.text, religionController.text, healthInsuranceNumController.text);
          },
          type: "primary",
          height: isMobileLarge ? 55 : 52,
          width: AppInfo.getScreenWidth(context),
        ),
      ],
    );
  }
}
