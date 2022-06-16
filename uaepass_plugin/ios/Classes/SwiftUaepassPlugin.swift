import Flutter
import UIKit

public class SwiftUaepassPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
//    let channel = FlutterMethodChannel(name: "uaepass_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftUaepassPlugin()
//    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      debugPrint(call.method)
//      result("iOS " + UIDevice.current.systemVersion)
  }
    
    
    
}
