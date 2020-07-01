
import '../model/log_request_result_model.dart';
import '../sqflite/log_sqflite_manager.dart';

import '../model/log_group_model.dart';
import '../services/aliyun_log_request.dart';
import '../utils/log_request_message.dart';
import '../utils/log_request_params.dart';

class AliyunLogManager{


  /**
   * 上传日志
   */
  static Future<LogRequestResultModel> putLog(LogGroupModel logGroupModel) async{
    if(logGroupModel.isNeedSave){
      //需要先保存再上传,防止上传图中退出app，丢失日志
      AliyunLogManager.insertLog(logGroupModel).then((model){
        model.isNeedSave = false;
        return putLog(model);
      });
    }else{
      logGroupModel.postCount = logGroupModel.postCount + 1;
      LogRequestMessage logRequestMessage = new LogRequestMessage('aliyunPutLog',AliyunLogHttpMethod.Post);
      logRequestMessage.logGroupModel = logGroupModel;
      int logId = logGroupModel.id;

      AliyunLogRequest.post(logRequestMessage).then((result){
        if(result.statusCode == 200){
          if(logId != null && logId > 0){
            deleteLog(logId).then((result){
            });
          }
          return result;
        }else{
          //上传失败
          if(logGroupModel.postCount <= 3){
            return putLog(logGroupModel);
          }
          return result;
        }
      });
    }
  }


  /**
   * 插入日志数据
   */
  static Future<LogGroupModel> insertLog(LogGroupModel logGroupModel) async{
    return LogSqfliteManager.insert(logGroupModel);
  }

  /**
   * 删除日志
   */
  static Future<bool> deleteLog(int logId) async{
    int deleteCount = 1;
    LogSqfliteManager.deleteLog(logId).then((result){
      if(!result && deleteCount <= 3){
        deleteCount++;
       return LogSqfliteManager.deleteLog(logId);
      }else{
        return result;
      }
    });
  }
  /**
   * 开始上传本地日志
   */
  static void startPostSqfliteLog(){
    LogSqfliteManager.queryLogs().then((logList){
      logList.forEach((item){
        item.isNeedSave = false;
        AliyunLogManager.putLog(item).then((result){

        });
      });
    });
  }



}