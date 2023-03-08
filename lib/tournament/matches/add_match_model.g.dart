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
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      noOfHalfs: json['noOfHalfs'] as int,
      minsEachHalf: json['minsEachHalf'] as int,
      startingPlayers: json['startingPlayers'] as int,
      noOfSubs: json['noOfSubs'] as int,
      substitutionType: json['substitutionType'] as String,
      matchDate: DateTime.parse(json['matchDate'] as String),
      homeLineup: (json['homeLineup'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      homeSubstitutes: (json['homeSubstitutes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      awayLineup: (json['awayLineup'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      awaySubstitutes: (json['awaySubstitutes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      homeTeamModel: json['homeTeamModel'] == null
          ? null
          : AddTeamModel.fromJson(
              json['homeTeamModel'] as Map<String, dynamic>),
      awayTeamModel: json['awayTeamModel'] == null
          ? null
          : AddTeamModel.fromJson(
              json['awayTeamModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AddMatchModelToJson(_$_AddMatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tournamentId': instance.tournamentId,
      'matchType': instance.matchType,
      'matchStatus': instance.matchStatus,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'noOfHalfs': instance.noOfHalfs,
      'minsEachHalf': instance.minsEachHalf,
      'startingPlayers': instance.startingPlayers,
      'noOfSubs': instance.noOfSubs,
      'substitutionType': instance.substitutionType,
      'matchDate': instance.matchDate.toIso8601String(),
      'homeLineup': instance.homeLineup,
      'homeSubstitutes': instance.homeSubstitutes,
      'awayLineup': instance.awayLineup,
      'awaySubstitutes': instance.awaySubstitutes,
      'homeTeamModel': instance.homeTeamModel,
      'awayTeamModel': instance.awayTeamModel,
    };
