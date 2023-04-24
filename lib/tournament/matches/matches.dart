import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Matches extends ConsumerStatefulWidget {
  AddTournamentModel tournamentModel;

  Matches({
    super.key,
    required this.tournamentModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchesState();
}

class _MatchesState extends ConsumerState<Matches> {
  @override
  @override
  Widget build(BuildContext context) {
    final matches =
        ref.watch(currTournamentMatchesProvider(widget.tournamentModel));
    final isOrganizer =
        ref.read(isOrganizerProvider(FirebaseAuth.instance.currentUser!.uid));

    return matches.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (matches) {
        return Scaffold(
            body: matches.isEmpty
                ? const Center(child: Text("No matches scheduled"))
                : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: matches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return matchCard(matches[index]);
                    },
                  ),
            bottomNavigationBar: isOrganizer.when(
              data: (data) {
                return data
                    ? AppThemeShared.sharedButton(
                        context: context,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        buttonText: "Add Match",
                        onTap: () => Navigator.pushNamed(context, '/addMatches',
                            arguments: widget.tournamentModel),
                      )
                    : const Offstage();
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ));
      },
    );
  }

  Widget matchCard(AddMatchModel matchModel) {
    late AddTeamModel homeTeamModel;
    late AddTeamModel awayTeamModel;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/matchMain",
          arguments: matchModel.copyWith(
              homeTeamModel: homeTeamModel, awayTeamModel: awayTeamModel)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      matchModel.matchType,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            matchModel.matchStatus == MatchStatus.upcoming.name
                                ? Colors.orangeAccent
                                : matchModel.matchStatus !=
                                            MatchStatus.upcoming.name ||
                                        matchModel.matchStatus !=
                                            MatchStatus.completed.name
                                    ? Colors.green
                                    : Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          matchModel.matchStatus,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<AddTeamModel>(
                      future: Utility().getTeamById(matchModel.homeTeamId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            AddTeamModel homeTeam = snapshot.data;
                            homeTeamModel = homeTeam;
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    logoWidget(homeTeam),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(homeTeam.name),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const Text("");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    timerAndScore(matchModel),
                    FutureBuilder<AddTeamModel>(
                      future: Utility().getTeamById(matchModel.awayTeamId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            AddTeamModel awayTeam = snapshot.data;
                            awayTeamModel = awayTeam;
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    logoWidget(awayTeam),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(awayTeam.name),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const Text("");
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
                matchModel.matchStatus == MatchStatus.upcoming.name
                    ? Column(
                        children: [
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                              "Match Scheduled at ${DateFormat('yyyy-MM-dd – kk:mm a').format(matchModel.matchDate)}")
                        ],
                      )
                    : const Offstage()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget timerAndScore(AddMatchModel match) {
    return ref.watch(currMatchProvider(match)).when(
          data: (data) {
            return data.matchStatus == MatchStatus.upcoming.name
                ? Text(
                    DateFormat('yyyy-MM-dd \n kk:mm a').format(match.matchDate))
                : Column(
                    children: [
                      Text(
                        data.matchStatus == MatchStatus.fHalfEnd.name
                            ? "HALF TIME"
                            : match.matchStatus == MatchStatus.completed.name
                                ? "FULL TIME"
                                : "${data.currTimer}'",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${data.homeTeamScore} - ${data.awayTeamScore}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        );
  }

  Widget logoWidget(AddTeamModel teamModel) {
    return Stack(children: [
      teamModel.logoUri == null
          ? Container(
              height: 100,
              width: 70,
              color: AppThemeShared.secondaryColor,
              child: Center(
                child: Text(
                  Utility.getInitials(teamModel.name),
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ))
          : CircleAvatar(
              radius: 25,
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
}

// ignore: constant_identifier_names
enum MatchStatus {
  upcoming,
  fHalfStart,
  fHalfEnd,
  sHalfStart,
  sHalfEnd,
  completed
}
