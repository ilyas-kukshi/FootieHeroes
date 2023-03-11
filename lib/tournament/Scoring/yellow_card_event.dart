import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/tournament/Scoring/match_event_model/match_event_model.dart';
import 'package:footie_heroes/tournament/Scoring/scoring_main.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/display_squads.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';

class YellowCardEvent extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  YellowCardEvent({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _YellowCardEventState();
}

class _YellowCardEventState extends ConsumerState<YellowCardEvent> {
  AddTeamModel? selectedTeam;
  PlayerPersonalInfo? yellowCarded;

  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];
  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Yellow Card", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text("Yellow Card"),
              const SizedBox(height: 15),
              selectTeam(),
              const SizedBox(height: 15),
              selectedTeam == null
                  ? const Offstage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Player"),
                        const SizedBox(height: 15),
                        selectedTeam!.id == widget.matchModel.homeTeamId
                            ? Wrap(
                                children: homePlayers.map((player) {
                                  return playerCard(player);
                                }).toList(),
                              )
                            : Wrap(
                                children: awayPlayers.map((player) {
                                  return playerCard(player);
                                }).toList(),
                              ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppThemeShared.sharedButton(
        context: context,
        height: 40,
        width: MediaQuery.of(context).size.width * 0.8,
        color: AppThemeShared.primaryColor.withOpacity(
            selectedTeam != null && yellowCarded != null ? 1 : 0.5),
        buttonText: "Save Yellow Event",
        onTap: () {
          if (selectedTeam != null && yellowCarded != null) {
            updateYC();
          }
        },
      ),
    );
  }

  updateYC() async {
    MatchEventModel event = MatchEventModel(
        teamId: selectedTeam!.id!,
        minute: widget.matchModel.currTimer!,
        half: widget.matchModel.currHalf!,
        event: MatchEvents.substitution.name,
        cardType: CardType.fyellow.name,
        playerCarded: yellowCarded!.id,
        addedAt: DateTime.now(),
        penalty: false);
    await FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.matchModel.id)
        .update({
      "keyEvents": FieldValue.arrayUnion(
        [event.toJson()],
      )
    }).then((value) {
      ref.read(keyEventsProvider.notifier).add(event);
      Fluttertoast.showToast(msg: "added");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  Widget selectTeam() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectedTeam = widget.matchModel.homeTeamModel!;
            yellowCarded = null;
            setState(() {});
          },
          child: Card(
            color: selectedTeam != null &&
                    selectedTeam!.id == widget.matchModel.homeTeamId
                ? AppThemeShared.secondaryColor
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.matchModel.homeTeamModel!.name,
                style: TextStyle(
                    color: selectedTeam != null &&
                            selectedTeam!.id == widget.matchModel.homeTeamId
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            selectedTeam = widget.matchModel.awayTeamModel!;
            yellowCarded = null;
            setState(() {});
          },
          child: Card(
            color: selectedTeam != null &&
                    selectedTeam!.id == widget.matchModel.awayTeamId
                ? AppThemeShared.secondaryColor
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.matchModel.awayTeamModel!.name,
                style: TextStyle(
                    color: selectedTeam != null &&
                            selectedTeam!.id == widget.matchModel.awayTeamId
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget playerCard(PlayerPersonalInfo player) {
    return GestureDetector(
      onTap: () {
        yellowCarded = player;

        setState(() {});
      },
      child: Card(
        color: yellowCarded != null && yellowCarded!.id == player.id
            ? AppThemeShared.secondaryColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: yellowCarded != null && yellowCarded!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
