///
//  Generated code. Do not modify.
//  source: log.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Log_Content extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Log.Content', createEmptyInstance: create)
    ..aQS(1, '', protoName: 'Key')
    ..aQS(2, '', protoName: 'Value')
  ;

  Log_Content._() : super();
  factory Log_Content() => create();
  factory Log_Content.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Log_Content.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Log_Content clone() => Log_Content()..mergeFromMessage(this);
  Log_Content copyWith(void Function(Log_Content) updates) => super.copyWith((message) => updates(message as Log_Content));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Log_Content create() => Log_Content._();
  Log_Content createEmptyInstance() => create();
  static $pb.PbList<Log_Content> createRepeated() => $pb.PbList<Log_Content>();
  @$core.pragma('dart2js:noInline')
  static Log_Content getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Log_Content>(create);
  static Log_Content _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class Log extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Log', createEmptyInstance: create)
    ..a<$core.int>(1, '', $pb.PbFieldType.QU3, protoName: 'Time')
    ..pc<Log_Content>(2, '', $pb.PbFieldType.PM, protoName: 'Contents', subBuilder: Log_Content.create)
  ;

  Log._() : super();
  factory Log() => create();
  factory Log.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Log.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Log clone() => Log()..mergeFromMessage(this);
  Log copyWith(void Function(Log) updates) => super.copyWith((message) => updates(message as Log));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Log create() => Log._();
  Log createEmptyInstance() => create();
  static $pb.PbList<Log> createRepeated() => $pb.PbList<Log>();
  @$core.pragma('dart2js:noInline')
  static Log getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Log>(create);
  static Log _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get time => $_getIZ(0);
  @$pb.TagNumber(1)
  set time($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Log_Content> get contents => $_getList(1);
}

class LogTag extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogTag', createEmptyInstance: create)
    ..aQS(1, '', protoName: 'Key')
    ..aQS(2, '', protoName: 'Value')
  ;

  LogTag._() : super();
  factory LogTag() => create();
  factory LogTag.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogTag.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LogTag clone() => LogTag()..mergeFromMessage(this);
  LogTag copyWith(void Function(LogTag) updates) => super.copyWith((message) => updates(message as LogTag));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogTag create() => LogTag._();
  LogTag createEmptyInstance() => create();
  static $pb.PbList<LogTag> createRepeated() => $pb.PbList<LogTag>();
  @$core.pragma('dart2js:noInline')
  static LogTag getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogTag>(create);
  static LogTag _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class LogGroup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogGroup', createEmptyInstance: create)
    ..pc<Log>(1, '', $pb.PbFieldType.PM, protoName: 'Logs', subBuilder: Log.create)
    ..aOS(2, '', protoName: 'Reserved')
    ..aOS(3, '', protoName: 'Topic')
    ..aOS(4, '', protoName: 'Source')
    ..pc<LogTag>(6, '', $pb.PbFieldType.PM, protoName: 'LogTags', subBuilder: LogTag.create)
  ;

  LogGroup._() : super();
  factory LogGroup() => create();
  factory LogGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LogGroup clone() => LogGroup()..mergeFromMessage(this);
  LogGroup copyWith(void Function(LogGroup) updates) => super.copyWith((message) => updates(message as LogGroup));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogGroup create() => LogGroup._();
  LogGroup createEmptyInstance() => create();
  static $pb.PbList<LogGroup> createRepeated() => $pb.PbList<LogGroup>();
  @$core.pragma('dart2js:noInline')
  static LogGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogGroup>(create);
  static LogGroup _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Log> get logs => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get reserved => $_getSZ(1);
  @$pb.TagNumber(2)
  set reserved($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReserved() => $_has(1);
  @$pb.TagNumber(2)
  void clearReserved() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get topic => $_getSZ(2);
  @$pb.TagNumber(3)
  set topic($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTopic() => $_has(2);
  @$pb.TagNumber(3)
  void clearTopic() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get source => $_getSZ(3);
  @$pb.TagNumber(4)
  set source($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSource() => $_has(3);
  @$pb.TagNumber(4)
  void clearSource() => clearField(4);

  @$pb.TagNumber(6)
  $core.List<LogTag> get logTags => $_getList(4);
}

class LogGroupList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogGroupList', createEmptyInstance: create)
    ..pc<LogGroup>(1, '', $pb.PbFieldType.PM, protoName: 'logGroupList', subBuilder: LogGroup.create)
  ;

  LogGroupList._() : super();
  factory LogGroupList() => create();
  factory LogGroupList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogGroupList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LogGroupList clone() => LogGroupList()..mergeFromMessage(this);
  LogGroupList copyWith(void Function(LogGroupList) updates) => super.copyWith((message) => updates(message as LogGroupList));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogGroupList create() => LogGroupList._();
  LogGroupList createEmptyInstance() => create();
  static $pb.PbList<LogGroupList> createRepeated() => $pb.PbList<LogGroupList>();
  @$core.pragma('dart2js:noInline')
  static LogGroupList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogGroupList>(create);
  static LogGroupList _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LogGroup> get logGroupList => $_getList(0);
}

