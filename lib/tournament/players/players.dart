import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class Players extends ConsumerStatefulWidget {
  AddTeamModel teamModel;
  Players({super.key, required this.teamModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayersState();
}

class _PlayersState extends ConsumerState<Players> {
  bool noPlayerInList = false;
  @override
  Widget build(BuildContext context) {
    final teamModel = ref.watch(currTeamPlayersProvider(widget.teamModel));

    return Scaffold(
      appBar:
          AppThemeShared.appBar(title: widget.teamModel.name, context: context),
      body: teamModel.when(
        data: (teamModel) {
          teamModel.playersId == null
              ? noPlayerInList = true
              : noPlayerInList = false;
          return noPlayerInList
              ? const Center(child: Text("No Players Added"))
              : FutureBuilder<List<PlayerPersonalInfo>>(
                  future: getPlayerFromId(teamModel.playersId!),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            playerCard(snapshot.data!.elementAt(index)),
                      );
                    } else {
                      const Text("jkbnckjsnd");
                    }
                    return const Offstage();
                  },
                );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
          context: context,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          buttonText: "Add",
          onTap: () {
            openContacts();
          }),
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
            addPlayer(value.docs.first.id);
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

  addPlayer(String id) async {
    await FirebaseFirestore.instance
        .collection("Teams")
        .doc(widget.teamModel.id)
        .update({
      "playersId": FieldValue.arrayUnion([id])
    }).then((value) {
      Fluttertoast.showToast(msg: "Player Added");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  Widget playerCard(PlayerPersonalInfo player) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: AppThemeShared.secondaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 40,
                child: player.photoUri == null
                    ? Text(Utility.getInitials(player.name))
                    : CachedNetworkImage(
                        imageUrl: player.photoUri!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          );
                        },
                      ),
              ),
              const SizedBox(width: 8),
              Text(
                player.name,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Text(player.position)
            ],
          ),
        ),
      ),
    );
  }

  Future<List<PlayerPersonalInfo>> getPlayerFromId(
      List<String> playersIdList) async {
    List<PlayerPersonalInfo> players = [];
    for (var id in playersIdList) {
      await FirebaseFirestore.instance
          .collection("Players")
          .doc(id)
          .get()
          .then((value) {
        players.add(PlayerPersonalInfo.fromDocument(value));
      });
    }
    return players;
  }
}
