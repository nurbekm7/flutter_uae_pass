import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'by_clicking'.tr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
    
        TextSpan(
          text: 'collect_and_share'.tr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      
      ]),
    );
  }
}
