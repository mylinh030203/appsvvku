import 'package:app_sinh_vien_vku/data/local/hocphan.local.dart';
import 'package:app_sinh_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_sinh_vien_vku/data/local/tuition_paid.local.dart';
import 'package:app_sinh_vien_vku/data/local/tuition_up_coming.local.dart';
import 'package:app_sinh_vien_vku/data/network/BaseApiService.dart';
import 'package:app_sinh_vien_vku/data/network/NetworkApiService.dart';
import 'package:app_sinh_vien_vku/repository/auth/auth.repository.dart';
import 'package:app_sinh_vien_vku/repository/auth/auth.repositoryImpl.dart';
import 'package:app_sinh_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_sinh_vien_vku/repository/course_info/lichtrinhhocphan.repository.dart';

import 'package:app_sinh_vien_vku/repository/schedue/hocphan_repositoryImpl.dart';
import 'package:app_sinh_vien_vku/repository/schedue/namhoc_hocky.repository.dart';

import 'package:app_sinh_vien_vku/repository/setting/mark.repositoryImpl.dart';
import 'package:app_sinh_vien_vku/repository/tuition/tuition.repositoryImpl.dart';
import 'package:app_sinh_vien_vku/utils/ScreenInfo.dart';
import 'package:app_sinh_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_sinh_vien_vku/utils/local/localImpl/jwt_token.local_impl.dart';
import 'package:app_sinh_vien_vku/utils/local/localImpl/namhoc_hocky.local_impl.dart';
import 'package:app_sinh_vien_vku/utils/local/localImpl/thoi_khoa_bieu.local_impl.dart';
import 'package:app_sinh_vien_vku/utils/themes/themes.dart';

import 'package:app_sinh_vien_vku/view/splash.dart';
import 'package:app_sinh_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_sinh_vien_vku/view_model/certificate/certificate.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/home/services/lophocphan.service.dart';
import 'package:app_sinh_vien_vku/view_model/home/services/namhoc_hocky.service.dart';
import 'package:app_sinh_vien_vku/view_model/qr/qr.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/cousre_information/cousre_details.view_model.dart';
import 'package:app_sinh_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'data/local/mark.local.dart';
import 'data/local/user.local.dart';
import 'utils/routes/routes.dart';
import 'view_model/auth/signin.view_model.dart';
import 'view_model/auth/signup.view_model.dart';
import 'view_model/profile/profile.view_model.dart';
import 'view_model/setting/check_mark.view_model.dart';
import 'view_model/tution/tuition.view_model.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk("userBox");
  // await Hive.deleteBoxFromDisk("hocPhanBox");
  // Đăng ký adapter cho các model
  Hive.registerAdapter(UserLocalAdapter());
  Hive.registerAdapter(DiemTongKetAdapter());
  Hive.registerAdapter(DiemHocPhanAdapter());
  Hive.registerAdapter(DiemHocPhanTheoKyAdapter());
  Hive.registerAdapter(MarkLocalAdapter());
  Hive.registerAdapter(TuitionPaidLocalAdapter());
  Hive.registerAdapter(TuitionUpComingLocalAdapter());
  Hive.registerAdapter(ThoiKhoaBieuAdapter());
  Hive.registerAdapter(NamhocHockyAdapter());

  runApp(MultiProvider(
    providers: [
      // BaseApisServices
      Provider<BaseApisService>(create: (_) => NetworkApiService()),
      Provider<BaseLocal<String>>(create: (_) => JWTTokenDataLocal()),
      Provider<BaseLocal<List<NamhocHocky>>>(create: (_) => NamhocHockyLocalImpl()),
      Provider<BaseLocal<List<ThoiKhoaBieu>>>(create: (_) => ThoiKhoaBieuLocalImpl()),

      // Repo
      Provider<HocphanRepository>(
        create: (context) => HocPhanRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<NamhocHockyRepository>(
        create: (context) => NamhocHockyRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),

      // Service : Lưu trữ data dùng chung
      ChangeNotifierProvider<LopHocPhanService>(
        create: (context) => LopHocPhanService(
          jwtTokenBox: context.read<BaseLocal<String>>(),
          thoiKhoaBieuBox: context.read<BaseLocal<List<ThoiKhoaBieu>>>(),
          hocPhanRepoImpl: context.read<HocphanRepository>(),
        ),
      ),
      ChangeNotifierProvider<NamHocHocKyService>(
        create: (context) => NamHocHocKyService(
          namhochockyRepoImpl: context.read<NamhocHockyRepository>(),
          namhocHockybox: context.read<BaseLocal<List<NamhocHocky>>>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
        ),
      ),
      Provider<LichtrinhHocPhanRepository>(
        create: (context) => LichtrinhHocPhanRepoImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      ChangeNotifierProvider<BotttomNavigatorService>(
        create: (context) => BotttomNavigatorService(),
      ),

      // ViewModel
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHocKyService: context.read<NamHocHocKyService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => ScheduleViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHocKyService: context.read<NamHocHocKyService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CourseDetailsViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          lichtrinhHocPhanRepoImpl: context.read<LichtrinhHocPhanRepository>(),
        ),
      ),

      ChangeNotifierProvider(
        create: (context) => SigninViewModel(
          jwtTokenBox: context.read<BaseLocal<String>>(),
          authRepositoryImpl: context.read<AuthRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SignupViewModel(
          authRepositoryImpl: context.read<AuthRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SettingViewModel(
          jwtTokenBox: context.read<BaseLocal<String>>(),
        ),
      ),
      ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ChangeNotifierProvider(create: (context) => CheckMarkViewModel(MarkRepositoryImpl())),
      ChangeNotifierProvider(create: (context) => TuitionViewModel(TuitionRepositoryImpl())),

      ChangeNotifierProvider(create: (context) => CertificateViewModel()),
      ChangeNotifierProvider(create: (context) => QrViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Add other supported locales if needed
        Locale('vi', ''), // Vietnamese locale
      ],
      builder: (context, child) {
        ScreenInfo().initialize(context); // Initialize once for the entire app
        return child!;
      },
      locale: const Locale('vi', ''), //
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
