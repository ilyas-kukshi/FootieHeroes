// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TeamPointsModel _$$_TeamPointsModelFromJson(Map<String, dynamic> json) =>
    _$_TeamPointsModel(
      id: json['id'] as String?,
      groupName: json['groupName'] as String?,
      teamId: json['teamId'] as String,
      played: json['played'] as int,
      wins: json['wins'] as int,
      lost: json['lost'] as int,
      draws: json['draws'] as int,
      goalsScored: json['goalsScored'] as int,
      goalsConceded: json['goalsConceded'] as int,
      playedAgainst: (json['playedAgainst'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      wonAgainst: (json['wonAgainst'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lostAgainst: (json['lostAgainst'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_TeamPointsModelToJson(_$_TeamPointsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupName': instance.groupName,
      'teamId': instance.teamId,
      'played': instance.played,
      'wins': instance.wins,
      'lost': instance.lost,
      'draws': instance.draws,
      'goalsScored': instance.goalsScored,
      'goalsConceded': instance.goalsConceded,
      'playedAgainst': instance.playedAgainst,
      'wonAgainst': instance.wonAgainst,
      'lostAgainst': instance.lostAgainst,
    };
