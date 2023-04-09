import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/points_table/team_points_model.dart';

// ignore: must_be_immutable
class DisplayPointsTable extends ConsumerStatefulWidget {
  AddTournamentModel tournament;
  DisplayPointsTable({super.key, required this.tournament});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DisplayPointsTableState();
}

class _DisplayPointsTableState extends ConsumerState<DisplayPointsTable> {
  List<TeamPointsModel> teamPoints = [];
  @override
  void initState() {
    super.initState();
    for (var element in widget.tournament.pointsTable.values) {
      teamPoints.add(element);
    }

    print(teamPoints);

    teamPoints.sort((a, b) {
      int pointComp = -(a.wins * 3).compareTo(b.wins * 3);
      if (pointComp == 0) {
        return -(a.goalsScored - a.goalsConceded)
            .compareTo(b.goalsScored - b.goalsConceded);
      }
      return pointComp;
    });

    print(teamPoints);
  }

  @override
  Widget build(BuildContext context) {
    return widget.tournament.pointsTable.isEmpty
        ? Center(
            child: AppThemeShared.sharedButton(
              context: context,
              width: 200,
              buttonText: "Generate",
              onTap: () {},
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Table(
                  columnWidths: const {0: FlexColumnWidth(4)},
                  children: const [
                    TableRow(children: [
                      Text("Team"),
                      Text("P"),
                      Text("W"),
                      Text("L"),
                      Text("D"),
                      Text("GD"),
                      Text("PTS"),
                    ]),
                  ],
                ),
                Table(
                  columnWidths: const {0: FlexColumnWidth(4)},
                  children: teamPoints
                      .map((tPModel) => TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: FutureBuilder(
                                future: Utility().getTeamById(tPModel.teamId),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      AddTeamModel team = snapshot.data;
                                      return Text(team.name);
                                    } else {
                                      return Text("No data");
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(tPModel.played.toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(tPModel.wins.toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(tPModel.lost.toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(tPModel.draws.toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                  (tPModel.goalsScored - tPModel.goalsConceded)
                                      .toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text((tPModel.wins * 3).toString()),
                            ),
                          ]))
                      .toList(),
                ),
              ],
            ),
          );
  }
}
