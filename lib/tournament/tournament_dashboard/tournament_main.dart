import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/about.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_team/teams.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/matches/matches.dart';
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
  bool isOrganizer = false;

  List<AddTeamModel> teams = [];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    setOrganzierVariable();
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
        Matches(
            tournamentModel: widget.tournamentAbout, organizer: isOrganizer),
        Container(),
        Container(),
        Teams(tournamentModel: widget.tournamentAbout, organizer: isOrganizer),
        About(
          tournamentModel: widget.tournamentAbout,
        )
      ]),
    ));
  }

  setOrganzierVariable() async {
    if (await Utility().getProfile() == widget.tournamentAbout.organizer) {
      isOrganizer = true;
      setState(() {});
    }
  }
}

class TournamentTeamsState extends StateNotifier<List<AddTeamModel>> {
  final AddTournamentModel tournamentModel;
  TournamentTeamsState(this.tournamentModel) : super(<AddTeamModel>[]) {
    getTeams();
  }

  getTeams() {}
}

final currTournamentTeamsProvider =
    StreamProvider.autoDispose.family<List<AddTeamModel>, AddTournamentModel>(
  (ref, arg) {
    final stream = FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(arg.id)
        .snapshots();

    return stream.map((snapshot) {
      List<AddTeamModel> teams = [];

      for (var team in AddTournamentModel.fromDocument(snapshot).teams!) {
        teams.add(AddTeamModel.fromJson(team));
      }
      return teams;
    });
  },
);

// final currTournamentTeamsProvider =
//     StateProvider.autoDispose.family<List<AddTeamModel>, AddTournamentModel>(
//   (ref, arg) {
//     List<AddTeamModel> teams = [];
//     FirebaseFirestore.instance
//         .collection("Tournaments")
//         .doc(arg.id)
//         .snapshots()
//         .listen((event) {
//       teams.clear();
//       for (var team in AddTournamentModel.fromDocument(event).teams!) {
//         teams.add(AddTeamModel.fromJson(team));
//       }
//     });

//     return teams;
//   },
// );
