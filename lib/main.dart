import 'package:flutter_uae_pass/app/data/languages.dart';
import 'package:flutter_uae_pass/app/data/services/connectivity_controller.dart';
import 'package:flutter_uae_pass/app/data/services/settings_service.dart';
import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter_uae_pass/app/modules/splash/bindings/splash_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.darkBlue,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(412, 732),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            //device prev
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            //rest
            defaultTransition: Transition.rightToLeft,
            translations: Languages(),
            locale: Get.find<SettingsService>().locale,
            fallbackLocale: const Locale('en', 'US'),//todo
            title: "flutter_uae_pass",
            initialRoute: AppPages.INITIAL,
            
            debugShowCheckedModeBanner: false,
            initialBinding: SplashBinding(),
            theme: ThemeData(fontFamily: 'Poppins'),
            getPages: AppPages.routes,
          );
        },
      ),
    ),
  );
}

Future<void> initServices() async {
  //track during development
  await GetStorage.init();
  await Get.putAsync<SettingsService>(() async => SettingsService());
  final controller = Get.put<ConnectivityController>(ConnectivityController());
  controller.initCheckConnectivity();
}
