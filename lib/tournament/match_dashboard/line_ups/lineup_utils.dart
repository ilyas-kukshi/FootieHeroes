import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/set_lineups.dart';

class LineUpUtils {
  Widget playersListView(List<PlayerPersonalInfo> players) {
    return SizedBox(
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


  

  EdgeInsetsGeometry getPadding(PositionNames pos) {
    switch (pos) {
      case PositionNames.gk:
        return const EdgeInsets.only(bottom: 30);
      case PositionNames.lb:
        return const EdgeInsets.only(bottom: 120, left: 30);
      case PositionNames.rb:
        return const EdgeInsets.only(bottom: 120, right: 30);
      default:
        return const EdgeInsets.all(0);
    }
  }

  AlignmentGeometry getAlignment(PositionNames pos) {
    switch (pos) {
      case PositionNames.gk:
        return Alignment.bottomCenter;
      case PositionNames.lb:
        return Alignment.bottomLeft;
      case PositionNames.rb:
        return Alignment.bottomRight;
      default:
        return Alignment.bottomCenter;
    }
  }
}
