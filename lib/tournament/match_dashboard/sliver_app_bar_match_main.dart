import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/matches/matches.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SliverAppBarMatchMain extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  SliverAppBarMatchMain({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SliverAppBarMatchMainState();
}

class _SliverAppBarMatchMainState extends ConsumerState<SliverAppBarMatchMain> {
  bool collapsed = false;
  @override
  Widget build(BuildContext context) {
    final matchDoc = ref.watch(currMatchProvider(widget.matchModel));
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 160,
      centerTitle: false,
      backgroundColor: AppThemeShared.primaryColor,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.biggest.height ==
              MediaQuery.of(context).padding.top + kToolbarHeight) {
            collapsed = true;
          } else {
            collapsed = false;
          }
          return matchDoc.when(
            data: (match) {
              return FlexibleSpaceBar(
                centerTitle: true,
                title: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: collapsed ? 16 : 0,
                        top: collapsed ? 8 : kToolbarHeight),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          collapsed
                              ? homeTeamRow(widget.matchModel)
                              : homeTeamColumn(widget.matchModel),
                          match.matchStatus == MatchStatus.upcoming.name
                              ? timeAndDateColumn(widget.matchModel)
                              : match.matchStatus !=
                                          MatchStatus.upcoming.name ||
                                      match.matchStatus !=
                                          MatchStatus.completed.name
                                  ? Container()
                                  : const Offstage(),
                          collapsed
                              ? awayTeamRow(widget.matchModel)
                              : awayTeamColumn(widget.matchModel)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Column timeAndDateColumn(AddMatchModel match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('d LLL, E').format(match.matchDate),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          DateFormat('h:mm a').format(match.matchDate),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Column awayTeamColumn(AddMatchModel match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        logoWidget(widget.matchModel.awayTeamModel!),
        const SizedBox(height: 8),
        collapsed
            ? const Offstage()
            : Text(
                match.awayTeamModel!.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
      ],
    );
  }

  Row awayTeamRow(AddMatchModel match) {
    return Row(
      children: [
        logoWidget(match.awayTeamModel!),
        const SizedBox(width: 6),
        Text(
          match.awayTeamModel!.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Column homeTeamColumn(AddMatchModel match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        logoWidget(match.homeTeamModel!),
        const SizedBox(height: 8),
        collapsed
            ? const Offstage()
            : Text(
                match.homeTeamModel!.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
      ],
    );
  }

  Row homeTeamRow(AddMatchModel match) {
    return Row(
      children: [
        logoWidget(match.homeTeamModel!),
        const SizedBox(width: 6),
        Text(
          match.homeTeamModel!.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget logoWidget(AddTeamModel teamModel) {
    return Stack(children: [
      teamModel.logoUri == null
          ? Container(
              height: 100,
              color: AppThemeShared.secondaryColor,
              child: Center(
                child: Text(
                  Utility.getInitials(teamModel.name),
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ))
          : CircleAvatar(
              radius: collapsed ? 15 : 25,
              child: CachedNetworkImage(
                  imageUrl: teamModel.logoUri!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  // height: 70,
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      )),
            ),
    ]);
  }
}
