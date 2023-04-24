// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';

// ignore: must_be_immutable
class LeaderboardMain extends ConsumerStatefulWidget {
  AddTournamentModel tournamentModel;
  LeaderboardMain({super.key, required this.tournamentModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderboardMainState();
}

class _LeaderboardMainState extends ConsumerState<LeaderboardMain> {
  List<PlayersTournamentModel> goalLeaders = [];
  List<PlayersTournamentModel> assistLeaders = [];
  List<PlayersTournamentModel> csLeaders = [];

  List<PlayersTournamentModel> ycLeaders = [];
  List<PlayersTournamentModel> rcLeaders = [];

  @override
  void initState() {
    super.initState();

    for (var element in widget.tournamentModel.playerStats.entries) {
      if (element.value.noOfGoals > 0) {
        goalLeaders.add(element.value);
      }
      if (element.value.noOfAssists > 0) {
        assistLeaders.add(element.value);
      }
      if (element.value.noOfCleanSheets > 0) {
        csLeaders.add(element.value);
      }
      if (element.value.noOfYC > 0) {
        ycLeaders.add(element.value);
      }
      if (element.value.noOfRC > 0) {
        rcLeaders.add(element.value);
      }
    }

    goalLeaders.sort((b, a) => a.noOfGoals.compareTo(b.noOfGoals));
    assistLeaders.sort((b, a) => a.noOfAssists.compareTo(b.noOfAssists));
    csLeaders.sort((b, a) => a.noOfCleanSheets.compareTo(b.noOfCleanSheets));
    ycLeaders.sort((b, a) => a.noOfYC.compareTo(b.noOfYC));
    rcLeaders.sort((b, a) => a.noOfRC.compareTo(b.noOfRC));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: TabBar(
                  padding: const EdgeInsets.all(0),
                  unselectedLabelColor: AppThemeShared.primaryColor,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  // indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppThemeShared.primaryColor),
                  tabs: [
                    Tab(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: AppThemeShared.primaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Goals"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: AppThemeShared.primaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Assists"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: AppThemeShared.primaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Clean Sheets",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: AppThemeShared.primaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Yellow"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: AppThemeShared.primaryColor, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Red"),
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(children: [
                listView(goalLeaders, "Goals"),
                listView(assistLeaders, "Assists"),
                listView(csLeaders, "CS"),
                listView(ycLeaders, "Yellow"),
                listView(rcLeaders, "Red"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget listView(List<PlayersTournamentModel> list, String type) {
  return ListView.builder(
    itemCount: list.length,
    padding: const EdgeInsets.all(0),
    itemBuilder: (BuildContext context, int index) {
      return FutureBuilder<PlayerPersonalInfo>(
        future: Utility().getPlayerById(list[index].playerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              PlayerPersonalInfo player = snapshot.data!;
              return playerCard(player, list[index], index, type);
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    },
  );
}

Widget playerCard(
    PlayerPersonalInfo player, PlayersTournamentModel stats, int index, type) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
    child: Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppThemeShared.secondaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (++index).toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: player.photoUri == null
                        ? Text(Utility.getInitials(player.name))
                        : CachedNetworkImage(
                            imageUrl: player.photoUri!,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              );
                            },
                          ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        player.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        player.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              type == StatsType.Goals.name
                  ? "${stats.noOfGoals.toString()} $type "
                  : type == StatsType.Assists.name
                      ? "${stats.noOfAssists.toString()} $type "
                      : type == StatsType.CS.name
                          ? "${stats.noOfCleanSheets.toString()} $type "
                          : type == StatsType.Yellow.name
                              ? "${stats.noOfYC.toString()} $type "
                              : "${stats.noOfRC.toString()} $type ",
              style: TextStyle(
                  color: AppThemeShared.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

enum StatsType {
  Goals,
  Assists,
  CS,
  Yellow,
  Red,
}
