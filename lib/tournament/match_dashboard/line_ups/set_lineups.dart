import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/away_team_lineup.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/home_team_lineup.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

// ignore: must_be_immutable
class SetLineUps extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  SetLineUps({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetLineUpsState();
}

class _SetLineUpsState extends ConsumerState<SetLineUps>
    with SingleTickerProviderStateMixin {
  List<PlayerPersonalInfo> homePlayers = [];

  List<PlayerPersonalInfo> awayPlayers = [];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
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
            Expanded(
              child: TabBarView(controller: tabController, children: [
                HomeTeamLineUp(
                    matchModel: widget.matchModel, players: homePlayers),
                AwayTeamLineUp(
                    matchModel: widget.matchModel, players: awayPlayers),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget setLineup(List<PlayerPersonalInfo> players, AddMatchModel matchModel) {
    return Column(
      children: [
        // LineupCard(
        //   formation: {"GK": "", "RB": "", "LB": ""},
        // ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: players.length,
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Draggable<PlayerPersonalInfo>(
                  data: players[index],
                  feedback: playerCardLV(players[index]),
                  child: playerCardLV(players[index]));
            },
          ),
        ),
      ],
    );
  }

  Widget playerCardLV(PlayerPersonalInfo player) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppThemeShared.secondaryColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                const SizedBox(height: 8),
                Text(
                  player.name,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(player.position)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PositionNames {
  gk,
  lwb,
  lb,
  lcb,
  ccb,
  rcb,
  rb,
  rwb,
  ldm,
  cdm,
  rdm,
  lm,
  lcm,
  cm,
  rcm,
  rm,
  lam,
  cam,
  ram,
  lw,
  ls,
  st,
  rs,
  rw,
  ss
}

final homeLineupDoneProvider = StateProvider<bool>((ref) {
  return false;
});
final awayLineupDoneProvider = StateProvider<bool>((ref) {
  return false;
});
