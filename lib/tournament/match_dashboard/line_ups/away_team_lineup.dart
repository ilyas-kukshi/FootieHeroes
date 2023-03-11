import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/lineup_utils.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/set_lineups.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

// ignore: must_be_immutable
class AwayTeamLineUp extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  List<PlayerPersonalInfo> players;
  AwayTeamLineUp({super.key, required this.matchModel, required this.players});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AwayTeamLineUpState();
}

class _AwayTeamLineUpState extends ConsumerState<AwayTeamLineUp>
    with AutomaticKeepAliveClientMixin {
  Map<String, String> formation = {"gk": "", "lb": "", "rb": ""};

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          AppThemeShared.sharedDropDown(
            context: context,
            items: ["1-2"],
            onChanged: (p0) {},
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                192 -
                kToolbarHeight -
                60 -
                54,
            decoration: const BoxDecoration(color: Colors.green),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/lineup.png",
                    width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
                formation.containsKey(PositionNames.gk.name)
                    ? lineupPlayer(PositionNames.gk)
                    : const Offstage(),
                formation.containsKey(PositionNames.lb.name)
                    ? lineupPlayer(PositionNames.lb)
                    : const Offstage(),
                formation.containsKey(PositionNames.rb.name)
                    ? lineupPlayer(PositionNames.rb)
                    : const Offstage(),
              ],
            ),
          ),
          LineUpUtils().playersListView(widget.players),
        ],
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
        context: context,
        height: 50,
        width: MediaQuery.of(context).size.width,
        buttonText: "Save",
        onTap: () {
          Set d = Set.from(formation.values);

          if (formation.containsValue("")) {
            Fluttertoast.showToast(msg: "All positions are not filled");
          } else if (d.length < widget.matchModel.startingPlayers) {
            Fluttertoast.showToast(
                msg: "Same players are set at multiple positions");
          } else {
            saveLineUp();
          }
        },
      ),
    );
  }

  Widget lineupPlayer(PositionNames pos) {
    PlayerPersonalInfo? player;
    return Padding(
      padding: LineUpUtils().getPadding(pos),
      child: Align(
        alignment: LineUpUtils().getAlignment(pos),
        child: DragTarget<PlayerPersonalInfo>(
          builder: (context, candidateData, rejectedData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                formation[pos.name] != "" && player != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: player!.photoUri == null
                                ? Text(Utility.getInitials(player!.name))
                                : CachedNetworkImage(
                                    imageUrl: player!.photoUri!,
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
                          const SizedBox(height: 8),
                          Text(
                            player!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : const CircleAvatar(
                        radius: 25,
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
              ],
            );
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            formation[pos.name] = data.id!;
            player = data;
          },
        ),
      ),
    );
  }

  saveLineUp() async {
    List<String> subsId = [];
    for (var element in widget.players) {
      if (!formation.containsValue(element.id)) {
        subsId.add(element.id!);
      }
    }
    try {
      await FirebaseFirestore.instance
          .collection("Matches")
          .doc(widget.matchModel.id)
          .update({"awayLineup": formation, "awaySubstitutes": subsId}).then(
              (value) {
        ref.read(awayLineupDoneProvider.notifier).state = true;
        if (ref.read(homeLineupDoneProvider.notifier).state) {
          Navigator.pushNamed(context, "/dashboardMain");
        } else {}
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  bool get wantKeepAlive => true;
}
