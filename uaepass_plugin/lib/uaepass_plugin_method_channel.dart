import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'uaepass_plugin_platform_interface.dart';

/// An implementation of [UaepassPluginPlatform] that uses method channels.
class MethodChannelUaepassPlugin extends UaepassPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uaepass_plugin');

  @override
  Future<String?> login() async {
    final response = await methodChannel.invokeMethod<String>('login');
    return response;
  }

  @override
  Future<String?> logout() async {
    final response = await methodChannel.invokeMethod<String>('logout');
    return response;
  }
}
