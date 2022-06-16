import 'package:flutter_uae_pass/app/data/services/auth_controller.dart';
import 'package:flutter_uae_pass/app/data/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoadingOverlay extends StatelessWidget {
  final dynamic child;
  LoadingOverlay({Key? key, required this.child}) : super(key: key);
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return GetBuilder<AuthController>(
      builder: (controller) => SizedBox(
        height: _size.height,
        width: _size.width,
        child: Stack(
          children: [
            Positioned.fill(child: child),
            controller.showLoadingOverlay
                ? Center(
                    child: Container(
                        height: _size.height,
                        width: _size.width,
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(child: CircularProgressIndicator())),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
