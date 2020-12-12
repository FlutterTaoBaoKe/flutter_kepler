//
//  FlutterKeplerHandler.h
//  flutter_kepler
//
//  Created by 吴兴 on 2019/9/10.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterKeplerHandler : NSObject
//初始化
- (void)initKepler:(FlutterMethodCall *)call result:(FlutterResult)result;
// *  通过URL打开任意商品页面
- (void)keplerPageWithURL:(FlutterMethodCall *)call result:(FlutterResult)result;
//打开导航页
- (void)keplerNavigationPage:(FlutterMethodCall *)call result:(FlutterResult)result;
// *  通过SKU打开Kepler单品页
- (void)keplerOpenItemDetailWithSKU:(FlutterMethodCall *)call result:(FlutterResult)result;
//打开订单列表 （支持Native && H5)
- (void)keplerOpenOrderList:(FlutterMethodCall *)call result:(FlutterResult)result;
//根据搜索关键字打开搜索结果页
- (void)keplerOpenSearchResult:(FlutterMethodCall *)call result:(FlutterResult)result;
//打开购物车
- (void)keplerOpenShoppingCart:(FlutterMethodCall *)call result:(FlutterResult)result;
//  添加到购物车（深圳）
- (void)keplerAddToCartWithSku:(FlutterMethodCall *)call result:(FlutterResult)result;
// 联盟一键加购
- (void)keplerFastPurchase:(FlutterMethodCall *)call result:(FlutterResult)result;
// 购物车一键加购
- (void)keplerFastPurchaseSkus:(FlutterMethodCall *)call result:(FlutterResult)result;
//静态化检测更新
- (void)keplerCheckUpdate:(FlutterMethodCall *)call result:(FlutterResult)result;
//登录授权
- (void)keplerLogin:(FlutterMethodCall *)call result:(FlutterResult)result;
//取消授权并且清除登录态
- (void)keplerCancelAuth:(FlutterMethodCall *)call result:(FlutterResult)result;

//设置进度条颜色
- (void)setKeplerProgressBarColor:(FlutterMethodCall *)call result:(FlutterResult)result;
//检测登录态
- (void)keplerLoginWithSuccess:(FlutterMethodCall *)call result:(FlutterResult)result;
// 是否强制使用H5打开界面 默认为YES;设置为NO时,调用商品详情页,订单列表,购物车等方法时将跳转到京东app并打开对应的界面.
- (void)setKeplerOpenByH5:(FlutterMethodCall *)call result:(FlutterResult)result;
//打开京东后显示的返回按钮的tagID
- (void)setKeplerJDappBackTagID:(FlutterMethodCall *)call result:(FlutterResult)result;
@end

NS_ASSUME_NONNULL_END
