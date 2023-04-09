import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'team_points_model.freezed.dart';
part 'team_points_model.g.dart';

@freezed
abstract class TeamPointsModel implements _$TeamPointsModel {
  const TeamPointsModel._();

  factory TeamPointsModel({
    String? id,
    String? groupName,
    required String teamId,
    required int played,
    required int wins,
    required int lost,
    required int draws,
    required int goalsScored,
    required int goalsConceded,
    required List<String> playedAgainst,
    required List<String> wonAgainst,
    required List<String> lostAgainst,
  }) = _TeamPointsModel;

  factory TeamPointsModel.fromJson(Map<String, dynamic> json) =>
      _$TeamPointsModelFromJson(json);

  factory TeamPointsModel.fromDocument(DocumentSnapshot document) {
    final doc = document.data() as Map<String, dynamic>;
    return TeamPointsModel.fromJson(doc).copyWith(id: document.id);
  }
}
