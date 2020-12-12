import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kepler/kepler_model.dart';

import 'kepler_const_key.dart';

class FlutterKepler {
  static const MethodChannel _channel = const MethodChannel('flutter_kepler');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

// 初始化
  static Future<ResultModel> initKepler(
      {@required String appKey, @required String appSecret}) async {
    Map result = await _channel
        .invokeMethod("initKepler", {"appKey": appKey, "appSecret": appSecret});
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  ///
  ///  通过URL打开任意商品页面
  ///  @param url              页面url
  ///  @param userInfo    不需要可以不传   传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerPageWithURL({@required String url, Map userInfo}) {
    _channel
        .invokeMethod("keplerPageWithURL", {"url": url, "userInfo": userInfo});
  }

  ///
  ///  打开导航页
  ///  @param userInfo    不需要可以不传   传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerNavigationPage({Map userInfo}) {
    _channel.invokeMethod("keplerNavigationPage", {"userInfo": userInfo});
  }

  ///
  ///  通过SKU打开Kepler单品页
  ///  @param sku              商品sku
  ///  @param userInfo    不需要可以不传  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerOpenItemDetailWithSKU({@required String sku, Map userInfo}) {
    _channel.invokeMethod(
        "keplerOpenItemDetailWithSKU", {"sku": sku, "userInfo": userInfo});
  }

  ///
  ///  打开订单列表
  ///  @param userInfo    不需要可以不传  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerOpenOrderList({Map userInfo}) {
    _channel.invokeMethod("keplerOpenOrderList", {"userInfo": userInfo});
  }

  ///
  ///  根据搜索关键字打开搜索结果页
  ///  @param searchKey     搜索关键字
  ///  @param userInfo    不需要可以不传  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerOpenSearchResult({@required String searchKey, Map userInfo}) {
    _channel.invokeMethod("keplerOpenSearchResult",
        {"searchKey": searchKey, "userInfo": userInfo});
  }

  ///
  ///  打开购物车界面
  ///  @param userInfo    不需要可以不传  传参数据为第三方应用自定义,可以为页面,频道标识;也可以标识分成信息;该数据只做统计需求。传参长度，使用URL encode之后长度必须小于256字节（不建议传入中文以及特殊字符）
  /// 禁止传参带入以下符号：   =#%&+?<{}
  ///
  ///
  static keplerOpenShoppingCart({Map userInfo}) {
    _channel.invokeMethod("keplerOpenShoppingCart", {"userInfo": userInfo});
  }

  ///
  ///  添加到购物车（深圳的加车接口）
  /// @param sku 添加到购物车中的商品id
  /// @param number 添加到购物车中商品数量,默认1件
  ///
  ///
  static Future<ResultModel> keplerAddToCartWithSku(
      {@required String sku, String number = "1"}) async {
    Map result = await _channel
        .invokeMethod("keplerAddToCartWithSku", {"sku": sku, "num": number});
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  ///
  ///联盟一键加购
  ///unionID 联盟ID
  ///AppID 查看位置：我的推广-推广管理-APP管理
  ///skuID 商品SKU,
  ///refer refer (原生页面传域名+文章编号)
  ///subUnionId 子联盟ID，可用于区分媒体自身的用户ID
  ///
  static Future<ResultModel> keplerFastPurchase({
    @required String unionID,
    @required String appID,
    @required String skuID,
    @required String refer,
    @required String subUnionId,
  }) async {
    Map result = await _channel.invokeMethod("keplerFastPurchase", {
      "unionID": unionID,
      "appID": appID,
      "skuID": skuID,
      "refer": refer,
      "subUnionId": subUnionId,
    });
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  ///
  ///购物车一键加购
  ///unionID 联盟ID
  ///AppID 查看位置：我的推广-推广管理-APP管理
  ///skus 商品SKU的数组[{skuID:"132",count:"123"}],
  ///refer refer (原生页面传域名+文章编号)
  ///subUnionId 子联盟ID，可用于区分媒体自身的用户ID
  ///
  static Future<ResultModel> keplerFastPurchaseSkus({
    @required String unionID,
    @required String appID,
    @required List<CartItem> skus,
    @required String refer,
    @required String subUnionId,
  }) async {
    String skuIDs = "";
    String counts = "";
    skus.forEach((element) {
      skuIDs = skuIDs + "," + element.skuID;
      counts = counts + "," + element.count;
    });
    skuIDs = skuIDs.substring(1);
    counts = counts.substring(1);

    Map result = await _channel.invokeMethod("keplerFastPurchaseSkus", {
      "unionID": unionID,
      "appID": appID,
      "skuIDs": skuIDs,
      "skuCounts": counts,
      "refer": refer,
      "subUnionId": subUnionId,
    });
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  // /// 静态化检测更新，Android无此接口
  // static keplerCheckUpdate() {
  //   _channel.invokeMethod("keplerCheckUpdate");
  // }

  /// 登录授权
  static Future<ResultModel> keplerLogin() async {
    Map result = await _channel.invokeMethod("keplerLogin");
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  //取消授权并且清除登录态
  static keplerCancelAuth() {
    _channel.invokeMethod(
      "keplerCancelAuth",
    );
  }

// // 设置进度条颜色,16进制
//   static setKeplerProgressBarColor({
//     @required String color,
//   }) {
//     _channel.invokeMethod("setKeplerProgressBarColor", {"color": color});
//   }

// 判断当前是否已经登录授权
  static Future<ResultModel> keplerIsLogin() async {
    Map result = await _channel.invokeMethod("keplerIsLogin");
    return ResultModel(
      result[KeplerConstKey.errorCode],
      result[KeplerConstKey.errorMessage],
    );
  }

  /// 是否强制使用H5打开界面 默认为true;
  /// 设置为false时,调用商品详情页,订单列表,购物车等方法时将跳转到京东app并打开对应的界面
  static setKeplerOpenByH5({
    @required bool isOpenByH5,
  }) {
    _channel.invokeMethod("setKeplerOpenByH5", {"isOpenByH5": isOpenByH5});
  }
}
