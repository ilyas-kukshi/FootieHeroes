// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class OptionsAddPlayers extends StatefulWidget {
  AddTeamModel teamModel;
  OptionsAddPlayers({Key? key, required this.teamModel}) : super(key: key);

  @override
  State<OptionsAddPlayers> createState() => _OptionsAddPlayersState();
}

class _OptionsAddPlayersState extends State<OptionsAddPlayers> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Players", context: context),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Card(child: Text("Add via Phone Number")),
            const SizedBox(height: 10),
            InkWell(
                onTap: () async => Share.share(
                    "Join Team ${widget.teamModel.name} using this link: ${await createJoiningLink()}"),
                child: const Card(child: Text("Add via Team Link"))),
            const SizedBox(height: 10),
            InkWell(
                onTap: () => openContacts(),
                child: const Card(child: Text("Add from Contacts"))),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  openContacts() async {
    try {
      if (await Permission.contacts.request().isGranted) {
        final PhoneContact contact =
            await FlutterContactPicker.pickPhoneContact();

        String phoneNo =
            contact.phoneNumber!.number!.replaceAll(RegExp(r"\s+\b|\b\s"), "");
        if (!phoneNo.startsWith('+')) {
          phoneNo = "+91$phoneNo";
        }
        await FirebaseFirestore.instance
            .collection("Players")
            .where("phoneNo", isEqualTo: phoneNo)
            .get()
            .then((value) {
          if (value.size > 0) {
            addPlayer(value.docs.first);
          } else {
            Fluttertoast.showToast(msg: "Ask user to create an account.");
          }
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(msg: error.toString());
        });
      } else if (await Permission.storage.isPermanentlyDenied ||
          await Permission.storage.isDenied) {
        openAppSettings();
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  addPlayer(DocumentSnapshot documentSnapshot) async {
    PlayerPersonalInfo playerInfo =
        PlayerPersonalInfo.fromDocument(documentSnapshot);
    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(widget.teamModel.tournamentId)
        .collection("Players")
        .doc(playerInfo.id)
        .set(PlayersTournamentModel(
                teamModel: widget.teamModel, playerPersonalInfo: playerInfo)
            .toJson())
        .then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Player Added");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  Future<String> createJoiningLink() async {
    final String url =
        "https://com.example.footie_heroes/Tournaments/Teams/addPlayers?tournamentId=${widget.teamModel.tournamentId}&teamId=${widget.teamModel.id}";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://footheroes.page.link",
        androidParameters: const AndroidParameters(
            packageName: "com.example.footie_heroes", minimumVersion: 0));

    final refLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return refLink.shortUrl.toString();
  }
}
