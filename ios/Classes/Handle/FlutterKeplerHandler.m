//
//  FlutterKeplerHandler.m
//  flutter_kepler
//
//  Created by 吴兴 on 2019/9/10.
//

#import "FlutterKeplerHandler.h"
#import <JDKeplerSDK/JDKeplerSDK.h>
#import <JDKeplerSDK/KeplerApiManager.h>
#import "FlutterKeplerConstKey.h"
#import "FlutterKeplerTools.h"
@implementation FlutterKeplerHandler
//初始化开普勒
- (void)initKepler:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *appKey = call.arguments[@"appKey"];
    NSString *appSecret = call.arguments[@"appSecret"];
    [[KeplerApiManager sharedKPService]asyncInitSdk:appKey secretKey:appSecret sucessCallback:^(){
        //
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"success",
                 FlutterKeplerConstKey_Data:@{},
                 });
    }failedCallback:^(NSError *error){
        //
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 FlutterKeplerConstKey_Data:@{},
                 });
    }];
}

#pragma mark - 辅助功能
//静态化检测更新
- (void)keplerCheckUpdate:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] checkUpdate];
}

//登录授权
- (void)keplerLogin:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [[KeplerApiManager sharedKPService] keplerLoginWithViewController:rootViewController success:^{
        //        哪来的token???
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"success",
                 FlutterKeplerConstKey_Data:@{},
                 });
    } failure:^(NSError *error) {
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 FlutterKeplerConstKey_Data:@{},
                 });
    }];
}

//取消授权并且清除登录态
- (void)keplerCancelAuth:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] cancelAuth];
}


//设置进度条颜色
- (void)setKeplerProgressBarColor:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *color16 = call.arguments[@"color"];
    if(![FlutterKeplerTools isNil:color16]){
        UIColor *color = [FlutterKeplerTools colorWithHexString:color16];
        [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:color];
    }
}

//检测登录态
- (void)keplerLoginWithSuccess:(FlutterMethodCall *)call result:(FlutterResult)result {
    [[KeplerApiManager sharedKPService] keplerLoginWithSuccess:^{
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"登录有效",
                 });
    } failure:^{
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"-1",
                 FlutterKeplerConstKey_ErrorMessage:@"登录失效",
                 });
    }];
}

// 是否强制使用H5打开界面 默认为YES;设置为NO时,调用商品详情页,订单列表,购物车等方法时将跳转到京东app并打开对应的界面.
- (void)setKeplerOpenByH5:(FlutterMethodCall *)call result:(FlutterResult)result {
    [KeplerApiManager sharedKPService].isOpenByH5 = [call.arguments[@"isOpenByH5"] boolValue];
}

//打开京东后显示的返回按钮的tagID
- (void)setKeplerJDappBackTagID:(FlutterMethodCall *)call result:(FlutterResult)result {
    [KeplerApiManager sharedKPService].JDappBackTagID = call.arguments[@"JDappBackTagID"];
}


@end
