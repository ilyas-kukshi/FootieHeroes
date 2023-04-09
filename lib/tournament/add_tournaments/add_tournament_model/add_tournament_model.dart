import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';
import 'package:footie_heroes/tournament/points_table/team_points_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_tournament_model.freezed.dart';
part 'add_tournament_model.g.dart';

@freezed
class AddTournamentModel with _$AddTournamentModel {
  const AddTournamentModel._();

  factory AddTournamentModel({
    String? id,
    required String name,
    required String organizerId,
    required DateTime startDate,
    required DateTime endDate,
    required int noOfHalfs,
    required int minsEachHalf,
    required String logoUri,
    required String bannerUri,
    required List scorers,
    required List<String> followersId,
    List<String>? teams,
    required Map<String, PlayersTournamentModel> playerStats,
    required Map<String, TeamPointsModel> pointsTable,
    required Map<String, int> goalLeaderboard,
    required Map<String, int> assistLeaderboard,
    required Map<String, int> cleanSheetLeaderboard,
    required Map<String, int> yellowCardLeaderboard,
    required Map<String, int> redCardLeaderboard,
  }) = _AddTournamentModel;

  factory AddTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$AddTournamentModelFromJson(json);
  factory AddTournamentModel.fromDocument(DocumentSnapshot document) {
    final doc = document.data() as Map<String, dynamic>;
    return AddTournamentModel.fromJson(doc).copyWith(id: document.id);
  }
}
