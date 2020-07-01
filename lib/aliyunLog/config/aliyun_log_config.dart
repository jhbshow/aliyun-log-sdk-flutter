
class AliyunLogConfig{

  /**
   * 配置参数
   */
  static Map configParmas = new Map();

  /**
   * 配置生效
   */
  void startConfig(String regionEndpoint,String projectName,String logstoreName,String accessKeySecret,String accessKeyId){
    if(regionEndpoint.isEmpty || projectName.isEmpty || logstoreName.isEmpty || accessKeySecret.isEmpty || accessKeyId.isEmpty){
      print("日志配置参数不能为空");//一般调试用
    }
    configParmas["regionEndpoint"] = regionEndpoint;
    configParmas["projectName"] = projectName;
    configParmas["logstoreName"] = logstoreName;
    configParmas["accessKeySecret"] = accessKeySecret;
    configParmas["accessKeyId"] = accessKeyId;
  }


  /**
   * 日志库区域endpoint
   */
  static String get regionEndpoint{
    return configParmas['regionEndpoint'];
  }

  /**
   * 项目名字
   */
  static String get  projectName{
    return configParmas['projectName'];
  }

  /**
   * 日志库名字
   */
  static String get logstoreName{
    return configParmas['logstoreName'];
  }

  /**
   * secret
   */
  static String get accessKeySecret{
    return configParmas['accessKeySecret'];
  }

  /**
   * key
   */
  static String get accessKeyId{
    return configParmas['accessKeyId'];
  }


  /**
   * host
   */
  static String get host{
    return "$projectName.$regionEndpoint";
  }

  /**
   * url
   */
  static String get  baseUrl{
    return "https://$host";
  }



}

