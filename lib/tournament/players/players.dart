import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';

// ignore: must_be_immutable
class Players extends StatefulWidget {
  AddTeamModel teamModel;
  Players({super.key, required this.teamModel});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppThemeShared.appBar(title: widget.teamModel.name, context: context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tournaments")
            .doc(widget.teamModel.tournamentId)
            .collection("Players")
            .where("teamModel", isEqualTo: widget.teamModel.toJson())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data.docs.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  PlayersTournamentModel player =
                      PlayersTournamentModel.fromDocument(
                          snapshot.data.docs[index]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: AppThemeShared.secondaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              child: player.playerPersonalInfo.photoUri == null
                                  ? Text(Utility.getInitials(
                                      player.playerPersonalInfo.name))
                                  : CachedNetworkImage(
                                      imageUrl:
                                          player.playerPersonalInfo.photoUri!,
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
                            const SizedBox(width: 30),
                            Text(player.playerPersonalInfo.name),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Data"));
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
          context: context,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          buttonText: "Add",
          onTap: () {
            Navigator.pushNamed(context, "/optionsAddPlayers",
                arguments: widget.teamModel);
          }),
    );
  }
}
