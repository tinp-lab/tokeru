// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      indentLevel: json['indentLevel'] as int,
      index: json['index'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isDone': instance.isDone,
      'indentLevel': instance.indentLevel,
      'index': instance.index,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
