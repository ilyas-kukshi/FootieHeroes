// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddTeamModel _$$_AddTeamModelFromJson(Map<String, dynamic> json) =>
    _$_AddTeamModel(
      id: json['id'] as String?,
      logoUri: json['logoUri'] as String?,
      name: json['name'] as String,
      townName: json['townName'] as String,
      isGrouped: json['isGrouped'] as bool,
      groupName: json['groupName'] as String?,
      tournamentId: (json['tournamentId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      playersId: (json['playersId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currTournamentId: json['currTournamentId'] as String?,
    );

Map<String, dynamic> _$$_AddTeamModelToJson(_$_AddTeamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logoUri': instance.logoUri,
      'name': instance.name,
      'townName': instance.townName,
      'isGrouped': instance.isGrouped,
      'groupName': instance.groupName,
      'tournamentId': instance.tournamentId,
      'playersId': instance.playersId,
      'currTournamentId': instance.currTournamentId,
    };
