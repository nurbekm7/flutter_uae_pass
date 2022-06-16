import 'package:flutter_test/flutter_test.dart';
import 'package:uaepass_plugin/uaepass_plugin.dart';
import 'package:uaepass_plugin/uaepass_plugin_platform_interface.dart';
import 'package:uaepass_plugin/uaepass_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUaepassPluginPlatform 
    with MockPlatformInterfaceMixin
    implements UaepassPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UaepassPluginPlatform initialPlatform = UaepassPluginPlatform.instance;

  test('$MethodChannelUaepassPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUaepassPlugin>());
  });

  test('login', () async {
    UaepassPlugin uaepassPlugin = UaepassPlugin();
    MockUaepassPluginPlatform fakePlatform = MockUaepassPluginPlatform();
    UaepassPluginPlatform.instance = fakePlatform;
  
    expect(await uaepassPlugin.login(), '42');
  });
}
