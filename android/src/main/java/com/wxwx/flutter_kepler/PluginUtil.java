package com.wxwx.flutter_kepler;

import static com.wxwx.flutter_kepler.PluginConstants.*;
import com.kepler.jd.login.KeplerApiManager;
import java.util.Map;

/**
 * @Author karedem
 * @Date 2019/9/10 11:42
 * @Description 映射返回对应值
**/
public class PluginUtil {


    //根据授权登陆错误码返回对应结果
    public static PluginResponse authError(int errorCode){
        switch (errorCode) {
            case KeplerApiManager.KeplerApiManagerLoginErr_Init:// 初始化失败
                return new PluginResponse(String.valueOf(errorCode), "初始化失败", null);
            case KeplerApiManager.KeplerApiManagerLoginErr_InitIng:// 初始化没有完成
                return new PluginResponse(String.valueOf(errorCode), "初始化没有完成", null);
            case KeplerApiManager.KeplerApiManagerLoginErr_openH5authPageURLSettingNull://跳转url // 为null break;
                return new PluginResponse(String.valueOf(errorCode),"跳转url为null", null);
            case KeplerApiManager.KeplerApiManagerLoginErr_getTokenErr:// 获取失败(oath授权之后，获取cookie过程出错) break;
                return new PluginResponse(String.valueOf(errorCode),"获取cookie过程出错", null);
            case KeplerApiManager.KeplerApiManagerLoginErr_User_Cancel:// 用户取消 break;
                return new PluginResponse(String.valueOf(errorCode),"用户取消", null);
            case KeplerApiManager.KeplerApiManagerLoginErr_AuthErr_ActivityOpen://打开授权页面失败 break;
                return new PluginResponse(String.valueOf(errorCode),"打开授权页面失败", null);
            default:
                return new PluginResponse(String.valueOf(errorCode),"未定义的失败原因", null);
        }
    }

    //根据打开购物车错误码返回对应结果
    public static PluginResponse addCartError(int key, String error){
        switch (key) {
            case KeplerApiManager.KeplerApiManagerActionErr:
            case KeplerApiManager.KeplerApiManagerActionServerErr:
                // 操作失败 break;
            case KeplerApiManager.KeplerApiManagerActionErr_CartFullErr:
                // 购物车上限 break;
            case KeplerApiManager.KeplerApiManagerActionErr_DataErr:
            case KeplerApiManager.KeplerApiManagerActionErr_ParameterErr:
            case KeplerApiManager.KeplerApiManagerActionErr_ParserErr:
            case KeplerApiManager.KeplerApiManagerActionErr_TokenLast:
            case KeplerApiManager.NetLinker_Err_Not_200: // 服务端出错 break;
            case KeplerApiManager.KeplerApiManagerActionErr_AppKeyNotExist:// app_key不存在
            case KeplerApiManager.KeplerApiManagerActionErr_AppKeyErr:// 无效app_key
            case KeplerApiManager.KeplerApiManagerActionErr_AppKeyLast://缺少app_key参数 break;
            case KeplerApiManager.KeplerApiManagerActionErr_TokenNotExist:
            case KeplerApiManager.KeplerApiManagerActionErr_UNLogin:
            case KeplerApiManager.KeplerApiManagerActionErr_TokenTimeOutTErr:
                // KeplerApiManager.getWebViewService().login( // StartActivityForSDK.this, // mLoginListener); break;
            case KeplerApiManager.NetLinker_Err_NoNetwork: // 没有网络 break;
            case KeplerApiManager.NetLinker_Err_UnsupportedEncodingException:
            case KeplerApiManager.NetLinker_Err_IOException:
            case KeplerApiManager.NetLinker_Err_ClientProtocolException:
            case KeplerApiManager.NetLinker_Err_NetException: // 网络访问出错 break;
            case KeplerApiManager.KeplerApiManagerAdd2CartErr_NoLogin:
                //调用加车接口失败，失败原因：未登录状态
                break;
            default: break;
        }
        //这里有error 暂时不用switch判断
        return new PluginResponse(String.valueOf(key), error, null);
    }
}
