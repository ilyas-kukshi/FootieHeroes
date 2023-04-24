import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/Scoring/display_key_events.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/display_lineups.dart';
import 'package:footie_heroes/tournament/match_dashboard/sliver_app_bar_match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/matches/matches.dart';
import 'package:footie_heroes/tournament/scoring/commentary_module/display_commentary.dart';
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
  List<Widget> matchNotStartedTabs = [];
  List<Widget> matchNotStartedViews = [];
  List<Widget> lineupAnnouncedTabs = [];
  List<Widget> lineupAnnouncedViews = [];
  List<Widget> matchStartedTabs = [];
  List<Widget> matchStartedViews = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: widget.matchModel.matchStatus == MatchStatus.upcoming.name
            ? widget.matchModel.awayLineup == null
                ? 2
                : 3
            : 5,
        vsync: this);
    matchNotStartedTabs = const [
      Tab(
        text: "Squads",
        height: 50,
      ),
      Tab(
        text: "About",
        height: 50,
      ),
    ];
    matchNotStartedViews = [
      DisplaySquads(matchModel: widget.matchModel),
      Container()
    ];
    lineupAnnouncedTabs = const [
      Tab(
        text: "Squads",
        height: 50,
      ),
      Tab(
        text: "Lineups",
      ),
      Tab(
        text: "About",
        height: 50,
      ),
    ];
    lineupAnnouncedViews = [
      DisplaySquads(matchModel: widget.matchModel),
      DisplayLineUps(matchModel: widget.matchModel),
      Container()
    ];

    matchStartedTabs = const [
      Tab(text: "Key Events", height: 50),
      Tab(
        text: "Lineups",
      ),
      Tab(text: 'Commentary'),
      Tab(
        text: "Squads",
        height: 50,
      ),
      Tab(
        text: "About",
        height: 50,
      ),
    ];
    matchStartedViews = [
      DisplayKeyEvents(matchModel: widget.matchModel),
      DisplayLineUps(matchModel: widget.matchModel),
      DisplayCommentary(matchModel: widget.matchModel),
      DisplaySquads(matchModel: widget.matchModel),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBarMatchMain(matchModel: widget.matchModel),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverPersistentHeaderDelegateTournamentMain(
                  color: AppThemeShared.primaryColor,
                  tabBar: TabBar(
                      // isScrollable: true,
                      indicatorColor: Colors.white,
                      controller: tabController,
                      tabs: widget.matchModel.matchStatus ==
                              MatchStatus.upcoming.name
                          ? widget.matchModel.awayLineup == null
                              ? matchNotStartedTabs
                              : lineupAnnouncedTabs
                          : matchStartedTabs),
                ),
              ),
            ];
          },
          body: TabBarView(
              controller: tabController,
              children:
                  widget.matchModel.matchStatus == MatchStatus.upcoming.name
                      ? widget.matchModel.awayLineup == null
                          ? matchNotStartedViews
                          : lineupAnnouncedViews
                      : matchStartedViews),
        ),
      ),
    );
  }
}

final currHomeTeamPlayersProvider =
    FutureProvider.autoDispose.family<List<PlayerPersonalInfo>, AddTeamModel>(
  (ref, arg) async {
    List<PlayerPersonalInfo> players = [];
    await FirebaseFirestore.instance
        .collection("Teams")
        .doc(arg.id)
        .get()
        .then((value) async {
      AddTeamModel team = AddTeamModel.fromDocument(value);

      if (team.playersId != null) {
        for (var id in team.playersId!) {
          players.add(await Utility().getPlayerById(id));
        }
      }
    });

    return players;
  },
);
final currAwayTeamPlayersProvider =
    FutureProvider.autoDispose.family<List<PlayerPersonalInfo>, AddTeamModel>(
  (ref, arg) async {
    List<PlayerPersonalInfo> players = [];
    await FirebaseFirestore.instance
        .collection("Teams")
        .doc(arg.id)
        .get()
        .then((value) async {
      AddTeamModel team = AddTeamModel.fromDocument(value);

      if (team.playersId != null) {
        for (var id in team.playersId!) {
          players.add(await Utility().getPlayerById(id));
        }
      }
    });

    return players;

    // return stream.map((event) {
    //   AddTeamModel team = AddTeamModel.fromDocument(event);
    //   List<PlayerPersonalInfo> players = [];
    //   if (team.playersId != null)  {
    //     for (var element in team.playersId!) {
    //       players.add(await Utility().getPlayerById(element));
    //     }
    //   }
    // });
  },
);

final currMatchProvider =
    StreamProvider.autoDispose.family<AddMatchModel, AddMatchModel>(
  (ref, arg) {
    final stream = FirebaseFirestore.instance
        .collection("Matches")
        .doc(arg.id)
        .snapshots();

    return stream.map((snapshot) {
      return AddMatchModel.fromDocument(snapshot);
    });
  },
);
