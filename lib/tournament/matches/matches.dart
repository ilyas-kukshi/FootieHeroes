import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:intl/intl.dart';

class Matches extends StatefulWidget {
  AddTournamentModel tournamentModel;
  bool organizer;
  Matches({super.key, required this.tournamentModel, required this.organizer});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tournaments")
            .doc(widget.tournamentModel.id)
            .collection("Matches")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (snapshot.data.size > 0) {
                return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int index) {
                    AddMatchModel matchModel =
                        AddMatchModel.fromDocument(snapshot.data.docs[index]);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                matchModel.matchType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                  },
                );
              } else {
                return Text("No Data");
              }
            } else {
              return Text("No Data");
            }
          } else {
            return const CircularProgressIndicator();
          }
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
