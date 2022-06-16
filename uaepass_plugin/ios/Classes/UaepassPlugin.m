#import "UaepassPlugin.h"
#if __has_include(<uaepass_plugin/uaepass_plugin-Swift.h>)
#import <uaepass_plugin/uaepass_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uaepass_plugin-Swift.h"
#endif

@implementation UaepassPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUaepassPlugin registerWithRegistrar:registrar];
}
@end
