import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_tournament_model.freezed.dart';
part 'add_tournament_model.g.dart';

@freezed
class AddTournamentModel with _$AddTournamentModel {
  const AddTournamentModel._();

  factory AddTournamentModel({
    String? id,
    required String name,
    required PlayerPersonalInfo organizer,
    required DateTime startDate,
    required DateTime endDate,
    required String logoUri,
    required String bannerUri,
    List? teams,
  }) = _AddTournamentModel;

  factory AddTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$AddTournamentModelFromJson(json);
  factory AddTournamentModel.fromDocument(DocumentSnapshot document) {
    final doc = document.data() as Map<String, dynamic>;
    return AddTournamentModel.fromJson(doc).copyWith(id: document.id);
  }
}
