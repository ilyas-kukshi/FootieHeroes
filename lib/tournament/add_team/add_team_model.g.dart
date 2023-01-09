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
      tournamentId: json['tournamentId'] as String,
    );

Map<String, dynamic> _$$_AddTeamModelToJson(_$_AddTeamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logoUri': instance.logoUri,
      'name': instance.name,
      'townName': instance.townName,
      'tournamentId': instance.tournamentId,
    };
