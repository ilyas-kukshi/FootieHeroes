
import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/add_team/teams.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tab_bar/sliver_app_bar_tournament_main.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tab_bar/sliver_persistent_header_delegate.dart';

// ignore: must_be_immutable
class TournamentMain extends StatefulWidget {
  AddTournamentModel tournamentAbout;
  TournamentMain({Key? key, required this.tournamentAbout}) : super(key: key);

  @override
  State<TournamentMain> createState() => _TournamentMainState();
}

class _TournamentMainState extends State<TournamentMain>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBarTournamentMain(tournamentAbout: widget.tournamentAbout),
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
                      text: "Matches",
                      height: 50,
                    ),

                    // Text(
                    //   'Matches',

                    // ),
                    Text("Leaderboard"),
                    Text('Points Table'),
                    Text('Teams'),
                    Text("About")
                  ]),
            ),
          ),
        ];
      },
      body: TabBarView(controller: tabController, children: [
        Container(),
        Container(),
        Container(),
        Teams(tournamentModel: widget.tournamentAbout),
        Container()
      ]),
    ));
  }
}
