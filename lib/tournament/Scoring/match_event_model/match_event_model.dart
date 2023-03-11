import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_event_model.freezed.dart';
part 'match_event_model.g.dart';

@freezed
abstract class MatchEventModel implements _$MatchEventModel {
  const MatchEventModel._();

  factory MatchEventModel(
      {required String teamId,
      required int minute,
      required int half,
      required String event,
      String? scoredBy,
      String? assistedBy,
      required bool penalty,
      String? playerOut,
      String? playerIn,
      String? cardType,
      String? playerCarded,
      required DateTime addedAt,}) = _MatchEventModel;

  factory MatchEventModel.fromJson(Map<String, dynamic> json) =>
      _$MatchEventModelFromJson(json);

  factory MatchEventModel.fromDocument(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return MatchEventModel.fromJson(data);
  }
}
