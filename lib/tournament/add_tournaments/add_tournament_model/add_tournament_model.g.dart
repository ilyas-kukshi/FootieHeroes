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
      organizer: PlayerPersonalInfo.fromJson(
          json['organizer'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      logoUri: json['logoUri'] as String,
      bannerUri: json['bannerUri'] as String,
      teams: json['teams'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_AddTournamentModelToJson(
        _$_AddTournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organizer': instance.organizer.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'logoUri': instance.logoUri,
      'bannerUri': instance.bannerUri,
      'teams': instance.teams,
    };
