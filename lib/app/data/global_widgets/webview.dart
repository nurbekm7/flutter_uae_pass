import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;
  const WebViewPage({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.darkBlue,
            ),
            title: AutoSizeText(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: AppColors.darkBlue,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),
          body: WebView(
              zoomEnabled: false,
              debuggingEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url),
        ),
      ),
    );
  }
}
