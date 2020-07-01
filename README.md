# 阿里云日志上传


# Flutter 接入
 
 # Usage:
 
 ### 配置参数
 ``` 
 AliyunLogConfig config = AliyunLogConfig();
 String regionEndpoint = "cn-shenzhen.log.aliyuncs.com";
 String logStoreName = "jhb-logstore-test";
 String projectName = "jhb-log-test";
 String accessKeySecret = "CYFJz**********2i0P";
 String accessKeyId = "LTAI4F*********oipRi";
 config.startConfig(regionEndpoint, projectName, logStoreName, accessKeySecret, accessKeyId);
 ``` 
### 上传日志
``` 
  var logList = [
    {'url': 'test/url', 'error': "接口异常", 'erroCode': 400},
    {'url': 'test/url', 'error': "数据处理异常"}
  ];
  LogGroupModel logGroupModel = LogGroupModel(
      logTopic: 'jhb-test-log-topic',
      logSource: 'jhb-test-log-source',
      logList: logList);

  AliyunLogManager.putLog(logGroupModel).then((result) {
    if(result.isPostSuccess()){
      //上传成功
    }
  });
 
```     
### 保存日志
```
var logList = [
    {'url': 'test/url', 'time': "20200610", 'num': 1},
    {'url': 'test/url', 'time': "20200610", 'num': 2}
  ];
  LogGroupModel logGroupModel = LogGroupModel(
      logTopic: 'jhb-test-log-topic',
      logSource: 'jhb-test-log-source',
      logList: logList);

  AliyunLogManager.insertLog(logGroupModel).then((result){
    if(result.id != null){
      print("保存成功");
    }else{
      print("保存失败");
    }
  });

```

### 上传持久化的日志
```
//一般在wifi情况下进行上传持久化日志
AliyunLogManager.startPostSqfliteLog();
```
