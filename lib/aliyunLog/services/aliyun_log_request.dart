import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import '../model/log_request_result_model.dart';
import '../utils/log_request_message.dart';
import '../utils/log_request_result.dart';
import '../utils/log_request_params.dart';
import '../config/log_url_path.dart';

class AliyunLogRequest {

  /**
   * get请求
   */
  static Future<String> get(String apiName,
      {Map<String, String> params}) async {

    var url = servicePath[apiName];
    if (params != null && params.isNotEmpty) {
      // 如果参数不为空，则将参数拼接到URL后面
      StringBuffer sb = StringBuffer("?");
    
      List keySortArray = LogRequestParams.sortParams(params.keys);
      for(String key in keySortArray){
        sb.write("$key" + "=" + "${params[key]}" + "&");
      }

      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res = await http.get(url, headers: LogRequestParams.getCommonHeader(AliyunLogHttpMethod.Get,url,[]));
    return res.body;
  }

  /**
   *  post请求
   */
  static Future<LogRequestResultModel> post(LogRequestMessage logRequestMessage) async {
    List<int> postBodyByteList = LogRequestParams.getPutLogBody(logRequestMessage);

    var url = servicePath[logRequestMessage.apiName];

    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

    Map headers = LogRequestParams.getCommonHeader(AliyunLogHttpMethod.Post,url,postBodyByteList);
    for(String key in headers.keys){
      request.headers.set(key,headers[key]);
    }
    request.add(postBodyByteList);
    HttpClientResponse clientResponse = await request.close();

    LogRequestResultModel resultMap = await LogRequestResult.logRequest(clientResponse);

    return resultMap;
  }


}


