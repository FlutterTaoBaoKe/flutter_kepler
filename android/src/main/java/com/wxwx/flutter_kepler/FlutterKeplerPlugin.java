package com.wxwx.flutter_kepler;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterKeplerPlugin */
public class FlutterKeplerPlugin implements MethodCallHandler {

  private static com.wxwx.flutter_kepler.FlutterKeplerHandle handle;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    handle = FlutterKeplerHandle.getInstance(registrar);
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_kepler");
    channel.setMethodCallHandler(new FlutterKeplerPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("initKepler")){
      handle.initKepler(call, result);
    }else if(call.method.equals("keplerLogin")){
      handle.keplerLogin(result);
    }else if(call.method.equals("keplerIsLogin")){
      handle.keplerIsLogin(call, result);
    }else if(call.method.equals("keplerCancelAuth")){
      handle.keplerCancelAuth(call, result);
    } else if(call.method.equals("keplerPageWithURL")){
      handle.openJDUrlPage(call, result);
    } else if(call.method.equals("keplerNavigationPage")){
      handle.keplerNavigationPage(call, result);
    } else if(call.method.equals("keplerOpenItemDetailWithSKU")){
      handle.keplerOpenItemDetail(call, result);
    } else if(call.method.equals("keplerOpenOrderList")){
      handle.keplerOpenOrderList(call, result);
    } else if(call.method.equals("keplerOpenSearchResult")){
      handle.keplerOpenSearchResult(call, result);
    }  else if(call.method.equals("keplerOpenShoppingCart")){
      handle.keplerOpenShoppingCart(call, result);
    } else if(call.method.equals("keplerAddToCartWithSku")){
      handle.keplerAddToCartWithSku(call, result);
    } else if(call.method.equals("keplerFastPurchase")){
      handle.keplerFastPurchase(call, result);
    } else if(call.method.equals("keplerCheckUpdate")){
      handle.keplerCheckUpdate(call, result);
    } else if(call.method.equals("setKeplerProgressBarColor")){
      handle.setKeplerProgressBarColor(call, result);
    } else if(call.method.equals("setKeplerOpenByH5")){
      handle.setKeplerOpenByH5(call, result);
    } else if(call.method.equals("setKeplerJDappBackTagID")){
      handle.setKeplerJDappBackTagID(call, result);
    } else {
      result.notImplemented();
    }
  }
}
