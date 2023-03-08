import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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

  @override
  Widget build(BuildContext context) {
    final matchDoc = ref.watch(currMatchProvider(widget.matchModel));

    return Scaffold(
      body: SafeArea(
        child: matchDoc.when(
          data: (match) {
            return SingleChildScrollView(
                child: Column(
              children: [teamScores(widget.matchModel), eventGrid()],
            ));
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // StopWatchTimer.
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
          !matchStarted ? startTimeAndStartButton(match) : timerAndScore(match),
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
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat('h:mm a').format(match.matchDate),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          AppThemeShared.sharedButton(
            context: context,
            width: 100,
            height: 40,
            buttonText: "Start",
            onTap: () {
              matchStarted = true;
              setState(() {});

              stopwatch.onStartTimer();
            },
          )
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
                style: TextStyle(color: Colors.white, fontSize: 16),
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
                  stopwatch.onStartTimer();
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
        const Text(
          "0 - 0",
          style: TextStyle(fontSize: 30),
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
        eventCard("Goal", Icons.sports_football, () {}),
        eventCard("Substitution", Icons.sports_football, () {}),
        eventCard("Yellow Card", Icons.sports_football, () {}),
        eventCard("Red Card", Icons.sports_football, () {}),
      ],
    );
  }

  Widget eventCard(String event, IconData icon, void Function() onClicked) {
    return GestureDetector(
      onTap: () => onClicked,
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
}
