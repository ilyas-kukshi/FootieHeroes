import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/Scoring/scoring_main.dart';
import 'package:footie_heroes/tournament/Scoring/services/key_to_sentences_service.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';

// ignore: must_be_immutable
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

  TextEditingController _controller = TextEditingController();
  List<String> _filteredTags = [];
  List<String> selectedKeywords = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              const Text("Which team scored?*"),
              const SizedBox(height: 15),
              selectScoringTeam(),
              const SizedBox(height: 15),
              selectedTeam == null
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Which player scored?*"),
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
                        const Text("Goal scored was a penalty."),
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
                            const Text("Which player provide the assist?"),
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
              selectedKeywords.isNotEmpty
                  ? Wrap(
                      children: selectedKeywords.map((key) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: AppThemeShared.primaryColor,
                                    width: 2)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(key),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedKeywords.remove(key);
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: AppThemeShared.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const Offstage(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  onChanged: _onTextChanged,
                  decoration: const InputDecoration(
                    hintText: 'Enter a tag',
                  ),
                ),
              ),
              if (_filteredTags.isNotEmpty)
                Dialog(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredTags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_filteredTags[index]),
                        onTap: () {
                          selectedKeywords.add(_filteredTags[index]);
                          _filteredTags.clear();
                          _controller.clear();
                          setState(() {});
                          // Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              selectedKeywords.length >= 3
                  ? AppThemeShared.sharedButton(
                      context: context,
                      width: 200,
                      buttonText: "Get Commentary",
                      onTap: () {
                        KeyToSentencesService()
                            .getConmmentary(selectedKeywords);
                      },
                    )
                  : const Offstage()
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
              // updateScores();
              updateLeaderboard();
            }
          }),
    );
  }

  void _onTextChanged(String value) {
    setState(() {
      _filteredTags = [
        "low cross",
        "In swinging cross",
        "Out swinging cross",
        'High cross',
        "Chip cross",
        "Cut back cros",
        "Diagonal cross",
        "save",
        "shot",
        "scored"
      ]
          .where(
              (tag) => tag.toLowerCase().contains(value.toLowerCase().trim()))
          .toList();
    });
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
      Fluttertoast.showToast(msg: "scores and keyevents updated");
      updateLeaderboard();
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  updateLeaderboard() async {
    Map<String, PlayersTournamentModel> map = {};
    AddTournamentModel tournamentModel =
        await Utility().getTournament(widget.matchModel.tournamentId);

    map = Map.fromEntries(tournamentModel.playerStats.entries);
    map.update(
      scoredBy!.id!,
      (value) {
        return value.copyWith(noOfGoals: value.noOfGoals + 1);
      },
      ifAbsent: () {
        return PlayersTournamentModel(
            playerId: scoredBy!.id!,
            teamId: selectedTeam!.id!,
            noOfGoals: 1,
            noOfAssists: 0,
            noOfYC: 0,
            noOfRC: 0,
            noOfMatches: 0,
            noOfCleanSheets: 0);
      },
    );
    if (assistedBy != null) {
      map.update(
        assistedBy!.id!,
        (value) {
          return value.copyWith(noOfAssists: value.noOfAssists + 1);
        },
        ifAbsent: () {
          return PlayersTournamentModel(
              playerId: assistedBy!.id!,
              teamId: selectedTeam!.id!,
              noOfGoals: 0,
              noOfAssists: 1,
              noOfYC: 0,
              noOfRC: 0,
              noOfMatches: 0,
              noOfCleanSheets: 0);
        },
      );
    }
    Map<String, Map<String, dynamic>> finalMap = {};
    for (var element in map.entries) {
      finalMap.putIfAbsent(element.key, () => element.value.toJson());
    }
    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(widget.matchModel.tournamentId)
        .update({"playerStats": finalMap}).then((value) {
      Fluttertoast.showToast(msg: "Leaderboard Updated");
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
