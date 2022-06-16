import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/data/services/settings_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  
}
