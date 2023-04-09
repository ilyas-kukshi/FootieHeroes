// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayersTournamentModel _$$_PlayersTournamentModelFromJson(
        Map<String, dynamic> json) =>
    _$_PlayersTournamentModel(
      id: json['id'] as String?,
      playerId: json['playerId'] as String,
      teamId: json['teamId'] as String,
      noOfGoals: json['noOfGoals'] as int,
      noOfAssists: json['noOfAssists'] as int,
      noOfYC: json['noOfYC'] as int,
      noOfRC: json['noOfRC'] as int,
      noOfMatches: json['noOfMatches'] as int,
      noOfCleanSheets: json['noOfCleanSheets'] as int,
    );

Map<String, dynamic> _$$_PlayersTournamentModelToJson(
        _$_PlayersTournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'teamId': instance.teamId,
      'noOfGoals': instance.noOfGoals,
      'noOfAssists': instance.noOfAssists,
      'noOfYC': instance.noOfYC,
      'noOfRC': instance.noOfRC,
      'noOfMatches': instance.noOfMatches,
      'noOfCleanSheets': instance.noOfCleanSheets,
    };
