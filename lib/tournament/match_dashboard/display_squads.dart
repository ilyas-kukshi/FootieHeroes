import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/players/players_tournament_model.dart';

class DisplaySquads extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  DisplaySquads({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplaySquadsState();
}

class _DisplaySquadsState extends ConsumerState<DisplaySquads> {
  @override
  Widget build(BuildContext context) {
    final homeTeamList =
        ref.watch(currHomeTeamPlayersProvider(widget.matchModel.homeTeam));
    final awayTeamList =
        ref.watch(currHomeTeamPlayersProvider(widget.matchModel.awayTeam));
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            homeTeamList.when(
              data: (homeTeamPlayers) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: homeTeamPlayers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          playerCard(homeTeamPlayers[index]),
                    ));
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
            awayTeamList.when(
              data: (awayTeamPlayers) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: awayTeamPlayers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          playerCard(awayTeamPlayers[index]),
                    ));
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
            // SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.5,
            //     child: ListView.builder(
            //       itemCount: 0,
            //       itemBuilder: (context, index) => Container(),
            //     )),
          ],
        ),
      ],
    );
  }

  Widget playerCard(PlayersTournamentModel player) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppThemeShared.secondaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 20,
              child: player.playerPersonalInfo.photoUri == null
                  ? Text(Utility.getInitials(player.playerPersonalInfo.name))
                  : CachedNetworkImage(
                      imageUrl: player.playerPersonalInfo.photoUri!,
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
            Text(player.playerPersonalInfo.name),
            const SizedBox(width: 8),
            Text(player.playerPersonalInfo.position)
          ],
        ),
      ),
    );
  }
}
