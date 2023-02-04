// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddMatchModel _$$_AddMatchModelFromJson(Map<String, dynamic> json) =>
    _$_AddMatchModel(
      id: json['id'] as String?,
      tournamentId: json['tournamentId'] as String,
      matchType: json['matchType'] as String,
      matchStatus: json['matchStatus'] as String,
      homeTeam: AddTeamModel.fromJson(json['homeTeam'] as Map<String, dynamic>),
      awayTeam: AddTeamModel.fromJson(json['awayTeam'] as Map<String, dynamic>),
      noOfHalfs: json['noOfHalfs'] as int,
      minsEachHalf: json['minsEachHalf'] as int,
      startingPlayers: json['startingPlayers'] as int,
      noOfSubs: json['noOfSubs'] as int,
      substitutionType: json['substitutionType'] as String,
      matchDate: DateTime.parse(json['matchDate'] as String),
    );

Map<String, dynamic> _$$_AddMatchModelToJson(_$_AddMatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tournamentId': instance.tournamentId,
      'matchType': instance.matchType,
      'matchStatus': instance.matchStatus,
      'homeTeam': instance.homeTeam.toJson(),
      'awayTeam': instance.awayTeam.toJson(),
      'noOfHalfs': instance.noOfHalfs,
      'minsEachHalf': instance.minsEachHalf,
      'startingPlayers': instance.startingPlayers,
      'noOfSubs': instance.noOfSubs,
      'substitutionType': instance.substitutionType,
      'matchDate': instance.matchDate.toIso8601String(),
    };
