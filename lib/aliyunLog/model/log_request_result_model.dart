

import '../model/log_response_model.dart';

class LogRequestResultModel{
  /**
   * 请求code
   */
  int statusCode = 0;

  /**
   * 阿里请求id
   */
  String logRequestId = '';

  /**
   * 响应模型
   */
  LogResponseModel logResponseModel = new LogResponseModel('', '');

  /**
   * 转换成
   */
  Map convertResultMap(){
    return {
      'statusCode':statusCode,
      'logRequestId':logRequestId,
      'response':logResponseModel.convertToMap()
    };
  }

  /**
   * 是否上传成功
   */
  bool isPostSuccess(){
    return statusCode == 200;
  }

}


