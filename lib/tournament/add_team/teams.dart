import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_bottom_sheet.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';

// ignore: must_be_immutable
class Teams extends ConsumerStatefulWidget {
  AddTournamentModel tournamentModel;
  bool organizer;
  Teams({super.key, required this.tournamentModel, required this.organizer});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamsState();
}

class _TeamsState extends ConsumerState<Teams> {
  List<AddTeamModel> teams = [];

  @override
  Widget build(BuildContext context) {
    final tournamentDoc =
        ref.watch(currTournamentProvider(widget.tournamentModel));

    return tournamentDoc.when(
      loading: () => const CircularProgressIndicator(),
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      data: (tournamentModel) {
        teams = Utility().tournamentDocToTeamsList(tournamentModel);
        return Scaffold(
            body: Padding(
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: teams.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisExtent: 220),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, '/players',
                          arguments: teams[index]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              logoWidget(teams[index]),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  teams[index].name,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                teams[index].townName,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
            bottomNavigationBar: widget.organizer
                ? AppThemeShared.sharedButton(
                    context: context,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    buttonText: "Add Team",
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => AddTeamBottomSheet(
                                tournamentModel: widget.tournamentModel,
                              ),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))));
                    })
                : const Offstage());
      },
    );
  }

  removeTeam(AddTeamModel removeTeam) async {
    DialogShared.doubleButtonDialog(context,
        "Are you sure you want to remove this team from the tournament.",
        () async {
      await FirebaseFirestore.instance
          .collection("Tournaments")
          .doc(widget.tournamentModel.id)
          .update({
        "teams": FieldValue.arrayRemove([removeTeam.toJson()])
      }).then((value) {
        Fluttertoast.showToast(msg: "Team Removed");
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }, () {
      Navigator.pop(context);
    });
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
          : SizedBox(
              height: 100,
              // width:
              // MediaQuery.of(context).size.width * 0.28,
              child: CachedNetworkImage(
                imageUrl: teamModel.logoUri!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                // height: 70,
                fit: BoxFit.fill,
              ),
            ),
      widget.organizer
          ? Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (() => removeTeam(teamModel)),
                child: CircleAvatar(
                  backgroundColor: AppThemeShared.primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : const Offstage()
    ]);
  }
}
