

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_personal_info.freezed.dart';
part 'player_personal_info.g.dart';

@freezed
abstract class PlayerPersonalInfo implements _$PlayerPersonalInfo {
  const PlayerPersonalInfo._();

  factory PlayerPersonalInfo({
    String? id,
    required String name,
    required String phoneNo,
    required String position,
    required String role,
    required String prefFoot,
    required String gender,
    String? photoUri
  }) = _PlayerPersonalInfo;

 
  factory PlayerPersonalInfo.fromJson(Map<String, dynamic> json) => _$PlayerPersonalInfoFromJson(json);

  factory PlayerPersonalInfo.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return PlayerPersonalInfo.fromJson(data).copyWith(id:document.id);
  }

  
    
}