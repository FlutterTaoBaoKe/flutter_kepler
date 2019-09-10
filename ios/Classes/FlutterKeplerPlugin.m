#import "FlutterKeplerPlugin.h"
#import "FlutterKeplerHandler.h"
#import <JDKeplerSDK/JDKeplerSDK.h>
#import <JDKeplerSDK/KeplerApiManager.h>
@interface FlutterKeplerPlugin()
@property(nonatomic,strong) FlutterKeplerHandler *keplerHandler;
@end

@implementation FlutterKeplerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_kepler"
            binaryMessenger:[registrar messenger]];
  FlutterKeplerPlugin* instance = [[FlutterKeplerPlugin alloc] initWithRegistrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
}
- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    self = [super init];
    
    if (self) {
        self.keplerHandler = [[FlutterKeplerHandler alloc]init];
    }
    
    return self;
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *) sourceApplication annotation:(id)annotation NS_AVAILABLE_IOS(4_2){
    if(![[KeplerApiManager sharedKPService] handleOpenURL:url]){
        // 处理其他app跳转到自己的app
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    if (@available(iOS 9.0, *)) {
        __unused BOOL isHandledByKepler=[[KeplerApiManager sharedKPService] handleOpenURL:url];
    } else {
        // Fallback on earlier versions
    }
    return YES;
}




@end
