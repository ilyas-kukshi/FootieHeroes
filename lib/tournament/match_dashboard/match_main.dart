import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/match_dashboard/sliver_app_bar_match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tab_bar/sliver_persistent_header_delegate.dart';

// ignore: must_be_immutable
class MatchMain extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  MatchMain({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchMainState();
}

class _MatchMainState extends ConsumerState<MatchMain>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBarMatchMain(matchModel: widget.matchModel),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentHeaderDelegateTournamentMain(
              color: AppThemeShared.primaryColor,
              tabBar: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Squads",
                      height: 50,
                    ),

                    
                    Text("About"),
                  ]),
            ),
          ),
        ];
      },
      body: TabBarView(controller: tabController, children: [
        DisplaySquads(matchModel: widget.matchModel),
        Container()
      ]),

      // bottomNavigationBar: ,
    ));
  }
}

final currHomeTeamPlayersProvider = StreamProvider.autoDispose
    .family<List<PlayersTournamentModel>, AddTeamModel>(
  (ref, arg) {
    final stream = FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(arg.tournamentId)
        .collection("Players")
        .where("teamModel", isEqualTo: arg.toJson())
        .snapshots();

    return stream.map((event) {
      List<PlayersTournamentModel> homeTeamPlayers = [];
      if (event.size > 0) {
        for (var element in event.docs) {
          homeTeamPlayers.add(PlayersTournamentModel.fromDocument(element));
        }
      }
      return homeTeamPlayers;
    });
  },
);
final currAwayTeamPlayersProvider = StreamProvider.autoDispose
    .family<List<PlayersTournamentModel>, AddTeamModel>(
  (ref, arg) {
    final stream = FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(arg.tournamentId)
        .collection("Players")
        .where("teamModel", isEqualTo: arg.toJson())
        .snapshots();

    return stream.map((event) {
      List<PlayersTournamentModel> homeTeamPlayers = [];
      if (event.size > 0) {
        for (var element in event.docs) {
          homeTeamPlayers.add(PlayersTournamentModel.fromDocument(element));
        }
      }
      return homeTeamPlayers;
    });
  },
);

final currMatchProvider =
    StreamProvider.autoDispose.family<AddMatchModel, AddMatchModel>(
  (ref, arg) {
    final stream = FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(arg.tournamentId)
        .collection("Matches")
        .doc(arg.id)
        .snapshots();

    return stream.map((snapshot) {
      return AddMatchModel.fromDocument(snapshot);
    });
  },
);
