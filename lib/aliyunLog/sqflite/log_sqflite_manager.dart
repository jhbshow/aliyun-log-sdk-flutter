


import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../config/log_key.dart';
import '../model/log_group_model.dart';

class LogSqfliteManager{

  static Database _db;

  static String sqlString = 'CREATE TABLE aliyun_log_group_table (id INTEGER PRIMARY KEY, '+ logTopicKey +' TEXT,'+ logSourceKey +' TEXT,' + logContentskey +' TEXT,' + logTagContentsKey +' TEXT)';

  static String tableName = 'aliyun_log_group_table';
  
  static Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  /**
   * 初始化数据库
   */
  static initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'aliyun-log-database.db');
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  /**
   * 创建数据库
   */
  static _onCreate(Database db,int version) async{
    await db.execute(sqlString);
  }

  /**
   * 插入数据
   */
  static Future<LogGroupModel> insert(LogGroupModel logGroupModel) async{
    var dbClient = await db;
    logGroupModel.id = await dbClient.insert(tableName, logGroupModel.toMap());
    return logGroupModel;
  }

  /**
   * 查询日志
   */
  static Future<List<LogGroupModel>> queryLogs() async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableName,columns: [logTopicKey,logSourceKey,logContentskey,logTagContentsKey,'id']);
    List<LogGroupModel> logGroupModelList = [];
    for(int i = 0;i < maps.length; i++){
        Map mapParams = maps[i];
        LogGroupModel model = LogGroupModel();
        model.fromMap(mapParams);
        logGroupModelList.add(model);
    }
    return logGroupModelList;
  }

  /**
   * 删除日志
   */
  static Future<bool> deleteLog(int logId) async{
    var dbClient = await db;
    var result = await dbClient.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [logId],
    );
    return result == 1;
  }




}