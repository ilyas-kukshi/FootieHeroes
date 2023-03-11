import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

class CardsEventsDialogs {
  AddTeamModel? selectedTeam;
  PlayerPersonalInfo? yellowCarded;

  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];

  yellowCardDialog(BuildContext context, AddMatchModel matchModel) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Consumer(
            builder: (context, ref, _) {
              homePlayers = ref.watch(selectedHomeProvider);
              awayPlayers = ref.watch(selectedAwayProvider);
              return AlertDialog(
                content: Column(
                  children: [
                    
                    const SizedBox(height: 15),
                    AppThemeShared.sharedButton(
                      context: context,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      color: AppThemeShared.primaryColor.withOpacity(
                          selectedTeam != null && yellowCarded != null
                              ? 1
                              : 0.5),
                      buttonText: "Save Yellow Event",
                      onTap: () {
                        if (selectedTeam != null && yellowCarded != null) {}
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }

  updateYellowCard() async {}

  

  Widget playersListYC(
    PlayerPersonalInfo player,
    void Function(void Function()) setState,
  ) {
    return GestureDetector(
      onTap: () {
        yellowCarded = player;

        setState(() {});
      },
      child: Card(
        color: yellowCarded != null && yellowCarded!.id == player.id
            ? AppThemeShared.secondaryColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: yellowCarded != null && yellowCarded!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
