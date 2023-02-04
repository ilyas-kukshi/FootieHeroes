import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Matches extends ConsumerStatefulWidget {
  AddTournamentModel tournamentModel;
  bool organizer;
  Matches({super.key, required this.tournamentModel, required this.organizer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchesState();
}

class _MatchesState extends ConsumerState<Matches> {
  @override
  Widget build(BuildContext context) {
    final matches =
        ref.watch(currTournamentMatchesProvider(widget.tournamentModel));
    return matches.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString()),
      data: (matches) {
        return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: matches.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/matchMain",
                      arguments: matches[index]),
                  child: matchCard(matches[index]));
            },
          ),
          bottomNavigationBar: widget.organizer
              ? AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  buttonText: "Add Matches",
                  onTap: () {
                    Navigator.pushNamed(context, '/addMatches',
                        arguments: widget.tournamentModel);
                  })
              : const Offstage(),
        );
      },
    );
  }

  Widget matchCard(AddMatchModel matchModel) {
    return Padding(
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
                      color: matchModel.matchStatus == MatchStatus.Upcoming.name
                          ? Colors.orangeAccent
                          : matchModel.matchStatus == MatchStatus.Live.name
                              ? Colors.green
                              : Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        matchModel.matchStatus,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  logoWidget(matchModel.homeTeam),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(matchModel.homeTeam.name),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  logoWidget(matchModel.awayTeam),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(matchModel.awayTeam.name),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                  "Match Scheduled at ${DateFormat('yyyy-MM-dd – kk:mm a').format(matchModel.matchDate)}")
            ],
          ),
        ),
      ),
    );
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

enum MatchStatus { Upcoming, Live, Completed }
