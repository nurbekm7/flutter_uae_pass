import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_uae_pass/app/data/global_widgets/loading_overlay.dart';
import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../data/theme/colors.dart';

class LoginView extends GetView<AuthController> {
  late Size _size;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.darkBlue,
      child: SafeArea(
        bottom: false,
        child: LoadingOverlay(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: _size.height / 3,
                            width: _size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              color: AppColors.darkBlue,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                               child: Container (
                                 padding: const EdgeInsetsDirectional.only(
                            start: 16.0, top: 10, end: 10),
                                child: Image.asset(
                                    'assets/images/robot.png',
                                    width: 160,
                                    height: 80),
                              )),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: _size.width * 0.1,
                                    bottom: 10,
                                    top: 10),
                                child: AutoSizeText(
                                  'welcome'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: _size.width * 0.1, bottom: 16),
                                child: AutoSizeText(
                                  'sign_in'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Center(
                                  child: SizedBox(
                                    width: _size.width * 0.8,
                                    height: 400,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(18.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0.0,
                                                        minimumSize: Size(
                                                            _size.width, 50),
                                                        maximumSize: Size(
                                                            _size.width, 50),
                                                        primary: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .black12),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    onPressed: (() => Get.find<
                                                            AuthController>()
                                                        .login()),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child: Image.asset(
                                                                'assets/images/uae_pass_icon.png')),
                                                        Expanded(
                                                          child: AutoSizeText(
                                                            "sign_in_uae_pass"
                                                                .tr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8.0),
                                                child: AutoSizeText(
                                                  'sign_in_uae_pass_desc'.tr,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
