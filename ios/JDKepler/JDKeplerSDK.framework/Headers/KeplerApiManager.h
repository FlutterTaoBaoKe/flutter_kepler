//
//  KeplerApiManager.h
//  KeplerApp
//  提供Kepler服务
//  Created by JD.K on 16/6/20.
//  Copyright © 2016年 JD.K. All rights reserved.
//  version 3.2.0

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 初始化成功回调 */
typedef void (^initSuccessCallback)();
/** 初始化失败回调 */
typedef void (^initFailedCallback)(NSError *error);
/** JD内部App登录流程 */
typedef void (^initJDInnerLogin)(UIViewController *currentViewController);

typedef void (^clearCookiesCallBack)(BOOL isSuccess);

typedef NS_ENUM(NSInteger, JDInnerLogin) {
    JDInnerLoginFailure = 0, //获取code失败
    JDInnerLoginCancel,      //用户取消登录
    JDInnerLoginSuccess      //获取code成功
};
/**
 *  Kepler登录授权成功回调
 *
 *  @param token  登录授权成功后返回的token
 */
typedef void (^keplerLoginSuccessCallback)();
/** Kepler登录授权失败回调 */
typedef void (^keplerLoginFailureCallback)(NSError *error);

typedef void (^keplerCompletionHandler)(BOOL result,id _Nullable responseObject, NSError * _Nullable error);


@interface KeplerApiManager : NSObject

/**
 分佣的 AppKey2
 */
@property (nonatomic, copy) NSString *secondAppKey;
//*********************************     通过京东APP打开链接相关参数      ************************************
/**
 是否强制使用H5打开界面 设置为YES时，打开链接时不会跳转到JD APP
 */
@property (nonatomic, assign)BOOL isOpenByH5;

/**
 当isOpenByH5为 NO 时，准备跳转到JD APP时会调用这些代码。可以把开启 Loading动画的代码放到这里
 为避免造成混乱，在关闭Kepler界面时，会置为nil。因此需要在每次打开Kepler之前单独设置。
 */
@property (nonatomic, copy) void(^startOpenJDAppBlock)();

/**
 当isOpenByH5为 NO 时，跳转JD APP准备工作完成时会调用这些代码，success为YES表示成功，可以打开JD APP，为NO时表示打开失败。
 为避免造成混乱，在关闭Kepler界面时，会置为nil。因此需要在每次打开Kepler之前单独设置。
 */
@property (nonatomic, copy) void(^finishOpenJDAppBlock)(BOOL success,NSError *error);
/**
 *  打开京东后显示的返回按钮的tagID
 **/
@property (nonatomic, copy) NSString *JDappBackTagID;
/**
 *  京东达人内容ID 关闭kepler界面时会清除 如果需要此值 再次打开需要再次设置
 **/
@property (nonatomic, copy) NSString *actId;
/**
 *  京东达人 内容渠道扩展字段 关闭kepler界面时会清除 如果需要此值 再次打开需要再次设置
 **/
@property (nonatomic, copy) NSString *ext;

/**
 打开京东超时时间设置 关闭 Kepler 界面时不会重置 默认为60
 */
@property (nonatomic, assign) NSTimeInterval openJDTimeout;
//*******************************************************************************************************



/**
 *  KeplerApiManager 单例
 *
 *  @return KeplerApiManager 单例
 */
+ (KeplerApiManager *)sharedKPService;
/**
 *  注册Kepler 服务
 *
 *  @param appKey      注册的appKey
 *  @param appSecret   注册的secretKey
 */
- (void)asyncInitSdk:(NSString *)appKey
           secretKey:(NSString *)appSecret
        jdInnerLogin:(initJDInnerLogin)jdInnerLogin
      sucessCallback:(initSuccessCallback)sucessCallback
      failedCallback:(initFailedCallback)failedCallback;

/**
 *  注册Kepler 服务
 *
 *  @param appKey      注册的appKey
 *  @param appSecret   注册的secretKey
 */
- (void)asyncInitSdk:(NSString *)appKey
           secretKey:(NSString *)appSecret
      sucessCallback:(initSuccessCallback)sucessCallback
      failedCallback:(initFailedCallback)failedCallback;


/**
 *  通过URL打开Kepler页面
 *
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param customParams     自定义订单统计参数 不需要可以传nil
 */
- (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openKeplerPageWithURL:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  打开导航页
 */
- (void)openNavigationPage:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openNavigationPage:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openNavigationPage:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  通过SKU打开Kepler单品页
 *
 *  @param sku              商品SKU
 */
- (void)openItemDetailWithSKU:(NSString *)sku
             sourceController:(UIViewController *)sourceController
                     jumpType:(NSInteger)jumpType
                 customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openItemDetailWithSKU:sourceController:jumpType:userInfo:", ios(7.0,11.0));
// 京东商详接口
- (void)openItemDetailWithSKU:(NSString *)sku
             sourceController:(UIViewController *)sourceController
                     jumpType:(NSInteger)jumpType
                     userInfo:(NSDictionary *)userInfo;

// 京喜商详接口
- (void)openJXItemDetailWithSKU:(NSString *)sku
               sourceController:(UIViewController *)sourceController
                       jumpType:(NSInteger)jumpType
                       userInfo:(NSDictionary *)userInfo;

/**
 *  打开订单列表
 */
- (void)openOrderList:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openOrderList:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openOrderList:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  根据搜索关键字打开搜索结果页
 *
 *  @param searchKey        搜索关键字
 */
- (void)openSearchResult:(NSString *)searchKey sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openSearchResult:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openSearchResult:(NSString *)searchKey sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  打开购物车界面
 *
 */
- (void)openShoppingCart:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openShoppingCart:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openShoppingCart:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;


/*********   注释:下面标注内的方法与上面对应个方法功能完全相同,只是有返回值    ***** For金融 **/
/*****************************  Start  *******************************************/

- (UIViewController *)openKeplerPageWithURL:(NSString *)url customParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openKeplerPageWithURL:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openKeplerPageWithURL:(NSString *)url userInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

/**
 *  打开导航页
 */
- (UIViewController *)openNavigationPageWithCustomParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openNavigationPageWithUserInfo:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openNavigationPageWithUserInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

/**
 *  通过SKU打开Kepler单品页
 */
- (UIViewController *)openItemDetailWithSKU:(NSString *)sku customParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openItemDetailWithSKU:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openItemDetailWithSKU:(NSString *)sku userInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

/**
 *  打开订单列表
 */
- (UIViewController *)openOrderListWithCustomParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openOrderListWithUserInfo:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openOrderListWithUserInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

/**
 *  根据搜索关键字打开搜索结果页
 */
- (UIViewController *)openSearchResult:(NSString *)searchKey customParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openSearchResult:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openSearchResult:(NSString *)searchKey userInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

/**
 *  打开购物车界面
 *
 */
- (UIViewController *)openShoppingCartWithCustomParams:(NSString *)customParams hiddenNavigationBar:(BOOL)hidden API_DEPRECATED_WITH_REPLACEMENT("openShoppingCartWithUserInfo:userInfo:hiddenNavigationBar:", ios(7.0,11.0));
- (UIViewController *)openShoppingCartWithUserInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;


/**
 联盟一键加购

 @param unionID 联盟ID
 @param appID AppID 查看位置：我的推广-推广管理-APP管理
 @param skuID 商品SKU
 @param refer refer (原生页面传域名+文章编号)
 @param subUnionId 子联盟ID，可用于区分媒体自身的用户ID
 @param viewController 当前的视图控制器
 @param completionHandler 返回
 */
- (void)keplerFastPurchaseWith:(NSString *)unionID
                         appID:(NSString *)appID
                         skuID:(NSString *)skuID
                         refer:(NSString *)refer
                    subUnionId:(NSString *)subUnionId
                    controller:(UIViewController *)viewController
                    completion:(keplerCompletionHandler)completionHandler;

/**
 批量一键加购

 @param unionID
 @param appID AppID 查看位置：我的推广-推广管理-APP管理
 @param skuIDs 商品SKU    以逗号隔开
 @param skuCounts 商品SKU 对应的数量   以逗号隔开
 @param refer refer (原生页面传域名+文章编号)
 @param subUnionId 子联盟ID，可用于区分媒体自身的用户ID
 @param viewController 当前的视图控制器
 @param completionHandler 返回
 */
- (void)keplerFastPurchaseWith:(NSString *)unionID
                         appID:(NSString *)appID
                        skuIDs:(NSString *)skuIDs
                     skuCounts:(NSString *)skuCounts
                         refer:(NSString *)refer
                    subUnionId:(NSString *)subUnionId
                    controller:(UIViewController *)viewController
                    completion:(keplerCompletionHandler)completionHandler;

/*****************************   End   *******************************************/


 /**深圳的加车接口
 @param sku 商品sku
 @param num 商品数量
 @param success 添加成功回调
 @param failure 添加失败回调
 */
- (void)addToCartWithSku:(NSString *)sku num:(NSString *)num sourceController:(UIViewController *)sourceController success:(void(^)(void))success failure:(void(^)(NSInteger))failure;

/**
 *  Kepler处理URL
 *
 *  @param url url
 *
 *  @return 处理结果
 */
- (BOOL)handleOpenURL:(NSURL*)url;
/**
 *  取消打开京东 如果打开京东APP在弱网情况下耗时过长，需要取消打开京东，可调用该方法。
 *  SDK会执行finishOpenJDAppBlock
 *  取消后不会尝试使用H5打开
 **/
- (void)cancelOpenJD;

/**
 *  M静态化检测更新
 */
- (void)checkUpdate;
/**
 *  取消授权
 */
- (void)cancelAuth;

- (void)cancelAuthWithBlock:(clearCookiesCallBack)completedBlock;

/**
 *  设置加载进度条颜色
 */
- (void)setKeplerProgressBarColor:(UIColor *)progressBarColor;
/**
 *  设置导航背景颜色
 */
- (void)setKeplerNavBackgroundColor:(UIColor *)backgrondColor;
/**
 *  设置导航高度
 */
- (void)setKeplerNavHeight:(CGFloat)height;
/**
 *  设置导航标题颜色
 */
- (void)setKeplerNavTitleTextColor:(UIColor *)textColor;
/**
 *  设置导航标题字体
 */
- (void)setKeplerNavTitleFont:(UIFont *)font;
/**
 *  设置导航按钮文字颜色
 */
- (void)setKeplerNavBtnTextColor:(UIColor *)textColor;
/**
 *  设置导航按钮文字字体
 */
- (void)setKeplerNavBtnFont:(UIFont *)font;

/**
 *  Kepler登录授权
 */
- (void)keplerLoginWithViewController:(UIViewController *)viewController success:(keplerLoginSuccessCallback)successCallback failure:(keplerLoginFailureCallback)failureCallback;

//登录态验证
- (void)keplerLoginWithSuccess:(void (^)())successBlock failure:(void (^)())failureBlock;


//金融内部使用
- (void)getTokenWithCode:(NSString *)code success:(keplerLoginSuccessCallback)successCallback failure:(keplerLoginFailureCallback)failureCallback;

- (void)jdInnerLoginResult:(JDInnerLogin)result code:(NSString *)code;

@end

