import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/lineup_utils.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/set_lineups.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

// ignore: must_be_immutable
class DisplayLineUps extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  DisplayLineUps({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplayLineUpsState();
}

class _DisplayLineUpsState extends ConsumerState<DisplayLineUps>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: AppThemeShared.primaryColor,
              child: TabBar(controller: tabController, tabs: [
                Tab(
                  text: widget.matchModel.homeTeamModel!.name,
                  height: 50,
                ),
                Tab(
                  text: widget.matchModel.awayTeamModel!.name,
                  height: 50,
                )
              ]),
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              viewLineup(
                  widget.matchModel.homeLineup!,
                  widget.matchModel.homeTeamModel!.id!,
                  widget.matchModel.homeSubstitutes),
              viewLineup(
                  widget.matchModel.awayLineup!,
                  widget.matchModel.awayTeamModel!.id!,
                  widget.matchModel.awaySubstitutes)
            ]),
          ),
        ],
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
        context: context,
        height: 50,
        width: MediaQuery.of(context).size.width,
        buttonText: "Start Match",
        onTap: () {
          Navigator.pushNamed(context, "/scoringMain",
              arguments: widget.matchModel);
        },
      ),
    );
  }

  Widget viewLineup(
      Map<String, String> formation, String teamId, List<String>? subs) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
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
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill),
                    formation.containsKey(PositionNames.gk.name)
                        ? lineupPlayer(
                            formation[PositionNames.gk.name]!, PositionNames.gk)
                        : const Offstage(),
                    formation.containsKey(PositionNames.lb.name)
                        ? lineupPlayer(
                            formation[PositionNames.lb.name]!, PositionNames.lb)
                        : const Offstage(),
                    formation.containsKey(PositionNames.rb.name)
                        ? lineupPlayer(
                            formation[PositionNames.rb.name]!, PositionNames.rb)
                        : const Offstage(),
                  ],
                ),
              ),
            ],
          ),
          const Text(
            "Substitues",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          substitutesLV(subs, formation)
        ],
      ),
    );
  }

  Widget lineupPlayer(String playerId, PositionNames pos) {
    return Padding(
      padding: LineUpUtils().getPadding(pos),
      child: Align(
        alignment: LineUpUtils().getAlignment(pos),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("Players")
              .doc(playerId)
              .get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                PlayerPersonalInfo player =
                    PlayerPersonalInfo.fromDocument(snapshot.data);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: player.photoUri == null
                          ? Text(Utility.getInitials(player.name))
                          : CachedNetworkImage(
                              imageUrl: player.photoUri!,
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
                      player.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget substitutesLV(List<String>? subsId, Map<String, String> formation) {
    return subsId == null
        ? const Text("No subs")
        : ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subsId.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Players")
                    .doc(subsId[index])
                    .get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      PlayerPersonalInfo player =
                          PlayerPersonalInfo.fromDocument(snapshot.data);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: AppThemeShared.secondaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: player.photoUri == null
                                      ? Text(Utility.getInitials(player.name))
                                      : CachedNetworkImage(
                                          imageUrl: player.photoUri!,
                                          imageBuilder:
                                              (context, imageProvider) {
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
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            });
  }
}
