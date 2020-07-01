
import '../model/log_group_model.dart';

import './log_request_params.dart';

class LogRequestMessage{

  /**
   * 构造方法
   */
  LogRequestMessage(this.apiName,this.httpMethod);

  /**
   * api名字
   */
  String apiName = '';

  /**
   * 请求方式
   */
  AliyunLogHttpMethod httpMethod = AliyunLogHttpMethod.None;

  /**
   * 请求参数
   */
  LogGroupModel logGroupModel = new LogGroupModel();



}

