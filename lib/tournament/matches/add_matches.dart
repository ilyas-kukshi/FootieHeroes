import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddMatches extends ConsumerStatefulWidget {
  AddTournamentModel tournamentModel;

  AddMatches({super.key, required this.tournamentModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMatchesState();
}

class _AddMatchesState extends ConsumerState<AddMatches> {
  Queue<AddTeamModel> selectedTeams = Queue<AddTeamModel>();

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController minsEachHalfController = TextEditingController();
  TextEditingController matchDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();

  late String noOfHalfs;
  String startingPlayers = "7";
  String noOfSubs = "3";
  String typeOfSub = "Rolling";
  String matchType = "League Matches";

  TimeOfDay? startTime;

  DateTime? matchDate;
  @override
  void initState() {
    super.initState();

    noOfHalfs = widget.tournamentModel.noOfHalfs.toString();
    minsEachHalfController = TextEditingController(
        text: widget.tournamentModel.minsEachHalf.toString());

    matchDateController.text =
        DateFormat.yMMMMd().format(widget.tournamentModel.startDate);
    matchDate = widget.tournamentModel.startDate;
  }

  @override
  Widget build(BuildContext context) {
    final teams =
        ref.watch(currTournamentTeamsProvider(widget.tournamentModel));

    return teams.when(
      loading: () => const CircularProgressIndicator(),
      error: (Object error, StackTrace stackTrace) {
        return Text(error.toString());
      },
      data: (teams) {
        return Scaffold(
          appBar: AppThemeShared.appBar(
              title: "Schedule Matches", context: context),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Select Teams",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemCount: teams.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, mainAxisExtent: 220),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () => selectTeam(teams[index]),
                              child: teamDetailsCard(teams[index]));
                        },
                      )),
                  // const SizedBox(height: 20),
                  Center(
                    child: AppThemeShared.sharedDropDown(
                        value: matchType,
                        context: context,
                        widthPercent: 0.95,
                        labelText: "MatchType*",
                        items: [
                          "League Matches",
                          "Round of 16",
                          "Quater Final",
                          "Semi Final",
                          "Final"
                        ],
                        onChanged: (value) {
                          setState(() {
                            matchType = value!;
                          });
                        }),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppThemeShared.sharedDropDown(
                              value: noOfHalfs,
                              context: context,
                              widthPercent: 0.45,
                              labelText: "No of halfs*",
                              items: ["1", "2"],
                              onChanged: (value) {
                                setState(() {
                                  noOfHalfs = value!;
                                });
                              }),
                          AppThemeShared.textFormField(
                            context: context,
                            controller: minsEachHalfController,
                            widthPercent: 0.45,
                            labelText: "No of mins each half*",
                            keyboardType: TextInputType.number,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppThemeShared.sharedDropDown(
                              value: startingPlayers,
                              context: context,
                              borderColor: Colors.transparent,
                              widthPercent: 0.30,
                              labelText: "Starting Players*",
                              items: [
                                "3",
                                "4",
                                "5",
                                "6",
                                "7",
                                "8",
                                "9",
                                "10",
                                "11"
                              ],
                              onChanged: (value) {
                                setState(() {
                                  startingPlayers = value!;
                                });
                              }),
                          AppThemeShared.sharedDropDown(
                              value: noOfSubs,
                              context: context,
                              borderColor: Colors.transparent,
                              widthPercent: 0.30,
                              labelText: "No of Subs*",
                              items: [
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                              ],
                              onChanged: (value) {
                                setState(() {
                                  noOfHalfs = value!;
                                });
                              }),
                          AppThemeShared.sharedDropDown(
                              value: typeOfSub,
                              context: context,
                              borderColor: Colors.transparent,
                              widthPercent: 0.30,
                              labelText: "Type of Subs*",
                              items: ["One Time", "Rolling"],
                              onChanged: (value) {
                                setState(() {
                                  typeOfSub = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: AppThemeShared.textFormField(
                                context: context,
                                labelText: "Match Date*",
                                readonly: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: matchDateController,
                                validator: Utility.nameValidator,
                                onTap: () {
                                  selectDate(context);
                                },
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: AppThemeShared.primaryColor,
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: AppThemeShared.textFormField(
                                context: context,
                                labelText: "Start Time*",
                                readonly: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                controller: startTimeController,
                                validator: Utility.nameValidator,
                                onTap: () {
                                  selectTime(context);
                                },
                                suffixIcon: Icon(
                                  Icons.schedule,
                                  color: AppThemeShared.primaryColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppThemeShared.sharedButton(
              context: context,
              width: MediaQuery.of(context).size.width,
              height: 50,
              buttonText: "Add Match",
              onTap: () {
                final valid = formKey.currentState!.validate();
                if (valid && selectedTeams.length == 2 && startTime != null) {
                  addMatch();
                }
              }),
        );
      },
    );
  }

  addMatch() async {
    AddMatchModel matchModel = AddMatchModel(
        matchType: matchType,
        homeTeam: selectedTeams.first,
        awayTeam: selectedTeams.last,
        noOfHalfs: int.parse(noOfHalfs),
        minsEachHalf: int.parse(minsEachHalfController.text),
        startingPlayers: int.parse(startingPlayers),
        noOfSubs: int.parse(noOfSubs),
        substitutionType: typeOfSub,
        matchDate: DateTime(matchDate!.year, matchDate!.month, matchDate!.day,
            startTime!.hour, startTime!.minute));

    await FirebaseFirestore.instance
        .collection("Tournaments")
        .doc(widget.tournamentModel.id)
        .collection("Matches")
        .add(matchModel.toJson())
        .then((value) {
      Fluttertoast.showToast(msg: value.toString());
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  selectTeam(AddTeamModel team) {
    if (selectedTeams.contains(team)) {
      selectedTeams.remove(team);
    } else if (selectedTeams.length < 2) {
      selectedTeams.add(team);
    } else {
      selectedTeams.removeFirst();
      selectedTeams.add(team);
    }
    setState(() {});
  }

  Widget logoWidget(AddTeamModel teamModel) {
    return Stack(
      children: [
        Column(children: [
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
        ]),
        selectedTeams.contains(teamModel)
            ? Container(
                height: 100,
                decoration: BoxDecoration(
                    color: AppThemeShared.secondaryColor.withOpacity(0.6)),
                child: const Center(
                  child: Icon(
                    Icons.done,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              )
            : const Offstage(),
      ],
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await Utility().selectDate(
        context,
        widget.tournamentModel.startDate,
        widget.tournamentModel.startDate,
        widget.tournamentModel.endDate);

    if (picked != null && picked != matchDate) {
      matchDate = picked;
      setState(() {
        matchDateController.text = DateFormat.yMMMMd().format(matchDate!);
      });
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      startTime = result;
      setState(() {
        startTimeController.text = result.format(context);
      });
    }
  }

  Widget teamDetailsCard(AddTeamModel teams) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            logoWidget(teams),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                teams.name,
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
              teams.townName,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
