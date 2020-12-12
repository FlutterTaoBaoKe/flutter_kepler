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
    [[KeplerApiManager sharedKPService] asyncInitSdk:appKey secretKey:appSecret jdInnerLogin:nil sucessCallback:^{
        result(@{
                 FlutterKeplerConstKey_ErrorCode:@"0",
                 FlutterKeplerConstKey_ErrorMessage:@"success",
                 });
    } failedCallback:^(NSError *error) {
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 });
    }];
}
#pragma mark - 实用功能
/**
 *  通过URL打开任意商品页面
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param userInfo    不需要可以传nil  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
 * 禁止传参带入以下符号：   =#%&+?<{}
 *
 */
- (void)keplerPageWithURL:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *url = call.arguments[@"url"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [[KeplerApiManager sharedKPService] openKeplerPageWithURL:url sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}
/**
 *  打开导航页
 */
- (void)keplerNavigationPage:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openNavigationPage:rootViewController jumpType:jumpType userInfo:userInfo];
}


/**
 *  通过SKU打开Kepler单品页
 *  @param sku              商品SKU
 */
- (void)keplerOpenItemDetailWithSKU:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *sku = call.arguments[@"sku"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openItemDetailWithSKU:sku sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}

//打开订单列表 （支持Native && H5)
- (void)keplerOpenOrderList:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openOrderList:rootViewController jumpType:jumpType userInfo:userInfo];
}

/**
 *  根据搜索关键字打开搜索结果页
 *  @param searchKey        搜索关键字
 */
- (void)keplerOpenSearchResult:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *searchKey = call.arguments[@"searchKey"];
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openSearchResult:searchKey sourceController:rootViewController jumpType:jumpType userInfo:userInfo];
}

/**
 文档有，代码没有，不讲武德京东
 
 *  根据传入的名称打开对应的分类列表

 *  名称必须是京东支持的分类:

@"热门分类","手机",@"家用电器",@"电脑办公","摄影数码",@"女装服饰",@"男装服饰",@"时尚鞋靴",@"内衣配件",@"运动户外",

@"珠宝饰品",@"钟表",@"母婴用品",@"童装童鞋",@"玩具乐器",@"护肤美妆",@"清洁洗护",@"皮具箱包",@"家居家纺",@"生活用品",

@"食品生鲜",@"酒水饮料",@"奢品礼品",@"家具建材",@"热卖品牌",@"营养保健",@"汽车用品",@"宠物专区",@"图书音像"@"情趣用品";

也可打开导航页实时查看所支持的分类.

 */
//- (void)keplerOpenCategoryListWithName:(FlutterMethodCall *)call result:(FlutterResult)result {
//    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//    NSString *categoryName = call.arguments[@"categoryName"];
//    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
//    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
//    [[KeplerApiManager sharedKPService] openShoppingCart:rootViewController jumpType:jumpType userInfo:userInfo]
//}

/**
 *  打开购物车界面
 */
- (void)keplerOpenShoppingCart:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    //    NSInteger jumpType = [call.arguments[@"jumpType"] integerValue];
    NSInteger jumpType = [[NSNumber numberWithInt:1] integerValue];
    NSDictionary *userInfo = [FlutterKeplerTools nullToNil:call.arguments[@"userInfo"]];
    [[KeplerApiManager sharedKPService] openShoppingCart:rootViewController jumpType:jumpType userInfo:userInfo];
}


/**
 文档有，代码没有，不讲武德京东

*  添加到购物车

*

*  @param skuList 添加到购物车中的商品id

*  @param numList 添加到购物车中商品数量,多个商品必须与skuList一一对应

*  @param success 添加成功回调

*  @param failure 添加失败回调

*/

//- (void)addToCartWithSkuList:(NSArray *)skuList numList:(NSArray *)numList sourceController:(UIViewController *)
//
//sourceController success:(void(^)(void))success failure:(void(^)(NSError *))failure;
/**
 *  添加到购物车 （深圳）
 *
 *  @param sku 商品sku
 *  @param num 添加到购物车中商品数量
 *  @param success 添加成功回调
 *  @param failure 添加失败回调
 */
- (void)keplerAddToCartWithSku:(FlutterMethodCall *)call result:(FlutterResult)result {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *sku = call.arguments[@"sku"];
    NSString *num = call.arguments[@"num"];
    
    
    [[KeplerApiManager sharedKPService] addToCartWithSku:sku num:num sourceController:rootViewController success:^{
        //        加车成功
        result(@{
                 FlutterKeplerConstKey_ErrorCode : @"0",
                 FlutterKeplerConstKey_ErrorMessage : @"success",
                 });
    } failure:^(NSInteger errorCode) {
        result(@{
                 FlutterKeplerConstKey_ErrorCode :[NSString stringWithFormat: @"%ld", (long)errorCode],
                 FlutterKeplerConstKey_ErrorMessage : [self errorMessageFromCode:errorCode],
                 });
    }];
}

/**
 
 联盟一键加购
 unionID 联盟ID,
 AppID 查看位置：我的推广-推广管理-APP管理
 skuID 商品SKU,
 subUnionId 子联盟ID，可用于区分媒体自身的用户ID
 refer refer (原生页面传域名+文章编号),viewController 当前的视图控制器,completionHandler 返回
 
 */
- (void)keplerFastPurchase:(FlutterMethodCall *)call result:(FlutterResult)flutterResult {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *unionID = call.arguments[@"unionID"];
    NSString *appId = call.arguments[@"appId"];
    NSString *skuID = call.arguments[@"skuID"];
    NSString *refer = call.arguments[@"refer"];
    NSString *subUnionId = call.arguments[@"subUnionId"];
    [[KeplerApiManager sharedKPService] keplerFastPurchaseWith:unionID appID:appId skuID:skuID refer:refer subUnionId:subUnionId controller:rootViewController completion:^(BOOL result, id  _Nullable responseObject, NSError * _Nullable error) {
        if (result) {
            flutterResult(@{
                            FlutterKeplerConstKey_ErrorCode : @"0",
                            FlutterKeplerConstKey_ErrorMessage : @"success",
                            });
        }else{
            flutterResult(@{
                            FlutterKeplerConstKey_ErrorCode : [NSString stringWithFormat: @"%ld", (long)error.code],
                            FlutterKeplerConstKey_ErrorMessage :error.localizedDescription,
                            });
        }
    }];
}



/**

 批量一键加购
 批量加车，支持分佣功能

 

 @param unionID

 @param appID AppID 查看位置：我的推广-推广管理-APP管理

 @param skuIDs 商品SKU数组

 @param skuCounts 商品SKU对应的数量

 @param refer refer (原生页面传域名+文章编号)
 
 @param subUnionId 子联盟ID，可用于区分媒体自身的用户ID
 
 @param viewController 当前的视图控制器

 @param completionHandler 返回

 */
- (void)keplerFastPurchaseSkus:(FlutterMethodCall *)call result:(FlutterResult)flutterResult {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *unionID = call.arguments[@"unionID"];
    NSString *appId = call.arguments[@"appId"];
//    逗号分隔符
    NSString *skuIDs = call.arguments[@"skuIDs"];
//    逗号分隔符
    NSString *skuCounts = call.arguments[@"skuCounts"];
//     传当前调用加车接口的页面地址
    NSString *refer = call.arguments[@"refer"];
    NSString *subUnionId = call.arguments[@"subUnionId"];
    [[KeplerApiManager sharedKPService] keplerFastPurchaseWith:unionID appID:appId skuIDs:skuIDs skuCounts:skuCounts refer:refer subUnionId:subUnionId controller:rootViewController completion:^(BOOL result, id  _Nullable responseObject, NSError * _Nullable error) {
        if (result) {
            flutterResult(@{
                            FlutterKeplerConstKey_ErrorCode : @"0",
                            FlutterKeplerConstKey_ErrorMessage : @"success",
                            });
        }else{
            flutterResult(@{
                            FlutterKeplerConstKey_ErrorCode : [NSString stringWithFormat: @"%ld", (long)error.code],
                            FlutterKeplerConstKey_ErrorMessage :error.localizedDescription,
                            });
        }
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
                 //                 FlutterKeplerConstKey_Data:@{},
                 });
    } failure:^(NSError *error) {
        result(@{
                 FlutterKeplerConstKey_ErrorCode:[NSString stringWithFormat: @"%ld", error.code],
                 FlutterKeplerConstKey_ErrorMessage:error.localizedDescription,
                 //                 FlutterKeplerConstKey_Data:@{},
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



//错误码判断
- (NSString *)errorMessageFromCode:(NSInteger)errorCode{
    switch (errorCode) {
        case 0:
            return @"success";
            break;
        case 30001:
            return @"SKU类型无效";
            break;
        case 30002:
            return @"未找到SKU";
            break;
        case 30003:
            return @"加入购物车失败";
            break;
        case 30004:
            return @"绑定用户参数有误";
            break;
        case 30008:
            return @"加车参数有误";
            break;
        case 30009:
            return @"查询所有sku失败";
            break;
        case 30010:
            return @"请求接口参数缺失";
            break;
        case 30012:
            return @"IP参数格式有误";
            break;
        case 30013:
            return @"DeviceType参数格式有误";
            break;
        case 30014:
            return @"UniodID有误";
            break;
        default:
            return @"未知错误";
            break;
    }
}
@end
