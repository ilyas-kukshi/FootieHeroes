import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'players_tournament_model.freezed.dart';
part 'players_tournament_model.g.dart';

@freezed
abstract class PlayersTournamentModel implements _$PlayersTournamentModel {
  const PlayersTournamentModel._();

  factory PlayersTournamentModel({
    String? id,
    required String playerId,
    required String teamId,
    required int noOfGoals,
    required int noOfAssists,
    required int noOfYC,
    required int noOfRC,
    required int noOfMatches,
    required int noOfCleanSheets,
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
