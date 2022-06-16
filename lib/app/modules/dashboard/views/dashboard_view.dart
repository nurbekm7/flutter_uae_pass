import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_uae_pass/app/data/global_widgets/connectivity_view.dart';
import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/data/services/settings_service.dart';
import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  late Size _size;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late String msg = '';
  final _scrollController = ScrollController();

  void _scrollToItem({required GlobalKey sectionKey}) async {
    final context = sectionKey.currentContext!;
    await Scrollable.ensureVisible(context, duration: Duration(seconds: 1));
  }

  late GlobalKey _selectedKey;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return ConnectivityPage(
      child: Container(
        color: Color.fromRGBO(244, 67, 54, 1),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            key: _drawerKey,
            drawer: Container(
              width: _size.width * 0.8,
              color: Colors.white,
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName:
                        AutoSizeText(Get.find<SettingsService>().userName),
                    accountEmail: AutoSizeText(
                        'EID: ${Get.find<SettingsService>().userEid}'),
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                    ),
                    // currentAccountPicture: CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       'https://media.istockphoto.com/photos/arabian-man-with-traditional-dress-picture-id1188035960?k=20&m=1188035960&s=612x612&w=0&h=PvrWeSdLjUxTHruzz-yeC0POzrcwmr3kYKH010ehzWo=',
                    //       scale: 0.05),
                    // ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                        'assets/images/drawer-icons/logout-icon.svg'),
                    title: AutoSizeText('logout'.tr),
                    onTap: () {
                      Get.lazyPut(() => AuthController());
                      Get.find<AuthController>().logout();
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                        margin:
                            const EdgeInsetsDirectional.only(top: 16, end: 16),
                        padding:
                            const EdgeInsetsDirectional.only(top: 16, end: 16),
                        width: 160,
                        height: 80,
                        child: Image.asset("assets/images/robot.png")),
                  ),
                ],
              ),
            ),
            body: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(seconds: 1),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
