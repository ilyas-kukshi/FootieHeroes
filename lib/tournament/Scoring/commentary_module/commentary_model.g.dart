// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentaryModel _$$_CommentaryModelFromJson(Map<String, dynamic> json) =>
    _$_CommentaryModel(
      id: json['id'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      commentary: json['commentary'] as String,
      minute: json['minute'] as int,
    );

Map<String, dynamic> _$$_CommentaryModelToJson(_$_CommentaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'commentary': instance.commentary,
      'minute': instance.minute,
    };
