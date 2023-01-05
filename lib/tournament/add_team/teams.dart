import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_bottom_sheet.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';

// ignore: must_be_immutable
class Teams extends StatefulWidget {
  AddTournamentModel tournamentModel;
  Teams({super.key, required this.tournamentModel});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  late AddTeamModel teamModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tournaments")
            .doc(widget.tournamentModel.id)
            .collection("Teams")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: snapshot.data.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 220),
                itemBuilder: (context, index) {
                  teamModel =
                      AddTeamModel.fromDocument(snapshot.data.docs[index]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          logoWidget(teamModel),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              teamModel.name,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            teamModel.townName,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("No Teams yet, add Teams");
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppThemeShared.sharedButton(
            context: context,
            width: MediaQuery.of(context).size.width,
            height: 50,
            buttonText: "Add Team",
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddTeamBottomSheet(
                        tournamentModel: widget.tournamentModel,
                      ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))));
            }),
      ),
    );
  }

  removeTeam(String docId) async {
    DialogShared.doubleButtonDialog(context,
        "Are you sure you want to remove this team from the tournament.",
        () async {
      await FirebaseFirestore.instance
          .collection("Tournaments")
          .doc(widget.tournamentModel.id)
          .collection("Teams")
          .doc(docId)
          .delete()
          .then((value) {
        Fluttertoast.showToast(msg: "Team Removed");
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }, () {
      Navigator.pop(context);
    });
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
          : SizedBox(
              height: 100,
              // width:
              // MediaQuery.of(context).size.width * 0.28,
              child: CachedNetworkImage(
                imageUrl: teamModel.logoUri!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                // height: 70,
                fit: BoxFit.fill,
              ),
            ),
      Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: (() => removeTeam(teamModel.id!)),
          child: CircleAvatar(
            backgroundColor: AppThemeShared.primaryColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
