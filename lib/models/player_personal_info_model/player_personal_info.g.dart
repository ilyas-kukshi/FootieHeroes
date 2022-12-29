// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerPersonalInfo _$$_PlayerPersonalInfoFromJson(
        Map<String, dynamic> json) =>
    _$_PlayerPersonalInfo(
      id: json['id'] as String?,
      name: json['name'] as String,
      phoneNo: json['phoneNo'] as String,
      position: json['position'] as String,
      prefFoot: json['prefFoot'] as String,
      gender: json['gender'] as String,
      photoUri: json['photoUri'] as String?,
    );

Map<String, dynamic> _$$_PlayerPersonalInfoToJson(
        _$_PlayerPersonalInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'position': instance.position,
      'prefFoot': instance.prefFoot,
      'gender': instance.gender,
      'photoUri': instance.photoUri,
    };
