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

class GoalEvent extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  GoalEvent({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GoalEventState();
}

class _GoalEventState extends ConsumerState<GoalEvent> {
  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];

  AddTeamModel? selectedTeam;
  PlayerPersonalInfo? scoredBy;
  PlayerPersonalInfo? assistedBy;
  bool penalty = false;

  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);

    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Goal Scored", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text("Which team scored?*"),
              const SizedBox(height: 15),
              selectScoringTeam(),
              const SizedBox(height: 15),
              selectedTeam == null
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Which player scored?*"),
                        const SizedBox(height: 15),
                        selectedTeam!.id == widget.matchModel.homeTeamId
                            ? Wrap(
                                children: homePlayers.map((player) {
                                  return playerCard(player);
                                }).toList(),
                              )
                            : Wrap(
                                children: awayPlayers.map((player) {
                                  return playerCard(player);
                                }).toList(),
                              )
                      ],
                    ),
              scoredBy != null
                  ? Row(
                      children: [
                        Text("Goal scored was a penalty."),
                        Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppThemeShared.secondaryColor),
                            value: penalty,
                            onChanged: (value) {
                              penalty = value!;
                              if (value) {
                                assistedBy = null;
                              }
                              setState(() {});
                            }),
                      ],
                    )
                  : const Offstage(),
              const SizedBox(height: 15),
              scoredBy != null
                  ? penalty
                      ? const Offstage()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Which player provide the assist?"),
                            selectedTeam!.id == widget.matchModel.homeTeamId
                                ? Wrap(
                                    children: homePlayers.map((player) {
                                      return playerAssistCard(player);
                                    }).toList(),
                                  )
                                : Wrap(
                                    children: awayPlayers.map((player) {
                                      return playerAssistCard(player);
                                    }).toList(),
                                  ),
                          ],
                        )
                  : const Offstage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
          context: context,
          color: AppThemeShared.primaryColor
              .withOpacity(selectedTeam != null && scoredBy != null ? 1 : 0.5),
          width: MediaQuery.of(context).size.width,
          height: 50,
          buttonText: "Confirm Goal Event",
          onTap: () {
            if (selectedTeam != null && scoredBy != null) {
              updateScores();
            }
          }),
    );
  }

  updateScores() async {
    MatchEventModel event = MatchEventModel(
        teamId: selectedTeam!.id!,
        minute: widget.matchModel.currTimer!,
        half: widget.matchModel.currHalf!,
        event: MatchEvents.goal.name,
        scoredBy: scoredBy!.id,
        assistedBy: assistedBy?.id,
        penalty: penalty,
        addedAt: DateTime.now());

    await FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.matchModel.id)
        .update({
      "homeTeamScore": selectedTeam!.id == widget.matchModel.homeTeamId
          ? widget.matchModel.homeTeamScore + 1
          : widget.matchModel.homeTeamScore,
      "awayTeamScore": selectedTeam!.id == widget.matchModel.awayTeamId
          ? widget.matchModel.awayTeamScore + 1
          : widget.matchModel.awayTeamScore,
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

  Widget selectScoringTeam() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectedTeam = widget.matchModel.homeTeamModel!;
            scoredBy = null;
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
            scoredBy = null;
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

  Widget playerCard(PlayerPersonalInfo player) {
    return GestureDetector(
      onTap: () {
        scoredBy = player;
        setState(() {});
      },
      child: Card(
        color: scoredBy != null && scoredBy!.id == player.id
            ? AppThemeShared.secondaryColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: scoredBy != null && scoredBy!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget playerAssistCard(PlayerPersonalInfo player) {
    return GestureDetector(
      onTap: () {
        if (player == scoredBy) {
          Fluttertoast.showToast(msg: "This player has scored the goal");
        } else {
          assistedBy = player;
          setState(() {});
        }
      },
      child: Card(
        color: scoredBy!.id == player.id
            ? Colors.grey
            : assistedBy != null && assistedBy!.id == player.id
                ? AppThemeShared.secondaryColor
                : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: assistedBy != null && assistedBy!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
