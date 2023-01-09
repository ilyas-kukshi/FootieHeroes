import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_team_model.freezed.dart';
part 'add_team_model.g.dart';

@freezed
abstract class AddTeamModel implements _$AddTeamModel {
  const AddTeamModel._();

  factory AddTeamModel({
    String? id,
    String? logoUri,
    required String name,
    required String townName,
    required String tournamentId,
  }) = _AddTeamModel;

  factory AddTeamModel.fromJson(Map<String, dynamic> json) =>
      _$AddTeamModelFromJson(json);

  factory AddTeamModel.fromDocument(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return AddTeamModel.fromJson(data).copyWith(id: documentSnapshot.id);
  }
}
