import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/Scoring/scoring_main.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

class SubstitutionEvent extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  SubstitutionEvent({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubstitutionEventState();
}

class _SubstitutionEventState extends ConsumerState<SubstitutionEvent> {
  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];

  AddTeamModel? selectedTeam;
  PlayerPersonalInfo? playerIn;
  PlayerPersonalInfo? playerOut;

  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);

    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Substitution", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text("Select Team"),
              const SizedBox(height: 15),
              selectTeam(),
              const SizedBox(height: 15),
              selectedTeam == null
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Player In?*"),
                        const SizedBox(height: 15),
                        selectedTeam!.id == widget.matchModel.homeTeamId
                            ? Wrap(
                                children: homePlayers.map((player) {
                                  return playerInCard(player);
                                }).toList(),
                              )
                            : Wrap(
                                children: awayPlayers.map((player) {
                                  return playerInCard(player);
                                }).toList(),
                              )
                      ],
                    ),
              const SizedBox(height: 15),
              playerIn == null
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Player Out"),
                        const SizedBox(height: 15),
                        selectedTeam!.id == widget.matchModel.homeTeamId
                            ? Wrap(
                                children: homePlayers.map((player) {
                                  return playerOutCard(player);
                                }).toList(),
                              )
                            : Wrap(
                                children: awayPlayers.map((player) {
                                  return playerOutCard(player);
                                }).toList(),
                              ),
                      ],
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
          context: context,
          color: AppThemeShared.primaryColor.withOpacity(
              selectedTeam != null && playerIn != null && playerOut != null
                  ? 1
                  : 0.5),
          width: MediaQuery.of(context).size.width,
          height: 50,
          buttonText: "Confirm Goal Event",
          onTap: () {
            if (selectedTeam != null && playerIn != null && playerOut != null) {
              updateSubs();
            }
          }),
    );
  }

  updateSubs() async {
    MatchEventModel event = MatchEventModel(
        teamId: selectedTeam!.id!,
        minute: widget.matchModel.currTimer!,
        half: widget.matchModel.currHalf!,
        event: MatchEvents.substitution.name,
        playerIn: playerIn!.id,
        playerOut: playerOut!.id,
        addedAt: DateTime.now(),
        penalty: false);
    await FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.matchModel.id)
        .update({
      "keyEvents": FieldValue.arrayUnion(
        [event.toJson()],
      )
    }).then((value) {
      ref.read(keyEventsProvider.notifier).add(event);
      Fluttertoast.showToast(msg: "added");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  Widget selectTeam() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectedTeam = widget.matchModel.homeTeamModel!;
            playerIn = null;
            playerOut = null;
            setState(() {});
          },
          child: Card(
            color: selectedTeam != null &&
                    selectedTeam!.id == widget.matchModel.homeTeamId
                ? AppThemeShared.secondaryColor
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.matchModel.homeTeamModel!.name,
                style: TextStyle(
                    color: selectedTeam != null &&
                            selectedTeam!.id == widget.matchModel.homeTeamId
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            selectedTeam = widget.matchModel.awayTeamModel!;
            playerIn = null;
            playerOut = null;
            setState(() {});
          },
          child: Card(
            color: selectedTeam != null &&
                    selectedTeam!.id == widget.matchModel.awayTeamId
                ? AppThemeShared.secondaryColor
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.matchModel.awayTeamModel!.name,
                style: TextStyle(
                    color: selectedTeam != null &&
                            selectedTeam!.id == widget.matchModel.awayTeamId
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget playerInCard(PlayerPersonalInfo player) {
    return GestureDetector(
      onTap: () {
        playerIn = player;
        if (playerIn == playerOut) {
          playerOut = null;
        }
        setState(() {});
      },
      child: Card(
        color: playerIn != null && playerIn!.id == player.id
            ? AppThemeShared.secondaryColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: playerIn != null && playerIn!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget playerOutCard(PlayerPersonalInfo player) {
    return GestureDetector(
      onTap: () {
        if (player == playerIn) {
          Fluttertoast.showToast(msg: "This player is coming in");
        } else {
          playerOut = player;
          setState(() {});
        }
      },
      child: Card(
        color: playerIn!.id == player.id
            ? Colors.grey
            : playerOut != null && playerOut!.id == player.id
                ? AppThemeShared.secondaryColor
                : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: playerOut != null && playerOut!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
