import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/data/services/settings_service.dart';
import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter_uae_pass/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:flutter_uae_pass/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late Size _size;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            body:
                //Get.find<SettingsService>().firstRun
                FutureBuilder(
                    future: animationTimer(),
                    builder: ((context, snapshot) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: SizedBox(
                              height: _size.height,
                              width: _size.width,
                              child: Lottie.asset(
                                'assets/images/splash.json',
                                controller: _controller,
                                fit: BoxFit.fitWidth,
                                onLoaded: (composition) {
                                  _controller
                                    ..duration = composition.duration
                                    ..forward();
                                },
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                  opacity: 1.0,
                                  child: Center(
                                    child: Image.asset(
                                        'assets/images/robot.png',
                                        height: 100,
                                        width: 200),
                                  )),
                              SizedBox(
                                height: 92,
                              ),
                              Opacity(
                                opacity: 0.0,
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(_size.width * 0.8, 50),
                                      primary: AppColors.darkBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    onPressed: () async {
                                      Get.find<SettingsService>().onBoarding();
                                      _showLoginSheet();
                                    },
                                    child: AutoSizeText(
                                      'lets_go'.tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          )
                        ],
                      );
                    }))),
      ),
    );
  }

  Future<void> animationTimer() async {
    await Future.delayed(const Duration(seconds: 6));//todo
    print("splash_view: logged_in: " +
        Get.find<SettingsService>().loggedIn.toString());
    print("splash_view: firstRun: " +
        Get.find<SettingsService>().firstRun.toString());
    if (Get.find<SettingsService>().loggedIn) {
      print("splash_view: check isTokenValid");
      var isTokenValid = await Get.find<AuthController>().isTokenValid();
      if (isTokenValid) {
        print("splash_view: TokenValid");
        Get.offAll(DashboardView(), binding: DashboardBinding());
      } else {
        _showLoginSheet();
      }
    } else {
      print("SHOW login screen");
      _showLoginSheet();
    }
  }

  void _showLoginSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: AppColors.darkBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.2,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(18.0),
              child: SizedBox(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            minimumSize: Size(_size.width, 60),
                            maximumSize: Size(_size.width, 60),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: (() => Get.find<AuthController>().login()),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                    'assets/images/uae_pass_icon.png')),
                            Expanded(
                              child: AutoSizeText(
                                "sign_in_uae_pass".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ); //whatever you're returning, does not have to be a Container
        });
  }
}
