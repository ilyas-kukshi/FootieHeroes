import 'package:cloud_firestore/cloud_firestore.dart';
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
  }) = _AddTournamentModel;

  factory AddTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$AddTournamentModelFromJson(json);
  factory AddTournamentModel.fromDocument(DocumentSnapshot document) {
    final doc = document.data() as Map<String, dynamic>;
    return AddTournamentModel.fromJson(doc).copyWith(id: document.id);
  }
}
