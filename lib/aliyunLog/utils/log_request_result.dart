
import 'dart:convert' as convert;
import 'dart:io';

import '../model/log_request_result_model.dart';
import '../model/log_response_model.dart';
import '../config/log_key.dart';

class LogRequestResult{

  /**
   * 处理上传请求结果
   */
  static Future<LogRequestResultModel> logRequest(HttpClientResponse clientResponse) async {
    String logRequestId = clientResponse.headers.value("x-log-requestid");
    int statusCode = clientResponse.statusCode;
    LogRequestResultModel logResponseResultModel = new LogRequestResultModel();

    logResponseResultModel.statusCode = statusCode;
    logResponseResultModel.logRequestId = logRequestId;
    try{
      String responseText = await clientResponse.transform(convert.Utf8Decoder()).join();
      String statusCode = '';
      String errorMessage = "";
      if(responseText.isNotEmpty){
        Map response = convert.jsonDecode(responseText);
        statusCode = response[responseStatusCodeKey];
        errorMessage = response[errorMessageKey];
      }
      LogResponseModel logResponseModel = LogResponseModel(statusCode,errorMessage);

      logResponseResultModel.logResponseModel = logResponseModel;
    }catch(error){
      print('请求结果数据解析出错');
    }
    return logResponseResultModel;
  }

  /**
   * 请求结果
   */
  static Map requestResult({int statusCode,String logRequestId,String errorCode, String errorMessage}){
    LogRequestResultModel logRequestResultModel = new LogRequestResultModel();

    logRequestResultModel.statusCode = statusCode != null ? statusCode : '';
    logRequestResultModel.logRequestId = logRequestId != null ? logRequestId : '';

    logRequestResultModel.logResponseModel.errorCode = errorCode != null ? errorCode : '';
    logRequestResultModel.logResponseModel.errorMessage = errorMessage != null ? errorMessage : '';

    return logRequestResultModel.convertResultMap();
  }
 
}