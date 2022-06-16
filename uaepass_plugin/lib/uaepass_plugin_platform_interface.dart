import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uaepass_plugin_method_channel.dart';

abstract class UaepassPluginPlatform extends PlatformInterface {
  /// Constructs a UaepassPluginPlatform.
  UaepassPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static UaepassPluginPlatform _instance = MethodChannelUaepassPlugin();

  /// The default instance of [UaepassPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelUaepassPlugin].
  static UaepassPluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UaepassPluginPlatform] when
  /// they register themselves.
  static set instance(UaepassPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> login() {
    throw UnimplementedError('login() has not been implemented.');
  }

  Future<String?> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
