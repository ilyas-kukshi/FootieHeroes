import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'commentary_model.freezed.dart';
part 'commentary_model.g.dart';

@freezed
abstract class CommentaryModel implements _$CommentaryModel {
  const CommentaryModel._();

  factory CommentaryModel(
      {String? id,
      required DateTime timestamp,
      required String commentary,
      required int minute}) = _CommentaryModel;

  factory CommentaryModel.fromJson(Map<String, dynamic> json) =>
      _$CommentaryModelFromJson(json);

  factory CommentaryModel.fromDocument(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return CommentaryModel.fromJson(data).copyWith(id: documentSnapshot.id);
  }
}
