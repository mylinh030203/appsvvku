import 'package:app_sinh_vien_vku/view/auth/register.dart';
import 'package:app_sinh_vien_vku/view/auth/signin.dart';
import 'package:app_sinh_vien_vku/view/course_details/course_details_screen.dart';
import 'package:app_sinh_vien_vku/view/course_list/list_course_screen.dart';

import 'package:app_sinh_vien_vku/view/profile/editProfile.dart';
import 'package:app_sinh_vien_vku/view/profile/profile.dart';
import 'package:app_sinh_vien_vku/view/schedule/schedule_screen.dart';
import 'package:app_sinh_vien_vku/view/setting/check_mark/check_mark.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/components/graduation_certificate_details_screen.dart';

import 'package:app_sinh_vien_vku/view/setting/proof/components/upload_proof_certificate_screen.dart';
import 'package:app_sinh_vien_vku/view/setting/proof/graduation_certificate_screen.dart';
import 'package:app_sinh_vien_vku/view/setting/tution/tution.dart';
import 'package:flutter/material.dart';
import '../../view/auth/verify.dart';
import '../../view/home/home_screen.dart';
import '../../view/navigator_menu.dart';
import '../../view/splash.dart';
import 'routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => SignInScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => SignUpScreen());
      case RoutesName.verify:
        return MaterialPageRoute(builder: (BuildContext context) => VerifyScreen());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());
      case RoutesName.menuBar:
        return MaterialPageRoute(builder: (BuildContext context) => NavigationMenu());
      case RoutesName.schedule:
        return MaterialPageRoute(builder: (BuildContext context) => ScheduleScreen());
      case RoutesName.profile:
        return MaterialPageRoute(builder: (BuildContext context) => ProfileScreen());
      case RoutesName.editProfile:
        return MaterialPageRoute(builder: (BuildContext context) => EditProfileScreen());
      case RoutesName.checkmark:
        return MaterialPageRoute(builder: (BuildContext context) => CheckMarkScreen());
      case RoutesName.tuition:
        return MaterialPageRoute(builder: (BuildContext context) => TuitionScreen());
      case RoutesName.proof:
        return MaterialPageRoute(builder: (BuildContext context) => ProofScreen());
      case RoutesName.coruse_details:
        return MaterialPageRoute(builder: (BuildContext context) => CourseDetailsScreen());
      case RoutesName.graduation_certificate:
        return MaterialPageRoute(builder: (BuildContext context) => GraduationCertificateScreen());
      case RoutesName.certificate_details:
        return MaterialPageRoute(builder: (BuildContext context) => CertificateDetailsScreen());
      case RoutesName.course_list:
        return MaterialPageRoute(builder: (BuildContext context) => ListCourseScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("Not found"),
            ),
          );
        });
    }
  }
}
