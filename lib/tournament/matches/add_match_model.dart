import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_match_model.freezed.dart';
part 'add_match_model.g.dart';

@freezed
abstract class AddMatchModel implements _$AddMatchModel {
  const AddMatchModel._();

  factory AddMatchModel({
    String? id,
    required String matchType,
    required AddTeamModel homeTeam,
    required AddTeamModel awayTeam,
    required int noOfHalfs,
    required int minsEachHalf,
    required int startingPlayers,
    required int noOfSubs,
    required String substitutionType,
    required DateTime matchDate,
  }) = _AddMatchModel;

  factory AddMatchModel.fromJson(Map<String, dynamic> json) =>
      _$AddMatchModelFromJson(json);

  factory AddMatchModel.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return AddMatchModel.fromJson(data).copyWith(id: document.id);
  }
}