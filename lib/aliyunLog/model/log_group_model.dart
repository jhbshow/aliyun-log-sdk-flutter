import 'dart:convert' as convert;
import '../config/log_key.dart';
import 'log_model.dart';
import '../utils/log_request_params.dart';

class LogGroupModel {
  /**
   * 日志话题
   */
  String logTopic = '';

  /**
   * 日志来源
   */
  String logSource = '';

  /**
   * 日志内容列表
   */
  List<LogModel> logList = new List<LogModel>();

  /**
   * 日志tag列表
   */
  Map<String, dynamic> logTagMap = new Map();

  /**
   * id,主要用于数据库
   */
  int id;

  /**
   * 是否需要保存
   */
  bool isNeedSave = true;

  /**
   * 上传次数
   */
  int postCount = 0;

  /**
   * 构造方法
   */
  LogGroupModel(
      {this.logTopic, this.logSource, List<Map> logList, this.logTagMap}) {
    if (logList != null) {
      this.configLogList(logList);
    }
  }

  void configLogList(List<Map> logList) {
    for (Map mapParams in logList) {
      LogModel logModel = new LogModel();
      logModel.logContentMap = mapParams;
      this.logList.add(logModel);
    }
  }

  /**
   * 获取日志
   */
  static Map<String, dynamic> configLogGroupModel(Map putLogParams) {
    LogGroupModel logGroupModel = new LogGroupModel(logList: []);
    if (putLogParams.containsKey(logTopicKey)) {
      String topic = putLogParams[logTopicKey];
      if (!(topic is String)) {
        return {'error': LogRequestParams.paramsKeyErrorResult(logTopicKey)};
      } else {
        logGroupModel.logTopic = topic;
      }
    }
    if (putLogParams.containsKey(logSourceKey)) {
      String source = putLogParams[logSourceKey];
      if (!(source is String)) {
        return {'error': LogRequestParams.paramsKeyErrorResult(logSourceKey)};
      } else {
        logGroupModel.logSource = source;
      }
    }

    if (putLogParams.containsKey(logContentskey)) {
      var logContents = putLogParams[logContentskey];
      if (!(logContents is List<Map>)) {
        return {'error': LogRequestParams.paramsKeyErrorResult(logContentskey)};
      } else {
        logGroupModel.configLogList(logContents);
      }
    }

    if (putLogParams.containsKey(logTagContentsKey)) {
      var logTagMap = putLogParams[logTagContentsKey];
      if (!(logTagMap is Map<String, dynamic>)) {
        return {
          'error': LogRequestParams.paramsKeyErrorResult(logTagContentsKey)
        };
      } else {
        logGroupModel.logTagMap = logTagMap;
      }
    }
    return {'data': logGroupModel};
  }

  /**
   * 转换成map
   */
  Map<String, dynamic> toMap() {
    List<String> logContentsList = [];
    logList.forEach((item) {
      logContentsList.add(convert.jsonEncode(item.toMap()));
    });

    var map = <String, dynamic>{
      logTopicKey: logTopic,
      logSourceKey: logSource,
      logContentskey: convert.jsonEncode(logContentsList),
      logTagContentsKey: convert.jsonEncode(logTagMap)
    };
    return map;
  }

  /**
   * 从map转换数据
   */
  void fromMap(Map mapParams) {
    id = mapParams['id'];
    logTopic = mapParams[logTopicKey];
    logSource = mapParams[logSourceKey];
    String logContentsString = mapParams[logContentskey];
    String logTagMapString = mapParams[logTagContentsKey];

    logList = [];

    List<dynamic> logContents = convert.jsonDecode(logContentsString);
    for (int i = 0; i < logContents.length; i++) {
      String logString = logContents[i];
      Map logMap = convert.jsonDecode(logString);
      LogModel logModel = LogModel();
      logModel.fromMap(logMap);
      logList.add(logModel);
    }

    logTagMap = convert.jsonDecode(logTagMapString);

    print("ddfddf");
  }
}
