import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your name";
    }
    return null;
  }

  static String? categoryNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productPriceValidator(String? name) {
    if (name!.isEmpty) {
      return "Please enter your product price";
    }
    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber?.length != 10 ||
        int.tryParse(phoneNumber.toString()) == null) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordLengthValidator(String? password) {
    if (password!.length < 6) {
      return 'Pleas enter a valid phone number';
    }
    return null;
  }

  static String? passwordSameValidator(
      String? setPassword, String? confirmPassword) {
    if (confirmPassword!.length < 6) {
      return 'Pleas enter a valid phone number';
    } else if (setPassword != confirmPassword) {
      return 'Both passwords should be same';
    }
    return null;
  }

  static String? otpValidator(String? otp) {
    if (otp!.length != 6) {
      return 'Pleas enter a valid otp';
    }
    return null;
  }

  static String? shopNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop name";
    }
    return null;
  }

  static String? shopLocationValidator(String? name) {
    if (name!.isEmpty) {
      return " Please set your shop location";
    }
    return null;
  }

  static String? shopAddressValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop address";
    }
    return null;
  }

  Future<bool> userLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> userProfileComplete() async {
    bool complete = false;
    await FirebaseFirestore.instance
        .collection("Players")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        complete = true;
        // Navigator.pushNamed(context, "/dashboardMain");
      } else {
        complete = false;
        // Navigator.pushNamed(context, '/createProfile');
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      complete = false;
    });
    return complete;
  }

  static String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';

  Future<DateTime?> selectDate(BuildContext context, DateTime initalDate,
      DateTime firstDate, DateTime lastDate) async {
    return await showDatePicker(
        context: context,
        initialDate: initalDate,
        firstDate: firstDate,
        lastDate: lastDate);
  }

////SharedPreferences
  setUserProfileSP(PlayerPersonalInfo personalInfo) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String data = jsonEncode(personalInfo);
    shared.setString("playerPersonalInfo", data);
  }

  Future<PlayerPersonalInfo> getUserProfileSP() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // PlayerPersonalInfo personalInfo = PlayerPersonalInfo.fromJson(

    String j = pref.getString("playerPersonalInfo")!;

    Map<String, dynamic> valid = jsonDecode(j);

    PlayerPersonalInfo playerPersonalInfo = PlayerPersonalInfo.fromJson(valid);
    return playerPersonalInfo;
  }

  /// Dynamic Links
  Future<Uri> createLink(String refCode) async {
    final String url =
        "https://com.example.footie_heroes/tournaments?ref=$refCode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://footheroes.page.link",
        androidParameters: const AndroidParameters(
            packageName: "com.example.footie_heroes", minimumVersion: 0));

    final refLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return refLink.shortUrl;
  }

  Future<void> initDynamicLink(BuildContext context) async {
    // final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    FirebaseDynamicLinks.instance.onLink.listen((instanceLink) async {
      List<String> pathSegments = instanceLink.link.pathSegments;

      if (instanceLink.link.queryParameters.isNotEmpty) {
        if (pathSegments.last == 'addPlayers') {
          if (await userLoggedIn() && await userProfileComplete()) {
            await FirebaseFirestore.instance
                .collection("Players")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((value) {
              addPlayer(context, value, instanceLink.link.queryParameters);
            }).onError((error, stackTrace) {
              Fluttertoast.showToast(msg: error.toString());
            });
          }
        } else if (pathSegments.last == 'Tournaments') {
          String id = instanceLink.link.queryParameters["ref"]!;
          AddTournamentModel addTournamentModel;
          await FirebaseFirestore.instance
              .collection("Tournaments")
              .doc(id)
              .get()
              .then((value) {
            if (value.exists) {
              addTournamentModel = AddTournamentModel.fromDocument(value);
              Navigator.pushNamed(context, "/tournamentMain",
                  arguments: addTournamentModel);
            } else {
              Fluttertoast.showToast(msg: "Tournament was deleted.");
            }
          }).onError((error, stackTrace) {
            Fluttertoast.showToast(msg: error.toString());
          });
        }
      }
    });
  }

  addPlayer(BuildContext context, DocumentSnapshot documentSnapshot,
      Map<String, String> paths) async {
    PlayerPersonalInfo playerInfo =
        PlayerPersonalInfo.fromDocument(documentSnapshot);
    AddTeamModel teamModel = await getTeamModel(paths);
    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(paths["tournamentId"])
        .collection("Players")
        .doc(playerInfo.id)
        .set(PlayersTournamentModel(
                teamModel: teamModel, playerPersonalInfo: playerInfo)
            .toJson())
        .then((value) {
      Navigator.pushNamed(context, "/players", arguments: teamModel);
      Fluttertoast.showToast(msg: "Player Added");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  Future<AddTeamModel> getTeamModel(Map<String, String> paths) async {
    late AddTeamModel addTeamModel;
    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(paths["tournamentId"])
        .collection("Teams")
        .doc(paths["teamId"])
        .get()
        .then((value) {
      addTeamModel = AddTeamModel.fromDocument(value);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });

    return addTeamModel;
  }

  Future<PlayerPersonalInfo> getProfile() async {
    late PlayerPersonalInfo playerPersonalInfo;
    await FirebaseFirestore.instance
        .collection("Players")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        playerPersonalInfo = PlayerPersonalInfo.fromDocument(value);
        // Navigator.pushNamed(context, "/dashboardMain");
      } else {
        // Navigator.pushNamed(context, '/createProfile');
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
    return playerPersonalInfo;
  }
}
