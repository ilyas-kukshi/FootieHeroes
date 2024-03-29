// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddTournamentModel _$$_AddTournamentModelFromJson(
        Map<String, dynamic> json) =>
    _$_AddTournamentModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      organizerId: json['organizerId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      noOfHalfs: json['noOfHalfs'] as int,
      minsEachHalf: json['minsEachHalf'] as int,
      logoUri: json['logoUri'] as String,
      bannerUri: json['bannerUri'] as String,
      scorers: json['scorers'] as List<dynamic>,
      followersId: (json['followersId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      teams:
          (json['teams'] as List<dynamic>?)?.map((e) => e as String).toList(),
      playerStats: (json['playerStats'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, PlayersTournamentModel.fromJson(e as Map<String, dynamic>)),
      ),
      pointsTable: (json['pointsTable'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, TeamPointsModel.fromJson(e as Map<String, dynamic>)),
      ),
      goalLeaderboard: Map<String, int>.from(json['goalLeaderboard'] as Map),
      assistLeaderboard:
          Map<String, int>.from(json['assistLeaderboard'] as Map),
      cleanSheetLeaderboard:
          Map<String, int>.from(json['cleanSheetLeaderboard'] as Map),
      yellowCardLeaderboard:
          Map<String, int>.from(json['yellowCardLeaderboard'] as Map),
      redCardLeaderboard:
          Map<String, int>.from(json['redCardLeaderboard'] as Map),
    );

Map<String, dynamic> _$$_AddTournamentModelToJson(
        _$_AddTournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organizerId': instance.organizerId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'noOfHalfs': instance.noOfHalfs,
      'minsEachHalf': instance.minsEachHalf,
      'logoUri': instance.logoUri,
      'bannerUri': instance.bannerUri,
      'scorers': instance.scorers,
      'followersId': instance.followersId,
      'teams': instance.teams,
      'playerStats': instance.playerStats,
      'pointsTable': instance.pointsTable,
      'goalLeaderboard': instance.goalLeaderboard,
      'assistLeaderboard': instance.assistLeaderboard,
      'cleanSheetLeaderboard': instance.cleanSheetLeaderboard,
      'yellowCardLeaderboard': instance.yellowCardLeaderboard,
      'redCardLeaderboard': instance.redCardLeaderboard,
    };
