import 'package:digital_secure_task/core/config/themes.dart';
import 'package:digital_secure_task/data/remote/api_endpoint.dart';
import 'package:digital_secure_task/di/injection_container.dart';
import 'package:digital_secure_task/features/login/view/pages/login_view.dart';
import 'package:digital_secure_task/features/login/view_model/login_view_model.dart';
import 'package:digital_secure_task/features/main/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencyInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(251, 176, 59, 1)));
  Future.wait([
    Parse().initialize(ApiEndPoints.appId, ApiEndPoints.baseUrl, debug: true),
    ScreenUtil.ensureScreenSize(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginViewModel()),
            BlocProvider(create: (context) => MainViewModel()),
          ],
          child: MaterialApp(
            theme: Themes.lightTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            title: 'Digital Secure',
            home: const LoginView(),
          ),
        );
      },
      designSize: const Size(428, 926),
    );
  }
}
