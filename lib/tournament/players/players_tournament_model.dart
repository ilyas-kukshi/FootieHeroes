import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'players_tournament_model.freezed.dart';
part 'players_tournament_model.g.dart';

@freezed
abstract class PlayersTournamentModel implements _$PlayersTournamentModel {
  const PlayersTournamentModel._();

  factory PlayersTournamentModel({
    String? id,
    required AddTeamModel teamModel,
    required PlayerPersonalInfo playerPersonalInfo,
  }) = _PlayersTournamentModel;

  factory PlayersTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$PlayersTournamentModelFromJson(json);

  factory PlayersTournamentModel.fromDocument(
      DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return PlayersTournamentModel.fromJson(data)
        .copyWith(id: documentSnapshot.id);
  }
}
