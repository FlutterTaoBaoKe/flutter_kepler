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
  [registrar addApplicationDelegate:instance];
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
    }else if ([@"keplerFastPurchaseSkus" isEqualToString:call.method]) {
        [_keplerHandler keplerFastPurchaseSkus:call result:result];
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
    }else {
      result(FlutterMethodNotImplemented);
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0){// no equiv. notification. return NO if the application can't open for some reason
    return [[KeplerApiManager sharedKPService] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation NS_AVAILABLE_IOS(4_2){
    //区分一下授权登录和未授权的登录
    
    return [[KeplerApiManager sharedKPService] handleOpenURL:url];
}
@end
