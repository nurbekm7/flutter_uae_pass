import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  late var subscription;
  late bool isConnected;
  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void initCheckConnectivity() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      isConnected = result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi
          ? true
          : false;
      if (!isConnected) {
        // Get.snackbar('Error', 'Please connect to Internet');
      }
    });
  }
}