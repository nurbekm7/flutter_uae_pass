import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_uae_pass/app/data/models/uae_pass_profile.dart';
import 'package:flutter_uae_pass/app/data/models/uae_pass_verify.dart';
import 'package:flutter_uae_pass/app/data/services/settings_service.dart';
import 'package:flutter_uae_pass/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:flutter_uae_pass/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter_uae_pass/app/modules/splash/views/splash_view.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uaepass_plugin/uaepass_plugin.dart';

class AuthController extends GetxController {
  late String _userId;
  late UserProfile _userProfile;
  late String eid = '';
  late String accessToken = '';
  String? _verificationId = '';
  bool showLoadingOverlay = false;
  // final _uaepassPlugin = Uaepass();
  final _uaepassiOS = UaepassPlugin();

  Future<void> login() async {
    try {
      final resp = await _uaepassiOS.login() ?? '';
      if (resp.isNotEmpty) {
        print("LOGIN: resp : "+ resp);
        _userProfile = UserProfile.fromJson(json.decode(resp));
        print(_userProfile.accesscode);
        saveUserData();
      } else {
        print("LOGIN: empty resp: "+ resp);
        Fluttertoast.showToast(msg: 'Could not login using UAE Pass');
      }
    } on PlatformException {
      print("LOGIN: PlatformException: ");
      Fluttertoast.showToast(msg: 'Could not login using UAE Pass');
    }
  }

  Future<void> logout() async {
    //if there's a value then logout is successful
    try {
      final resp = await _uaepassiOS.logout() ?? '';
      if (resp.isNotEmpty) {
        print("LOGOUT in flutter level");
        Get.find<SettingsService>().logout();
      } else {
        Fluttertoast.showToast(msg: 'Could not logout');
      }
    } on PlatformException {
      Fluttertoast.showToast(msg: 'Could not logout');
    }
  }

  Future<bool> isTokenValid() async {
    if (Get.find<SettingsService>().userToken.isEmpty) return false;
    try {
      String username = 'sandbox_stage';
      String password = 'sandbox_stage';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final resp = await Dio().post(
          'https://stg-id.uaepass.ae/idshub/introspect',//todo
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "authorization": basicAuth
          }),
          queryParameters: {"token": Get.find<SettingsService>().userToken});
      print('USER TOKEN: ' + Get.find<SettingsService>().userToken);
      final isValid = UaePassVerify.fromJson(resp.data);
      return isValid.active;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void saveUserData() async {
    await Get.find<SettingsService>()
        .saveUserName(update: _userProfile.fullname);
    await Get.find<SettingsService>().saveUserEid(newEid: _userProfile.eid);
    await Get.find<SettingsService>()
        .saveUserToken(newToken: _userProfile.accesscode);
    await Get.find<SettingsService>().hasLoggedIn();
    try {
      showLoadingOverlay = false;
      update();
      Get.offAll(DashboardView(), binding: DashboardBinding());
    } catch (e) {
      print(e.toString());
    }
  }
}
