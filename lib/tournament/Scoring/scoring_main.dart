import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/matches/matches.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';
import 'package:footie_heroes/tournament/points_table/team_points_model.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/commentary_model.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/commentary_widget.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'commentary_module/key_to_sentences_service.dart';

// ignore: must_be_immutable
class ScoringMain extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  ScoringMain({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScoringMainState();
}

class _ScoringMainState extends ConsumerState<ScoringMain> {
  bool matchStarted = false;
  bool paused = false;

  StopWatchTimer stopwatch = StopWatchTimer(mode: StopWatchMode.countUp);

  String finalCommentary = '';
  currCommentary(String commentary) {
    setState(() {
      finalCommentary = commentary;
    });
  }

  @override
  void initState() {
    super.initState();
    setPlayerListProvider();
    updateMins();
  }

  @override
  Widget build(BuildContext context) {
    final matchDoc = ref.watch(currMatchProvider(widget.matchModel));

    return WillPopScope(
      onWillPop: () {
        if (matchStarted) {
          DialogShared.singleButtonDialog(
              context, "You cant exit till you finish the match", "Okay", () {
            Navigator.pop(context);
          });
          return Future.value(false);
        } else {
          stopwatch.dispose();
          return Future.value(true);
        }
        // return Future.value(true);
      },
      child: Scaffold(
          body: SafeArea(
            child: matchDoc.when(
              data: (match) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    teamScores(widget.matchModel),
                    match.matchStatus == MatchStatus.upcoming.name ||
                            match.matchStatus == MatchStatus.fHalfEnd.name ||
                            match.matchStatus == MatchStatus.sHalfEnd.name
                        ? const Text(
                            "Start/Resume match to update key events",
                          )
                        : Column(
                            children: [
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: const [
                              //     Text(
                              //       "View Key Events",
                              //       style: TextStyle(
                              //           decoration: TextDecoration.underline,
                              //           decorationColor: Colors.blue,
                              //           decorationStyle:
                              //               TextDecorationStyle.solid),
                              //     ),
                              //     Text(
                              //       "View Commentary",
                              //       style: TextStyle(
                              //           decoration: TextDecoration.underline),
                              //     )
                              //   ],
                              // ),
                              const SizedBox(height: 8),
                              eventGrid(),
                              CommentaryWidget(
                                  currentCommentary: currCommentary),
                              finalCommentary.isNotEmpty
                                  ? AppThemeShared.sharedButton(
                                      context: context,
                                      color: AppThemeShared.primaryColor,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height: 50,
                                      buttonText: "Post Commentary",
                                      onTap: () {
                                        KeyToSentencesService()
                                            .updateCommentary(
                                                stopwatch.minuteTime.value,
                                                finalCommentary,
                                                widget.matchModel.id!);
                                      })
                                  : const Offstage()
                            ],
                          ),
                  ],
                ));
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          bottomNavigationBar: matchDoc.when(
            data: (data) {
              return AppThemeShared.sharedButton(
                context: context,
                width: MediaQuery.of(context).size.width,
                height: 50,
                buttonText: data.matchStatus == MatchStatus.upcoming.name
                    ? "Start Match"
                    : data.noOfHalfs == 1
                        ? "End Match"
                        : data.matchStatus == MatchStatus.fHalfStart.name
                            ? "End First Half"
                            : data.matchStatus == MatchStatus.fHalfEnd.name
                                ? "Start Second Half"
                                : data.matchStatus ==
                                        MatchStatus.sHalfStart.name
                                    ? "End Second Half"
                                    : "End Match",
                onTap: () {
                  if (data.matchStatus == MatchStatus.upcoming.name) {
                    changeMatchStatus(MatchStatus.fHalfStart.name);
                    updateTimer(MatchStatus.fHalfStart.name);
                  } else if (data.noOfHalfs == 1) {
                    changeMatchStatus(MatchStatus.completed.name);
                    updateTimer(MatchStatus.completed.name);
                    updatePointsTable();
                  } else if (data.matchStatus == MatchStatus.fHalfStart.name) {
                    changeMatchStatus(MatchStatus.fHalfEnd.name);
                    updateTimer(MatchStatus.fHalfEnd.name);
                  } else if (data.matchStatus == MatchStatus.fHalfEnd.name) {
                    changeMatchStatus(MatchStatus.sHalfStart.name);
                    updateTimer(MatchStatus.sHalfStart.name);
                  } else if (data.matchStatus == MatchStatus.sHalfStart.name) {
                    changeMatchStatus(MatchStatus.sHalfEnd.name);
                    updateTimer(MatchStatus.sHalfEnd.name);
                  } else {
                    changeMatchStatus(MatchStatus.completed.name);
                    updateTimer(MatchStatus.completed.name);
                    updatePointsTable();
                  }
                },
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // stopwatch.dispose();
  }

  changeMatchStatus(String newMatchStatus) async {
    await FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.matchModel.id)
        .update({"matchStatus": newMatchStatus}).then((value) async {
      setState(() {});

      await FirebaseFirestore.instance
          .collection("Matches")
          .doc(widget.matchModel.id)
          .collection("Commentary")
          .add(CommentaryModel(
                  timestamp: DateTime.now(),
                  commentary: getComnByMatchStatus(newMatchStatus),
                  minute: stopwatch.minuteTime.value)
              .toJson());
    });
  }

  String getComnByMatchStatus(String newMatchStatus) {
    if (newMatchStatus == MatchStatus.fHalfStart.name) {
      return "KICK OFF";
    } else if (newMatchStatus == MatchStatus.fHalfEnd.name) {
      return "HALF TIME";
    } else if (newMatchStatus == MatchStatus.sHalfStart.name) {
      return "SECOND HALF";
    } else {
      return "MATCH END";
    }
  }

  updateTimer(String newMatchStatus) {
    if (newMatchStatus == MatchStatus.fHalfStart.name) {
      matchStarted = true;
      stopwatch.onStartTimer();
    } else if (newMatchStatus == MatchStatus.fHalfEnd.name) {
      stopwatch.onStopTimer();
    } else if (newMatchStatus == MatchStatus.sHalfStart.name) {
      stopwatch.onStartTimer();
    } else {
      stopwatch.onStopTimer();
    }
  }

  Widget logoWidget(AddTeamModel teamModel) {
    return Stack(children: [
      teamModel.logoUri == null
          ? Container(
              height: 100,
              color: AppThemeShared.secondaryColor,
              child: Center(
                child: Text(
                  Utility.getInitials(teamModel.name),
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ))
          : CircleAvatar(
              radius: 30,
              child: CachedNetworkImage(
                  imageUrl: teamModel.logoUri!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  // height: 70,
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      )),
            ),
    ]);
  }

  Widget teamScores(AddMatchModel match) {
    return Container(
      height: 200,
      color: AppThemeShared.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoWidget(match.homeTeamModel!),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    match.homeTeamModel!.name,
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          !stopwatch.isRunning
              ? startTimeAndStartButton(match)
              : timerAndScore(match),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoWidget(match.awayTeamModel!),
                Flexible(
                  child: Text(
                    match.awayTeamModel!.name,
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget startTimeAndStartButton(AddMatchModel match) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.33,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Text(
            DateFormat('d LLL, E').format(match.matchDate),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat('h:mm a').format(match.matchDate),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // AppThemeShared.sharedButton(
          //   context: context,
          //   width: 100,
          //   height: 40,
          //   buttonText: "Start",
          //   onTap: () {
          //     matchStarted = true;
          //     setState(() {});

          //     stopwatch.onStartTimer();
          //   },
          // )
        ],
      ),
    );
  }

  Widget timerAndScore(AddMatchModel match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: stopwatch.minuteTime,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final value = snapshot.data;

              return Text(
                value.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  DialogShared.doubleButtonDialog(
                      context, "Are you sure you want to reset timer?", () {
                    stopwatch.onResetTimer();
                    matchStarted = false;
                    setState(() {});
                    Navigator.pop(context);
                  }, () {
                    Navigator.pop(context);
                  });
                },
                icon: const Icon(Icons.restart_alt, color: Colors.white)),
            IconButton(
              color: AppThemeShared.tertiartyColor,
              onPressed: () {
                if (paused) {
                  stopwatch.onStartTimer();
                } else {
                  stopwatch.onStopTimer();
                }
                paused = !paused;
                setState(() {});
              },
              icon: !paused
                  ? const Icon(
                      Icons.pause,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
        ref.watch(currMatchProvider(widget.matchModel)).when(
              data: (data) {
                return Text(
                  "${data.homeTeamScore} - ${data.awayTeamScore}",
                  style: const TextStyle(fontSize: 30),
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            )
      ],
    );
  }

  Widget eventGrid() {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 80),
      children: [
        eventCard("Goal", Icons.sports_football, () {
          Navigator.pushNamed(context, '/goalEvent',
              arguments: widget.matchModel.copyWith(
                  currHalf: 1, currTimer: stopwatch.minuteTime.value));
        }),
        eventCard("Substitution", Icons.sports_football, () {
          Navigator.pushNamed(context, '/substitutionEvent',
              arguments: widget.matchModel.copyWith(
                  currHalf: 1, currTimer: stopwatch.minuteTime.value));
        }),
        eventCard("Yellow Card", Icons.sports_football, () {
          Navigator.pushNamed(context, '/yellowCardEvent',
              arguments: widget.matchModel.copyWith(
                  currHalf: 1, currTimer: stopwatch.minuteTime.value));
        }),
        eventCard("Red Card", Icons.sports_football, () {
          Navigator.pushNamed(context, '/redCardEvent',
              arguments: widget.matchModel.copyWith(
                  currHalf: 1, currTimer: stopwatch.minuteTime.value));
        }),
      ],
    );
  }

  Widget eventCard(String event, IconData icon, void Function() onClicked) {
    return GestureDetector(
      onTap: onClicked,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon),
              Text(event),
            ],
          ),
        ),
      ),
    );
  }

  setPlayerListProvider() async {
    if (ref.read(selectedHomeProvider).isEmpty) {
      for (String id in widget.matchModel.homeLineup!.values) {
        ref
            .read(selectedHomeProvider.notifier)
            .add(await Utility().getPlayerById(id));
      }
      if (widget.matchModel.homeSubstitutes != null) {
        for (String id in widget.matchModel.homeSubstitutes!) {
          ref
              .read(selectedHomeProvider.notifier)
              .add(await Utility().getPlayerById(id));
        }
      }
    }
    if (ref.read(selectedAwayProvider).isEmpty) {
      for (String id in widget.matchModel.awayLineup!.values) {
        ref
            .read(selectedAwayProvider.notifier)
            .add(await Utility().getPlayerById(id));
      }
      if (widget.matchModel.awaySubstitutes != null) {
        for (String id in widget.matchModel.awaySubstitutes!) {
          ref
              .read(selectedAwayProvider.notifier)
              .add(await Utility().getPlayerById(id));
        }
      }
    }
  }

  updateMins() async {
    stopwatch.minuteTime.listen((value) async {
      await FirebaseFirestore.instance
          .collection("Matches")
          .doc(widget.matchModel.id)
          .update({"currTimer": value})
          .then((value) {})
          .onError((error, stackTrace) {});
    });
  }

  updateLeaderboard() async {
    final matchDoc = ref.read(currMatchProvider(widget.matchModel));
    matchDoc.whenData((match) async {
      Map<String, PlayersTournamentModel> map = {};
      AddTournamentModel tournamentModel =
          await Utility().getTournament(widget.matchModel.tournamentId);

      map = Map.fromEntries(tournamentModel.playerStats.entries);

      if (match.homeTeamScore == 0) {
        map.update(
          match.homeLineup!["gk"]!,
          (value) {
            return value.copyWith(noOfCleanSheets: value.noOfCleanSheets + 1);
          },
          ifAbsent: () {
            return PlayersTournamentModel(
                playerId: match.homeLineup!["gk"]!,
                teamId: match.homeTeamId,
                noOfGoals: 0,
                noOfAssists: 0,
                noOfYC: 0,
                noOfRC: 0,
                noOfMatches: 0,
                noOfCleanSheets: 1);
          },
        );
      }
      if (match.awayTeamScore == 0) {
        map.update(
          match.awayLineup!["gk"]!,
          (value) {
            return value.copyWith(noOfCleanSheets: value.noOfCleanSheets + 1);
          },
          ifAbsent: () {
            return PlayersTournamentModel(
                playerId: match.awayLineup!["gk"]!,
                teamId: match.awayTeamId,
                noOfGoals: 0,
                noOfAssists: 0,
                noOfYC: 0,
                noOfRC: 0,
                noOfMatches: 0,
                noOfCleanSheets: 1);
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
    });
  }

  updatePointsTable() async {
    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(widget.matchModel.tournamentId)
        .get()
        .then((value) async {
      AddTournamentModel tournament = AddTournamentModel.fromDocument(value);

      Map<String, TeamPointsModel> map =
          Map<String, TeamPointsModel>.from(tournament.pointsTable);

      final matchDoc = ref.read(currMatchProvider(widget.matchModel));
  
      matchDoc.whenData((matchModel) {
        map.update(
          matchModel.homeTeamId,
          (value) {
            return TeamPointsModel(
                teamId: matchModel.homeTeamId,
                played: value.played + 1,
                wins: matchModel.homeTeamScore > matchModel.awayTeamScore
                    ? value.wins + 1
                    : value.wins,
                lost: matchModel.homeTeamScore < matchModel.awayTeamScore
                    ? value.lost + 1
                    : value.lost,
                draws: matchModel.homeTeamScore == matchModel.awayTeamScore
                    ? value.draws + 1
                    : value.draws,
                goalsScored: value.goalsScored + matchModel.homeTeamScore,
                goalsConceded: value.goalsConceded + matchModel.awayTeamScore,
                playedAgainst: [],
                wonAgainst: [],
                lostAgainst: []);
          },
        );

        map.update(
          matchModel.awayTeamId,
          (value) {
            return TeamPointsModel(
                teamId: matchModel.awayTeamId,
                played: value.played + 1,
                wins: matchModel.awayTeamScore > matchModel.homeTeamScore
                    ? value.wins + 1
                    : value.wins,
                lost: matchModel.awayTeamScore < matchModel.homeTeamScore
                    ? value.lost + 1
                    : value.lost,
                draws: matchModel.awayTeamScore == matchModel.homeTeamScore
                    ? value.draws + 1
                    : value.draws,
                goalsScored: value.goalsScored + matchModel.awayTeamScore,
                goalsConceded: value.goalsConceded + matchModel.homeTeamScore,
                playedAgainst: [],
                wonAgainst: [],
                lostAgainst: []);
          },
        );
      });

      Map<String, Map<String, dynamic>> pTMapFinal = {};

      map.forEach((key, value) {
        pTMapFinal.putIfAbsent(key, () => value.toJson());
      });

      await FirebaseFirestore.instance
          .collection("Tournaments")
          .doc(widget.matchModel.tournamentId)
          .update({"pointsTable": pTMapFinal}).then((value) {
        ref.invalidate(currMatchProvider);
        ref.invalidate(selectedAwayProvider);
        ref.invalidate(selectedHomeProvider);
        Navigator.pushNamed(context, '/dashboardMain');
      }).then((value) {
        Fluttertoast.showToast(msg: "points table updated");
        updateLeaderboard();
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    });
  }
}

enum MatchEvents { goal, substitution, yellowcard, redcard }

enum CardType { fyellow, syellow, red }

final keyEventsProvider =
    StateNotifierProvider<KeyEventsLocal, List<MatchEventModel>>(
  (ref) => KeyEventsLocal(),
);

class KeyEventsLocal extends StateNotifier<List<MatchEventModel>> {
  KeyEventsLocal() : super([]);

  add(MatchEventModel event) {
    state = [...state, event];
  }

  remove(MatchEventModel event) {
    state = [
      for (final todo in state)
        if (todo != event) todo,
    ];
  }

  removeFirst() {
    state.removeAt(0);
  }
}
