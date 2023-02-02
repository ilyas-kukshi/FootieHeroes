import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  PlayerPersonalInfo? playerPersonalInfo;
  @override
  void initState() {
    super.initState();
    getPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Navigator.pushNamed(context, "/createProfile",
                arguments: playerPersonalInfo),
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("Players")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        playerPersonalInfo?.photoUri != null
                            ? CircleAvatar(
                                radius: 50,
                                child: CachedNetworkImage(
                                  imageUrl: playerPersonalInfo!.photoUri!,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppThemeShared.secondaryColor,
                                      width: 5),
                                  // borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.perm_identity,
                                    color: AppThemeShared.secondaryColor,
                                    size: 50,
                                  ),
                                ),
                              ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Text(playerPersonalInfo!.name),
                            const SizedBox(height: 10),
                            Text(playerPersonalInfo!.phoneNo)
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Divider(
            color: AppThemeShared.primaryColor,
            height: 20,
            thickness: 3,
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: (() => Navigator.pushNamed(context, "/addTournament",
                  arguments: playerPersonalInfo)),
              child: const Text("Add Tournaments")),
          const SizedBox(height: 10),
          Divider(
            color: AppThemeShared.primaryColor,
            height: 20,
            thickness: 1.5,
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: (() => Navigator.pushNamed(context, "/myTournament")),
              child: GestureDetector(
                  onTap: (() => Navigator.pushNamed(context, '/myTournaments')),
                  child: const Text("My Tournaments"))),
          const SizedBox(height: 10),
          Divider(
            color: AppThemeShared.primaryColor,
            height: 20,
            thickness: 1.5,
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: (() async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                await FirebaseAuth.instance.signOut().whenComplete(
                    () => Navigator.pushNamed(context, "/signIn"));
              }),
              child: const Text("Logout")),
          const SizedBox(height: 10),
          Divider(
            color: AppThemeShared.primaryColor,
            height: 20,
            thickness: 1.5,
          ),
        ],
      ),
    ));
  }

  getPersonalInfo() async {
    playerPersonalInfo = await Utility().getUserProfileSP();

    //   await FirebaseFirestore.instance
    //       .collection("Players")
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .get()
    //       .then((value) {
    //     playerPersonalInfo = PlayerPersonalInfo.fromDocument(value);

    //     setState(() {});
    //   }).onError((error, stackTrace) {
    //     Fluttertoast.showToast(msg: error.toString());
    //   });
  }
}
