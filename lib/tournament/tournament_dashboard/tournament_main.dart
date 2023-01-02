import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';

// ignore: must_be_immutable
class TournamentMain extends StatefulWidget {
  AddTournamentModel tournamentAbout;
   TournamentMain({Key? key, required this.tournamentAbout}) : super(key: key);

  @override
  State<TournamentMain> createState() => _TournamentMainState();
}

class _TournamentMainState extends State<TournamentMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/auth/signin.jpg',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.transparent,
            ),
          )),
          Image.asset(
            'assets/images/auth/logo.png',
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
