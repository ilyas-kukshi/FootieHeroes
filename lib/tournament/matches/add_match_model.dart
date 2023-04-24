import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';

import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_match_model.freezed.dart';
part 'add_match_model.g.dart';

@freezed
abstract class AddMatchModel implements _$AddMatchModel {
  const AddMatchModel._();

  factory AddMatchModel({
    String? id,
    required String tournamentId,
    required String matchType,
    required String matchStatus,
    required String homeTeamId,
    required String awayTeamId,
    required int noOfHalfs,
    required int minsEachHalf,
    required int startingPlayers,
    required int noOfSubs,
    required String substitutionType,
    required DateTime matchDate,
    Map<String, String>? homeLineup,
    List<String>? homeSubstitutes,
    Map<String, String>? awayLineup,
    List<String>? awaySubstitutes,
    AddTeamModel? homeTeamModel,
    AddTeamModel? awayTeamModel,
    required int homeTeamScore,
    required int awayTeamScore,
    int? currTimer,
    int? currHalf,
    List<Map<String, dynamic>>? keyEvents,
  }) = _AddMatchModel;

  factory AddMatchModel.fromJson(Map<String, dynamic> json) =>
      _$AddMatchModelFromJson(json);

  factory AddMatchModel.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return AddMatchModel.fromJson(data).copyWith(id: document.id);
  }
}
