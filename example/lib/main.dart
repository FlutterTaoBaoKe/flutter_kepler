import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kepler/flutter_kepler.dart';
import 'package:flutter_kepler/kepler_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterKepler.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate:
                      SliverChildBuilderDelegate(_buildItem, childCount: 1),
                ),
              ],
            )));
  }

  Widget _buildItem(BuildContext context, int index) {
    return Center(
      child: Column(children: <Widget>[
        FlatButton(
          child: Text("初始化开普勒"),
          onPressed: () async {
            try {
              // var waite3s = await FlutterAlibc.openItemDetail(itemID: "12345");
              // 如果什么都不给
              var result = await FlutterKepler.initKepler(
                appKey: "0f777b0b8bc2db2c3105394cb3700111",
                appSecret: "eeac919be32c4cdbaaeca71bf8974112",
              );
              print(result);
            } on Exception {}
          },
        ),
        FlatButton(
          child: Text("打开Url"),
          onPressed: () {
            FlutterKepler.keplerPageWithURL(
              url: "https://item.jd.com/10510526268.html",
            );
          },
        ),
        FlatButton(
          child: Text("打开导航页"),
          onPressed: () {
            FlutterKepler.keplerNavigationPage();
          },
        ),
        FlatButton(
          child: Text("通过SKU打开Kepler单品页"),
          onPressed: () {
            FlutterKepler.keplerOpenItemDetailWithSKU(
              sku: "43684925672",
            );
          },
        ),
        FlatButton(
          child: Text("打开订单列表"),
          onPressed: () {
            FlutterKepler.keplerOpenOrderList();
          },
        ),
        FlatButton(
          child: Text("根据搜索关键字打开搜索结果页"),
          onPressed: () {
            FlutterKepler.keplerOpenSearchResult(
              searchKey: "耐克",
            );
          },
        ),
        FlatButton(
          child: Text("打开购物车界面"),
          onPressed: () {
            FlutterKepler.keplerOpenShoppingCart();
          },
        ),
        FlatButton(
          child: Text("添加到购物车（深圳的加车接口）"),
          onPressed: () async {
            var result = await FlutterKepler.keplerAddToCartWithSku(
              sku: "43684925672",
            );
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("联盟一键加购"),
          onPressed: () async {
            var result = await FlutterKepler.keplerFastPurchase(
              unionID: "",
              appID: "",
              skuID: "",
              refer: "",
              subUnionId: "",
            );
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("购物车批量加购"),
          onPressed: () async {
            List<CartItem> skus = [
              CartItem('43684925672','1'),
              CartItem('43684925673','3'),
            ];
            var result = await FlutterKepler.keplerFastPurchaseSkus(
              unionID: "",
              appID: "",
              refer: "",
              skus: skus,
              subUnionId: "",
            );
            print(result.errorCode);
          },
        ),
        // FlatButton(
        //   child: Text("静态化检测更新"),
        //   onPressed: () {
        //     FlutterKepler.keplerCheckUpdate();
        //   },
        // ),
        FlatButton(
          child: Text("登录授权"),
          onPressed: () async {
            var result = await FlutterKepler.keplerLogin();
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("取消授权并且清除登录态"),
          onPressed: () {
            FlutterKepler.keplerCancelAuth();
          },
        ),
        // FlatButton(
        //   child: Text("设置进度条颜色"),
        //   onPressed: () {
        //     FlutterKepler.setKeplerProgressBarColor(color: "##e23b41");
        //   },
        // ),
        FlatButton(
          child: Text("判断是否登录"),
          onPressed: () async {
            var result = await FlutterKepler.keplerIsLogin();
            print(result.errorCode);
          },
        ),
        FlatButton(
          child: Text("是否强制用h5打开"),
          onPressed: () {
            FlutterKepler.setKeplerOpenByH5(isOpenByH5: true);
          },
        ),
      ]),
    );
  }
}
