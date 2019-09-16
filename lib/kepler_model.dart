/*
 * @Description: model
 * @Author: wuxing
 * @Date: 2019-09-12 23:19:08
 * @LastEditors: wuxing
 * @LastEditTime: 2019-09-12 23:19:38
 */

class ResultModel {
  // 错误码
  final String errorCode;
  // 错误信息
  final String errorMessage;

  ResultModel(this.errorCode, this.errorMessage);

  @override
  String toString() {
    return "{ \"errorCode\" : " +
        errorCode +
        " ; \" errorMessage \" : " +
        errorMessage +
        " }";
  }
}
