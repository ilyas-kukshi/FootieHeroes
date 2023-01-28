import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';

class Matches extends StatefulWidget {
  AddTournamentModel tournamentModel;
  bool organizer;
  Matches({super.key, required this.tournamentModel, required this.organizer});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: widget.organizer
          ? AppThemeShared.sharedButton(
              context: context,
              width: MediaQuery.of(context).size.width,
              height: 50,
              buttonText: "Add Matches",
              onTap: () {
                Navigator.pushNamed(context, '/addMatches');
              })
          : const Offstage(),
    );
  }
}
