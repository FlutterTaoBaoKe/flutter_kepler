#import "FlutterKeplerPlugin.h"
#if __has_include(<flutter_kepler/flutter_kepler-Swift.h>)
#import <flutter_kepler/flutter_kepler-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_kepler-Swift.h"
#endif

@implementation FlutterKeplerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterKeplerPlugin registerWithRegistrar:registrar];
}
@end
