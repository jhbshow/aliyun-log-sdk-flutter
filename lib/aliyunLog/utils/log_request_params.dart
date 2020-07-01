
import 'dart:convert';

import 'package:crypto/crypto.dart';
import '../model/log_model.dart';
import '../model/log_response_model.dart';
import '../pb/log.pb.dart';
import '../utils/log_request_message.dart';
import '../config/aliyun_log_config.dart';

enum AliyunLogHttpMethod{
  None,
  Get,
  Post
}



class LogRequestParams{
  /**
   * 封装http请求header
   */
  static Map getCommonHeader(AliyunLogHttpMethod method,String url,List postBodyByteList) {
    Map  header = Map();
    header["Accept"] = "application/json";
    header["x-log-apiversion"] = "0.6.0";
    header["x-log-signaturemethod"] = "hmac-sha1";
    String dateString = getCurrentDateGMTString();
//    header["x-log-date"] = dateString;
    header["Date"] = dateString;
    header["Host"] = AliyunLogConfig.host;

    var httpMethod = "";
    var contentMd5string = "";

    // application/json   application/x-protobuf
    var contentType = 'application/x-protobuf';

    contentType = method == AliyunLogHttpMethod.Get ? '' : contentType;
    switch (method){
      case AliyunLogHttpMethod.Get:
        httpMethod = "GET";
        break;
      case AliyunLogHttpMethod.Post:
        httpMethod = "POST";
        contentMd5string = bodyMd5String(postBodyByteList);
        header["Content-MD5"] = contentMd5string;

        header["Content-Length"] = postBodyByteList.length;

        header["Content-Type"] = contentType;
        //请求的 Body 原始大小。当无 Body 时，该字段为 0；当 Body 是压缩数据，则为压缩前的原始数据大小。该域取值范围为 0~3x1024x1024。该字段为非必选字段，只在压缩时需要。
        header["x-log-bodyrawsize"] = postBodyByteList.length;


//        header["x-log-compresstype"] = 'lz4';
        break;
      default:
        break;
    }
    String accessKeyId = AliyunLogConfig.accessKeyId;

    String signString = getSignString(httpMethod, contentMd5string, contentType,dateString,header,url);

    header['Authorization'] = "LOG ${accessKeyId}:${signString}";
    return header;
  }

  /**
   * body生成md5
   */
  static bodyMd5String(List postBodyByteList){
    var md5String = md5.convert(postBodyByteList).toString();
    md5String = md5String.toUpperCase();
    return md5String;
  }


  /**
   * 获取签名字符串
   *
   *VERB:HTTP 请求的方法名称	PUT、GET、POST 等
   *CONTENT-MD5	HTTP 请求中 Body 部分的 MD5 值（必须为大写字符串）	875264590688CA6171F6228AF5BBB3D2
   *CONTENT-TYPE	HTTP 请求中 Body 部分的类型	application/x-protobuf
   *DATE	HTTP 请求中的标准时间戳头（遵循 RFC 1123 格式，使用 GMT 标准时间）	Mon, 3 Jan 2010 08:33:47 GMT
   *CanonicalizedLOGHeaders	由 HTTP 请求中以 x-log 和 x-acs 为前缀的自定义头构造的字符串（具体构造方法见下面详述）	x-log-apiversion:0.6.0\nx-log-bodyrawsize:50\nx-log-signaturemethod:hmac-sha1
   *CanonicalizedResource	由 HTTP 请求资源构造的字符串（具体构造方法见下面详述）	/logstores/app_log
   */
  static getSignString(String verb,
      String contentMd5,
      String contentType,
      String dateString,
      Map headers,
      String url){

    String canonicalizedLogHeaders = getCanonicalizedLogHeaders(headers);
    String canonicalizedResource = getCanonicalizedResource(url);

    String signString = "";
    signString = verb + "\n"
        + contentMd5 + "\n"
        + contentType + "\n"
        + dateString + "\n"
        + canonicalizedLogHeaders + "\n"
        + canonicalizedResource;

    String aliyunSecret = AliyunLogConfig.accessKeySecret;

    var hmac = Hmac(sha1, aliyunSecret.codeUnits);

    var baseString = base64Encode(hmac.convert(signString.codeUnits).bytes);

    return baseString;
  }

  /**
   * 以 x-log 和 x-acs 为前缀的自定义头构造的字符串
   */
  static getCanonicalizedLogHeaders(Map headers){
    List needKyes = sortParams(headers.keys);

    String finalString = "";
    for(String key in needKyes){
      if(key.startsWith('x-log') || key.startsWith("x-acs")){
        var value = headers[key];
        if(value is int){
          value = value.toString();
        }

        finalString = "${finalString + key + ':' + value + '\n'}";
      }
    }
    if(finalString.length > 2){
      finalString = finalString.substring(0,finalString.length-1);
    }
    return finalString;
  }

  /**
   * 获取CanonicalizedResource
   */
  static getCanonicalizedResource(String url){
    String subString = url.substring(AliyunLogConfig.baseUrl.length,url.length);
    return subString;
  }

  /**
   * 获取当前的GMT时间
   */
  static getCurrentDateGMTString(){
    DateTime dateTime = DateTime.now().toUtc();
    return "${weekdayToEnglishString(dateTime.weekday)}, ${dateTime.day} ${monthToEnglishString(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second} GMT";
  }

  /**
   * 星期转换到英文字符串
   */
  static weekdayToEnglishString(weekday){
    switch(weekday){
      case 1:
        return 'Mon';
        break;
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  /**
   * 月份转换成英文缩写
   */
  static monthToEnglishString(month){
    switch(month){
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  /**
   * 参数按照字典升序排序
   */
  static sortParams(Iterable<dynamic> keys){
    List newKyes = keys.toList();
    newKyes.sort((a,b){
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    return newKyes;
  }


  /**
   * 参数key错误结果
   */
  static LogResponseModel paramsKeyErrorResult(String key){
    LogResponseModel logResponseModel = LogResponseModel('putLogParamsError','$key\ param is error');
    return logResponseModel;
  }

  /**
   * 获取上传日志body
   */
  static  List<int>  getPutLogBody(LogRequestMessage logRequestMessage){
    LogGroup logGroup = LogGroup();

    if(logRequestMessage.logGroupModel.logTopic.isNotEmpty){
      logGroup.topic = logRequestMessage.logGroupModel.logTopic;
    }
    if(logRequestMessage.logGroupModel.logSource.isNotEmpty){
      logGroup.topic = logRequestMessage.logGroupModel.logSource;
    }

    if(logRequestMessage.logGroupModel.logList is List<LogModel>){
      for(LogModel logModel  in logRequestMessage.logGroupModel.logList){
        Log logPbModel = Log();
        logPbModel.time = logModel.time;
        logModel.logContentMap.forEach((key,value){
          var logContent = Log_Content();
          logContent.key = key;
          String newValue = "";
          if(value is String){
            newValue = value;
          }else{
            newValue = "$value";
          }
          logContent.value = newValue;
          logPbModel.contents.add(logContent);
        });
        logGroup.logs.add(logPbModel);
      }
    }

    if(logRequestMessage.logGroupModel.logTagMap is Map){
      logRequestMessage.logGroupModel.logTagMap.forEach((key,value){
        LogTag logTag = new LogTag();
        logTag.key = key;
        logTag.value = value;
        logGroup.logTags.add(logTag);
      });
    }

    List<int> postBodyByteList = logGroup.writeToBuffer();
    return postBodyByteList;
  }

}