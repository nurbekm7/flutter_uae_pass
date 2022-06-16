import 'uaepass_plugin_platform_interface.dart';

class UaepassPlugin {

  Future<String?> login() {
    return UaepassPluginPlatform.instance.login();
  }

  Future<String?> logout() {
    return UaepassPluginPlatform.instance.logout();
  }
}
