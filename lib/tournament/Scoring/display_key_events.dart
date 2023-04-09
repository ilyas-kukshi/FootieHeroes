import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/Scoring/scoring_main.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

class DisplayKeyEvents extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  DisplayKeyEvents({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DisplayKeyEventsState();
}

class _DisplayKeyEventsState extends ConsumerState<DisplayKeyEvents> {
  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];

  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);
    return ref.watch(currMatchProvider(widget.matchModel)).when(
          data: (data) {
            if (data.keyEvents != null) {
              List<MatchEventModel> reversedList = [];
              for (var element in data.keyEvents!.reversed) {
                reversedList.add(element);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.keyEvents!.length,
                  itemBuilder: (BuildContext context, int index) {
                    MatchEventModel matchEvent = reversedList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment:
                            matchEvent.teamId == widget.matchModel.homeTeamId
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                        children: [
                          matchEvent.event == MatchEvents.goal.name
                              ? goalEventCard(matchEvent)
                              : matchEvent.event ==
                                      MatchEvents.substitution.name
                                  ? substitutionEventCard(matchEvent)
                                  : matchEvent.event ==
                                              MatchEvents.yellowcard.name ||
                                          matchEvent.event ==
                                              MatchEvents.redcard.name
                                      ? cardEvent(matchEvent)
                                      : const Offstage()
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Offstage();
            }
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        );
  }

  // eventCard(MatchEventModel matchEvent) {
  //   return Row(
  //     mainAxisAlignment: matchEvent.teamId == widget.matchModel.homeTeamId ?
  //     MainAxisAlignment.start : MainAxisAlignment.end,
  //     children: [

  //     ],
  //   );
  // }
  Widget goalEventCard(MatchEventModel matchEvent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        matchEvent.teamId == widget.matchModel.homeTeamId
            ? Center(child: Text("${matchEvent.minute}' "))
            : goalAndAssistBy(matchEvent),
        const SizedBox(width: 8),
        const Icon(Icons.sports_soccer, color: Colors.green),
        const SizedBox(width: 8),
        matchEvent.teamId == widget.matchModel.homeTeamId
            ? goalAndAssistBy(matchEvent)
            : Center(child: Text("${matchEvent.minute}' "))
      ],
    );
  }

  Widget substitutionEventCard(MatchEventModel matchEvent) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      matchEvent.teamId == widget.matchModel.homeTeamId
          ? Center(child: Text("${matchEvent.minute}' "))
          : substituteInOut(matchEvent),
      const SizedBox(width: 8),
      Image.asset(
        "assets/images/keyevents/playersubstitution.png",
        height: 30,
      ),
      const SizedBox(width: 8),
      matchEvent.teamId == widget.matchModel.homeTeamId
          ? substituteInOut(matchEvent)
          : Center(child: Text("${matchEvent.minute}' "))
    ]);
  }

  Widget cardEvent(MatchEventModel matchEvent) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      matchEvent.teamId == widget.matchModel.homeTeamId
          ? Center(child: Text("${matchEvent.minute}' "))
          : cardedPlayer(matchEvent),
      const SizedBox(width: 8),
      Image.asset(
        matchEvent.cardType == CardType.fyellow.name
            ? "assets/images/keyevents/yellowcard.png"
            : "assets/images/keyevents/redcard.png",
        height: 30,
      ),
      const SizedBox(width: 8),
      matchEvent.teamId == widget.matchModel.homeTeamId
          ? cardedPlayer(matchEvent)
          : Center(child: Text("${matchEvent.minute}' "))
    ]);
  }

  goalAndAssistBy(MatchEventModel matchEvent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<PlayerPersonalInfo>(
            future: Utility().getPlayerById(matchEvent.scoredBy!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // PlayerPersonalInfo scoredBy = PlayerPersonalInfo.fromDocument(snapshot)
                return Text(snapshot.data!.name);
              } else {
                return const CircularProgressIndicator();
              }
            }),
        matchEvent.assistedBy != null
            ? FutureBuilder<PlayerPersonalInfo>(
                future: Utility().getPlayerById(matchEvent.assistedBy!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // PlayerPersonalInfo scoredBy = PlayerPersonalInfo.fromDocument(snapshot)
                    return Text(
                      "Assist:${snapshot.data!.name}",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
            : const Offstage()
      ],
    );
  }

  substituteInOut(MatchEventModel matchEvent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<PlayerPersonalInfo>(
            future: Utility().getPlayerById(matchEvent.playerIn!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // PlayerPersonalInfo scoredBy = PlayerPersonalInfo.fromDocument(snapshot)
                return Text(snapshot.data!.name);
              } else {
                return const CircularProgressIndicator();
              }
            }),
        FutureBuilder<PlayerPersonalInfo>(
            future: Utility().getPlayerById(matchEvent.playerOut!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // PlayerPersonalInfo scoredBy = PlayerPersonalInfo.fromDocument(snapshot)
                return Text(
                  "${snapshot.data!.name}",
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
      ],
    );
  }

  Widget cardedPlayer(MatchEventModel matchEvent) {
    return FutureBuilder<PlayerPersonalInfo>(
        future: Utility().getPlayerById(matchEvent.playerCarded!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // PlayerPersonalInfo scoredBy = PlayerPersonalInfo.fromDocument(snapshot)
            return Text(snapshot.data!.name);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
