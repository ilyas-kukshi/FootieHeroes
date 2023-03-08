import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';

// ignore: must_be_immutable
class DisplaySquads extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  DisplaySquads({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplaySquadsState();
}

class _DisplaySquadsState extends ConsumerState<DisplaySquads> {
  bool noHomeTeamPlayers = false;
  bool noAwayTeamPlayers = false;

  List<PlayerPersonalInfo> homePlayersQ = [];
  List<PlayerPersonalInfo> awayPlayersQ = [];

  int requiredPlayers = 0;

  @override
  void initState() {
    super.initState();
    requiredPlayers =
        widget.matchModel.startingPlayers + widget.matchModel.noOfSubs;
  }

  @override
  Widget build(BuildContext context) {
    final homePlayersList = ref
        .watch(currHomeTeamPlayersProvider(widget.matchModel.homeTeamModel!));
    final awayPlayersList = ref
        .watch(currAwayTeamPlayersProvider(widget.matchModel.awayTeamModel!));
    final isOrganizer =
        ref.read(isOrganizerProvider(FirebaseAuth.instance.currentUser!.uid));
    homePlayersQ = ref.watch(selectedHomeProvider);
    awayPlayersQ = ref.watch(selectedAwayProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            "Select atleast ${widget.matchModel.startingPlayers} and max $requiredPlayers players from each team",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: homePlayersList.when(
                  data: (homePlayers) {
                    return homePlayers.isEmpty
                        ? const Text("No player Added")
                        : ListView.builder(
                            itemCount: homePlayers.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  isOrganizer.when(
                                    data: (data) {
                                      if (data) {
                                        selectAwayTeam(homePlayers[index]);
                                      }
                                    },
                                    error: (error, stackTrace) =>
                                        Text(error.toString()),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                  );
                                },
                                child: playerCard(homePlayers[index]),
                              );
                            },
                          );
                    // homeTeamModel.playersId == null
                    //     ? noHomeTeamPlayers = true
                    //     : noHomeTeamPlayers = false;
                    // return noHomeTeamPlayers
                    //     ? const Center(child: Text("No Players Added"))
                    //     : FutureBuilder<List<PlayerPersonalInfo>>(
                    //         future: getPlayerFromId(homeTeamModel.playersId!),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //                   ConnectionState.done &&
                    //               snapshot.hasData) {
                    //             return ListView.builder(
                    //               padding: const EdgeInsets.all(0),
                    //               itemCount: snapshot.data!.length,
                    //               shrinkWrap: true,
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               itemBuilder: (context, index) =>
                    //                   GestureDetector(
                    //                 onTap: () {
                    //                   isOrganizer.when(
                    //                     data: (data) {
                    //                       if (data) {
                    //                         selectHomeTeam(snapshot.data!
                    //                             .elementAt(index));
                    //                       }
                    //                     },
                    //                     error: (error, stackTrace) =>
                    //                         Text(error.toString()),
                    //                     loading: () =>
                    //                         const CircularProgressIndicator(),
                    //                   );
                    //                 },
                    //                 child: playerCard(
                    //                     snapshot.data!.elementAt(index)),
                    //               ),
                    //             );
                    //           } else {
                    //             const Text("jkbnckjsnd");
                    //           }
                    //           return const Offstage();
                    //         });
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: awayPlayersList.when(
                  data: (awayPlayers) {
                    return awayPlayers.isEmpty
                        ? const Text("No player Added")
                        : ListView.builder(
                            itemCount: awayPlayers.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  isOrganizer.when(
                                    data: (data) {
                                      if (data) {
                                        selectAwayTeam(awayPlayers[index]);
                                      }
                                    },
                                    error: (error, stackTrace) =>
                                        Text(error.toString()),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                  );
                                },
                                child: playerCard(awayPlayers[index]),
                              );
                            },
                          );

                    // awayTeamModel.playersId == null
                    //     ? noHomeTeamPlayers = true
                    //     : noHomeTeamPlayers = false;
                    // return noHomeTeamPlayers
                    //     ? const Center(child: Text("No Players Added"))
                    //     : FutureBuilder<List<PlayerPersonalInfo>>(
                    //         future: getPlayerFromId(awayTeamModel.playersId!),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //                   ConnectionState.done &&
                    //               snapshot.hasData) {
                    //             return ListView.builder(
                    //               padding: const EdgeInsets.all(0),
                    //               itemCount: snapshot.data!.length,
                    //               shrinkWrap: true,
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               itemBuilder: (context, index) =>
                    //                   GestureDetector(
                    //                 onTap: () {
                    //                   isOrganizer.when(
                    //                     data: (data) {
                    //                       if (data) {
                    //                         selectAwayTeam(snapshot.data!
                    //                             .elementAt(index));
                    //                       }
                    //                     },
                    //                     error: (error, stackTrace) =>
                    //                         Text(error.toString()),
                    //                     loading: () =>
                    //                         const CircularProgressIndicator(),
                    //                   );
                    //                 },
                    //                 child: playerCard(
                    //                     snapshot.data!.elementAt(index)),
                    //               ),
                    //             );
                    //           } else {
                    //             const Text("jkbnckjsnd");
                    //           }
                    //           return const Offstage();
                    //         });
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isOrganizer.when(
        data: (data) {
          return data
              ? AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  buttonText: "Start Scoring",
                  onTap: () {
                    if (homePlayersQ.length >=
                            widget.matchModel.startingPlayers &&
                        homePlayersQ.length <= requiredPlayers) {
                      if (awayPlayersQ.length >=
                              widget.matchModel.startingPlayers &&
                          awayPlayersQ.length <= requiredPlayers) {
                        Navigator.pushNamed(context, '/setLineups',
                            arguments: widget.matchModel);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Select required amount of players.");
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select required amount of players.");
                    }
                  })
              : const Offstage();
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }

  Widget playerCard(PlayerPersonalInfo player) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppThemeShared.secondaryColor)),
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
        homePlayersQ.contains(player) || awayPlayersQ.contains(player)
            ? Center(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: BoxDecoration(
                      color: AppThemeShared.secondaryColor.withOpacity(0.6)),
                  child: const Center(
                    child: Icon(
                      Icons.done,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const Offstage(),
      ],
    );
  }

  selectHomeTeam(PlayerPersonalInfo player) {
    if (ref.read(selectedHomeProvider).contains(player)) {
      ref.read(selectedHomeProvider.notifier).remove(player);
    } else if (ref.read(selectedHomeProvider).length < requiredPlayers) {
      ref.read(selectedHomeProvider.notifier).add(player);
    } else {
      ref.read(selectedHomeProvider.notifier).removeFirst();
      ref.read(selectedHomeProvider.notifier).add(player);
    }
    // setState(() {});
  }

  selectAwayTeam(PlayerPersonalInfo player) {
    if (ref.read(selectedAwayProvider).contains(player)) {
      ref.read(selectedAwayProvider.notifier).remove(player);
    } else if (ref.read(selectedAwayProvider).length < requiredPlayers) {
      ref.read(selectedAwayProvider.notifier).add(player);
    } else {
      ref.read(selectedAwayProvider.notifier).removeFirst();
      ref.read(selectedAwayProvider.notifier).add(player);
    }
    setState(() {});
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

final selectedHomeProvider = StateNotifierProvider.autoDispose<
    SelectHomePlayers, List<PlayerPersonalInfo>>(
  (ref) => SelectHomePlayers(),
);

// final selectedHomeProvider =
//     StateNotifierProvider<SelectHomePlayers, Queue<PlayerPersonalInfo>>((ref) {
//   return SelectHomePlayers();
// });
final selectedAwayProvider = StateNotifierProvider.autoDispose<
    SelectHomePlayers, List<PlayerPersonalInfo>>(
  (ref) => SelectHomePlayers(),
);

class SelectHomePlayers extends StateNotifier<List<PlayerPersonalInfo>> {
  SelectHomePlayers() : super([]);

  add(PlayerPersonalInfo player) {
    state = [...state, player];
  }

  remove(PlayerPersonalInfo player) {
    state = [
      for (final todo in state)
        if (todo != player) todo,
    ];
  }

  removeFirst() {
    state.removeAt(0);
  }
}
