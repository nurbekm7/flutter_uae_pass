import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<DashboardBinding>(
      () => DashboardBinding(),
    );
  }
}
