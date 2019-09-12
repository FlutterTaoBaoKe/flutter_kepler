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
  }else if ([@"initKepler" isEqualToString:call.method]) {
      [_keplerHandler initKepler:call result:result];
  }else if ([@"keplerPageWithURL" isEqualToString:call.method]) {
      [_keplerHandler keplerPageWithURL:call result:result];
  }else if ([@"keplerNavigationPage" isEqualToString:call.method]) {
      [_keplerHandler keplerNavigationPage:call result:result];
  }else if ([@"keplerOpenItemDetailWithSKU" isEqualToString:call.method]) {
      [_keplerHandler keplerOpenItemDetailWithSKU:call result:result];
  }else if ([@"keplerOpenOrderList" isEqualToString:call.method]) {
      [_keplerHandler keplerOpenOrderList:call result:result];
  }else if ([@"keplerOpenSearchResult" isEqualToString:call.method]) {
      [_keplerHandler keplerOpenSearchResult:call result:result];
  }else if ([@"keplerOpenShoppingCart" isEqualToString:call.method]) {
      [_keplerHandler keplerOpenShoppingCart:call result:result];
  }else if ([@"keplerAddToCartWithSku" isEqualToString:call.method]) {
      [_keplerHandler keplerAddToCartWithSku:call result:result];
  }else if ([@"keplerFastPurchase" isEqualToString:call.method]) {
      [_keplerHandler keplerFastPurchase:call result:result];
  }else if ([@"keplerCheckUpdate" isEqualToString:call.method]) {
      [_keplerHandler keplerCheckUpdate:call result:result];
  }else if ([@"keplerLogin" isEqualToString:call.method]) {
      [_keplerHandler keplerLogin:call result:result];
  }else if ([@"keplerCancelAuth" isEqualToString:call.method]) {
      [_keplerHandler keplerCancelAuth:call result:result];
  }else if ([@"setKeplerProgressBarColor" isEqualToString:call.method]) {
      [_keplerHandler setKeplerProgressBarColor:call result:result];
  }else if ([@"keplerIsLogin" isEqualToString:call.method]) {
      [_keplerHandler keplerLoginWithSuccess:call result:result];
  }else if ([@"setKeplerOpenByH5" isEqualToString:call.method]) {
      [_keplerHandler setKeplerOpenByH5:call result:result];
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
