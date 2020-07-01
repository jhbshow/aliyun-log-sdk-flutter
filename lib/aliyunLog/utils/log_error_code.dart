import '../model/log_response_model.dart';

class LogErrorCode{
  /**
   * 客户端参数错误
   */
  static LogResponseModel clientParamsError(String errorMessage){
    LogResponseModel logResponseModel = new LogResponseModel('clientParamsError', errorMessage);
    return logResponseModel;
  }
}