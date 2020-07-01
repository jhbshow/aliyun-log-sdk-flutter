

class LogResponseModel{
  LogResponseModel(this.errorCode,this.errorMessage){

  }

  /**
   * 错误码
   */
  String errorCode = '';

  /**
   * 错误信息
   */
  String errorMessage = "";

  Map convertToMap(){
    return {
      'errorCode':errorCode,
      'errorMessage':errorMessage
    };
  }


}