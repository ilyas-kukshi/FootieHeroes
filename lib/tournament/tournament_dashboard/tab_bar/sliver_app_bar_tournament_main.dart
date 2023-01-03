import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';

import '../../add_tournaments/add_tournament_model/add_tournament_model.dart';

// ignore: must_be_immutable
class SliverAppBarTournamentMain extends StatelessWidget {
  AddTournamentModel tournamentAbout;
  SliverAppBarTournamentMain({Key? key, required this.tournamentAbout})
      : super(key: key);

  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        snap: false,
        floating: false,
        expandedHeight: 200,
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
          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 50),
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                collapsed
                    ? const Offstage()
                    : CircleAvatar(
                        radius: 30,
                        child: CachedNetworkImage(
                          imageUrl: tournamentAbout.logoUri,
                          fit: BoxFit.fill,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                collapsed ? const Offstage() :   const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(tournamentAbout.name),
                ),
              ],
            ),
            background: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: CachedNetworkImage(
                imageUrl: tournamentAbout.bannerUri,
                fit: BoxFit.fill,
              ),
            ),
          );
        }));
  }
}
