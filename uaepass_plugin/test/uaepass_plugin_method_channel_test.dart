import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uaepass_plugin/uaepass_plugin_method_channel.dart';

void main() {
  MethodChannelUaepassPlugin platform = MethodChannelUaepassPlugin();
  const MethodChannel channel = MethodChannel('uaepass_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
