// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchEventModel _$$_MatchEventModelFromJson(Map<String, dynamic> json) =>
    _$_MatchEventModel(
      teamId: json['teamId'] as String,
      minute: json['minute'] as int,
      half: json['half'] as int,
      event: json['event'] as String,
      scoredBy: json['scoredBy'] as String?,
      assistedBy: json['assistedBy'] as String?,
      penalty: json['penalty'] as bool,
      playerOut: json['playerOut'] as String?,
      playerIn: json['playerIn'] as String?,
      cardType: json['cardType'] as String?,
    );

Map<String, dynamic> _$$_MatchEventModelToJson(_$_MatchEventModel instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'minute': instance.minute,
      'half': instance.half,
      'event': instance.event,
      'scoredBy': instance.scoredBy,
      'assistedBy': instance.assistedBy,
      'penalty': instance.penalty,
      'playerOut': instance.playerOut,
      'playerIn': instance.playerIn,
      'cardType': instance.cardType,
    };
