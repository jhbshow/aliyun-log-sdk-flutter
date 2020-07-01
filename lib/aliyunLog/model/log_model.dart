import 'dart:convert' as convert;
import '../config/log_key.dart';

class LogModel{

  /**
   * 日志时间，默认当前时间
   */
  int time = (DateTime.now().millisecondsSinceEpoch~/1000);

  /**
   * 日志内容
   */
  Map logContentMap = new Map();


  /**
   * 转换成map
   */
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      logTimeKey: time,
      "logContentMap":convert.jsonEncode(logContentMap)
    };
    return map;
  }

  /**
   * 从map转换数据
   */
  void fromMap(Map logMap){
    int logTime =  logMap['time'];
    String logContentString = logMap["logContentMap"];

    if(logTime != null && logTime != 0){
      time = logMap[logTimeKey];
    }
    logContentMap = convert.jsonDecode(logContentString);
  }
}
