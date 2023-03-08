// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayersTournamentModel _$$_PlayersTournamentModelFromJson(
        Map<String, dynamic> json) =>
    _$_PlayersTournamentModel(
      id: json['id'] as String?,
      teamModel:
          AddTeamModel.fromJson(json['teamModel'] as Map<String, dynamic>),
      playerPersonalInfo: PlayerPersonalInfo.fromJson(
          json['playerPersonalInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlayersTournamentModelToJson(
        _$_PlayersTournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamModel': instance.teamModel,
      'playerPersonalInfo': instance.playerPersonalInfo,
    };
