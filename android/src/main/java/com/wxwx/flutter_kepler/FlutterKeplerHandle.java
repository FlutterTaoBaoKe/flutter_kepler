package com.wxwx.flutter_kepler;

import android.content.DialogInterface;
import android.os.Handler;
import android.util.Log;
import android.webkit.WebChromeClient;
import android.webkit.WebViewClient;
import android.widget.Toast;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import java.util.HashMap;
import android.app.AlertDialog;
import static com.wxwx.flutter_kepler.PluginConstants.*;
import static com.wxwx.flutter_kepler.PluginUtil.*;

import com.kepler.jd.Listener.ActionCallBck;
import com.kepler.jd.Listener.AsyncInitListener;
import com.kepler.jd.Listener.LoginListener;
import com.kepler.jd.Listener.OpenAppAction;
import com.kepler.jd.login.KeplerApiManager;
import com.kepler.jd.sdk.bean.KelperTask;
import com.kepler.jd.sdk.bean.KeplerAttachParameter;
import com.kepler.jd.sdk.bean.KeplerGlobalParameter;
import com.kepler.jd.sdk.exception.KeplerBufferOverflowException;
import com.kepler.jd.sdk.exception.KeplerAttachException;

import org.json.JSONException;

import java.util.Map;

/**
 * 
 * @Author karedem
 * @Date 2019/9/7 19:55
 * @Description 接口处理者
**/
public class FlutterKeplerHandle {

    private static FlutterKeplerHandle handle;
    private Registrar register;
    private Handler mHandler = new Handler();
    private KelperTask mKelperTask = null;
    /**
     * 加载对话框
     */
    private LoadingDialog dialog;

    private OpenAppAction mOpenAppAction = new OpenAppAction() {
        @Override
        public void onStatus(final int status) {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    if (status == OpenAppAction.OpenAppAction_start) {//开始状态未必一定执行，
                        //dialogShow();
                    } else {
                        mKelperTask=null;
                        //dialogDiss();
                    }
                }
            });
        }
    };

    /**
     * 显示加载对话框
     */
    private void dialogShow() {
        if (dialog == null) {
            dialog = new LoadingDialog(register.activity());
//            dialog.setCanceledOnTouchOutside(false);
            dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
                @Override
                public void onCancel(DialogInterface dialog) {
                    if (mKelperTask != null) {//取消
                        mKelperTask.setCancel(true);
                    }
                }
            });
        }
        dialog.show();
    }

    private void dialogDiss() {
        if (dialog != null) {
            dialog.dismiss();
        }
    }

    //第一次调用getInstance register不能为空
    public static FlutterKeplerHandle getInstance(Registrar register){
        if (handle == null){
            synchronized (FlutterKeplerHandle.class){
                handle = new FlutterKeplerHandle();
                handle.register = register;
            }
        }
        return handle;
    }

    /**
     * 将map参数构造为 KeplerAttachParameter 对象
     * @param map
     * @return
     */
    private KeplerAttachParameter getAttachParameter(Map<String, Object> info) throws JSONException, KeplerAttachException, KeplerBufferOverflowException{
        if (info == null){
            info = new HashMap<>();
        }
        KeplerAttachParameter customerInfo = new KeplerAttachParameter();

        for (String key:info.keySet()){
            if ("customerInfo".equalsIgnoreCase(key)){
                customerInfo.setCustomerInfo(String.valueOf(info.get(key)));
            }else if ("positionId".equalsIgnoreCase(key)){
                try {
                    customerInfo.setPositionId((Integer)info.get(key));
                }
                catch (Exception e){}
            }else {
                customerInfo.putKeplerAttachParameter(key,String.valueOf(info.get(key)));
            }
        }
        return customerInfo;
    }

    /**
     * 初始化开普勒
     * @param call
     * @param result
     */
    public void initKepler(MethodCall call, Result result){
        String appKey = call.argument("appKey");
        String appSecret = call.argument("appSecret");
        KeplerApiManager.asyncInitSdk(register.activity().getApplication(), appKey, appSecret, new AsyncInitListener() {
            @Override
            public void onSuccess() {
                result.success(PluginResponse.success(null).toMap());
            }

            @Override
            public void onFailure() {
                String errorCode = "-1";
                String errorMsg = "初始化失败";
                result.success(new PluginResponse(errorCode, errorMsg, null).toMap());
            }
        });
    }

    /**
     * 授权登陆
     * @param result
     */
    public void keplerLogin(Result result){
        KeplerApiManager.getWebViewService().login(register.activity(), new LoginListener() {
            @Override
            public void authSuccess() {
                result.success(PluginResponse.success(null).toMap());
            }

            @Override
            public void authFailed(int errorCode) {
                result.success(authError(errorCode).toMap());
            }
        });
    }

    public void keplerIsLogin(MethodCall call, Result result){
        KeplerApiManager.getWebViewService().checkLoginState(new ActionCallBck() {
            @Override
            public boolean onDateCall(int key, String info) {
                Map<String, Object> res = new HashMap<>();
                res.put("key", key);
                res.put("info", info);
                result.success(PluginResponse.success(res).toMap());
                return false;
            }

            @Override
            public boolean onErrCall(int key, String error) {
                result.success(new PluginResponse(String.valueOf(key), error, null).toMap());
                return false;
            }
        });
    }

    /**
     * 清除授权登陆
     * @param result
     */
    public void keplerCancelAuth(MethodCall call, Result result){
        KeplerApiManager.getWebViewService().cancelAuth(register.activity());
    }

    /**
     * 通过URL方式打开
     * @param call
     * @param result
     */
    public void openJDUrlPage(MethodCall call, Result result){
        String url = call.argument("url");
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openJDUrlPage(url, customerInfo,register.activity(), mOpenAppAction,TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 打开导航页
     */
    public void keplerNavigationPage(MethodCall call, Result result){
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openNavigationPage(customerInfo,register.activity(), mOpenAppAction,TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 通过SKU 打开商品详情
     */
    public void keplerOpenItemDetail(MethodCall call, Result result){
        String sku = call.argument("sku");
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openItemDetailsPage(sku, customerInfo,register.activity(), mOpenAppAction,TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 打开dingdan列表
     */
    public void keplerOpenOrderList(MethodCall call, Result result){
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openNavigationPage(customerInfo,register.activity(), mOpenAppAction,TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 打开search结果
     * @param call
     * @param result
     */
    public void keplerOpenSearchResult(MethodCall call, Result result){
        String searchKey = call.argument("searchKey");
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openSearchPage(
                    searchKey, customerInfo, register.activity(), mOpenAppAction, TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 打开购物车
     * @param result
     */
    public void keplerOpenShoppingCart(MethodCall call, Result result){
        Map<String, Object> info = (Map)call.argument("userInfo");
        try {
            KeplerAttachParameter customerInfo = getAttachParameter(info);
            mKelperTask= KeplerApiManager.getWebViewService().openCartPage(
                    customerInfo, register.activity(), mOpenAppAction, TIMEOUT);
        } catch (KeplerBufferOverflowException | KeplerAttachException | JSONException e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 加入shoppingCart
     * @param result
     */
    public void keplerAddToCartWithSku(MethodCall call, Result result){
        String sku = call.argument("sku");
        String[] skus = new String[]{sku};
        String num = call.argument("num");
        int[] numbers = new int[]{Integer.parseInt(num)};
        try {
            KeplerApiManager.getWebViewService().add2Cart(register.activity(), skus, numbers, new ActionCallBck() {
                @Override
                public boolean onDateCall(int key, String info) {
                    Map<String, Object> res = new HashMap<>();
                    res.put("key", key);
                    res.put("info", info);
                    result.success(PluginResponse.success(res).toMap());
                    return false;
                }
                @Override public boolean onErrCall(int key, final String error) {
                    PluginResponse response = PluginUtil.addCartError(key, error);
                    result.success(response.toMap());
                    return true;
                }
            });
        } catch (Exception e) {
            result.success(PluginResponse.failed(e).toMap());
        }
    }

    /**
     * 一键加入购物车
     * @param call   call.argument["unionID"]  联盟ID，必须传入真实的联盟ID；
     *               call.argument["appId"]  APPID（查看位置：联盟后台-我的推广-推广管理-APP管理）；
     *               call.argument["skuID"]  加车商品的skuId ；
     *               call.argument["refer"]  H5文章页面传url，原生页面传域名+文章编号 ；
     * @param result
     */
    public void keplerFastPurchase(MethodCall call, Result result){
        String unionID = call.argument("unionID");
        String appId = call.argument("appId");
        String skuID = call.argument("skuID");
        String refer = call.argument("refer");

        KeplerApiManager.getWebViewService().addToCart(register.activity(),
                unionID,
                appId,
                skuID,
                refer, new ActionCallBck() {
                    @Override
                    public boolean onDateCall(int key, final String info) {
                        Map<String, Object> res = new HashMap<>();
                        res.put("key", key);
                        res.put("info", info);
                        result.success(PluginResponse.success(res).toMap());
                        return false;
                    }

                    @Override
                    public boolean onErrCall(final int key, final String error) {
                        PluginResponse response = PluginUtil.addCartError(key, error);
                        result.success(response.toMap());
                        return false;
                    }
                });
    }

    //原生SDK Android未实现此接口
    public void keplerCheckUpdate(MethodCall call, Result result){
        //nothing to do
    }

    //原生SDK Android未实现此接口
    public void setKeplerProgressBarColor(MethodCall call, Result result){
        //nothing to do
    }

    /**
     * 是否强制使用H5打开界面 默认为YES;设置为NO时,调用商品详情页,订单列表,购物车等方法时将跳转到京东app并打开对应的界面.
     * @param call
     * @param result
     */
    public void setKeplerOpenByH5(MethodCall call, Result result){
        boolean isOpenByH5 = call.argument("isOpenByH5");
        KeplerGlobalParameter.getSingleton().setIsOpenByH5Mode(isOpenByH5);
    }

    /**
     * 打开京东后显示的返回按钮的tagID
     * @param call
     * @param result
     */
    public void setKeplerJDappBackTagID(MethodCall call, Result result){
        String JDappBackTagID = call.argument("JDappBackTagID");
        KeplerGlobalParameter.getSingleton().setJDappBackTagID(JDappBackTagID);
    }

}