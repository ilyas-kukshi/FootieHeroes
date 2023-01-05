import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournamen.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class MyTournaments extends StatefulWidget {
  const MyTournaments({Key? key}) : super(key: key);

  @override
  State<MyTournaments> createState() => _MyTournamentsState();
}

class _MyTournamentsState extends State<MyTournaments> {
  List<AddTournament> myTournaments = [];
  @override
  void initState() {
    super.initState();

    // initDynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "My Tournaments", context: context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Players")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("My Tournaments")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.size,
                  itemBuilder: (context, index) {
                    AddTournamentModel tournament =
                        AddTournamentModel.fromDocument(
                            snapshot.data.docs[index]);
                    return tournamentCard(tournament);
                  });
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget tournamentCard(AddTournamentModel tournament) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/tournamentMain", arguments: tournament);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  height: 150,
                  imageUrl: tournament.bannerUri,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        tournament.name,
                        style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${DateFormat.yMMMMd().format(tournament.startDate)}  To  ${DateFormat.yMMMMd().format(tournament.endDate)}",
                        style: const TextStyle(
                          letterSpacing: 1.5,
                        ),
                      )
                    ],
                  ),
                  AppThemeShared.sharedButton(
                      context: context,
                      width: 100,
                      height: 20,
                      buttonText: "Share",
                      onTap: () {
                        Utility().createLink(tournament.id!).then((value) {
                          Share.share(value.toString());
                        });
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
