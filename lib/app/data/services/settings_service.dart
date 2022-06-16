import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_uae_pass/app/modules/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxService {
  late GetStorage _getStorage = GetStorage();
  late bool firstRun = true;
  late bool loggedIn = false;
  late String userToken = '';
  late String userId = '';
  late String localeLangCode = '';
  late Locale locale = Locale('en', 'US');
  //new
  late String userName = '';
  late String phoneNumber = '';
  late String userEid = '';

  // late String reportFilePath = '';
  late String arabicReportPath = '';
  late String englishReportPath = '';
  @override
  void onInit() {
    initSharedPrefs();
    super.onInit();
  }

  void logout() async {
    await _getStorage.erase();
    Get.offAll(SplashView(), binding: SplashBinding());
  }

  void onBoarding() async {
    await _getStorage.write('first_run', false);
    firstRun = false;
  }

  void initSharedPrefs() async {
    print("logged_in: " + _getStorage.read('logged_in').toString());
    _getStorage = GetStorage();
    firstRun = _getStorage.read('first_run') ?? true;
    loggedIn = _getStorage.read('logged_in') ?? false;
    userId = _getStorage.read('userId') ?? '';
    userToken = _getStorage.read('userToken') ?? '';
    userName = _getStorage.read('userName') ?? '';
    phoneNumber = _getStorage.read('phoneNumber') ?? '';
    userEid = _getStorage.read('userEid') ?? '';
    arabicReportPath = _getStorage.read('arabicReportPath') ?? '';
    englishReportPath = _getStorage.read('englishReportPath') ?? '';
    localeLangCode = _getStorage.read('locale') ?? 'en';
    locale = constructLocale(langCode: localeLangCode);
  }

  Locale constructLocale({required String langCode}) {
    switch (langCode) {
      case 'ar':
        return Locale('ar', 'AE');
      case 'en':
        return Locale('en', 'US');
      default:
        return Locale('en', 'US');
    }
  }

  Future<void> saveUserToken({required String newToken}) async {
    await _getStorage.write('userToken', newToken);
    userToken = _getStorage.read('userToken') ?? '';
  }

  Future<void> saveUserLocale({required String newLocale}) async {
    await _getStorage.write('locale', newLocale);
    localeLangCode = _getStorage.read('locale') ?? 'en';
    locale = constructLocale(langCode: localeLangCode);
  }

  Future<void> saveUserEid({required String newEid}) async {
    await _getStorage.write('userEid', newEid);
    userEid = _getStorage.read('userEid') ?? '';
  }

  Future<void> saveUserId({required String newId}) async {
    await _getStorage.write('userId', newId);
    userId = _getStorage.read('userId') ?? '';
  }

  Future<void> hasLoggedIn() async {
    await _getStorage.write('logged_in', true);
  }

  Future<void> saveUserName({required String? update}) async {
    await _getStorage.write('userName', update);
    userName = _getStorage.read('userName') ?? '';
  }

  Future<void> saveReportFilePath({required String pathFile}) async {
    if (localeLangCode == 'en') {
      await _getStorage.write('englishReportPath', pathFile);
      englishReportPath = _getStorage.read('englishReportPath') ?? '';
    } else {
      await _getStorage.write('arabicReportPath', pathFile);
      arabicReportPath = _getStorage.read('arabicReportPath') ?? '';
    }
  }

  // Future<void> savePhoneNumber({required String update}) async {
  //   await _getStorage.write('phoneNumber', update);
  //   phoneNumber = _getStorage.read('phoneNumber') ?? '';
  // }
}
