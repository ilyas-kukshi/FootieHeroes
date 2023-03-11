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

class RedCardEvent extends ConsumerStatefulWidget {
  AddMatchModel matchModel;
  RedCardEvent({super.key, required this.matchModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RedCardEventState();
}

class _RedCardEventState extends ConsumerState<RedCardEvent> {
  AddTeamModel? selectedTeam;
  PlayerPersonalInfo? redCarded;

  List<PlayerPersonalInfo> homePlayers = [];
  List<PlayerPersonalInfo> awayPlayers = [];
  @override
  Widget build(BuildContext context) {
    homePlayers = ref.watch(selectedHomeProvider);
    awayPlayers = ref.watch(selectedAwayProvider);
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Red Card", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text("Red Card"),
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
        color: AppThemeShared.primaryColor
            .withOpacity(selectedTeam != null && redCarded != null ? 1 : 0.5),
        buttonText: "Save Red Event",
        onTap: () {
          if (selectedTeam != null && redCarded != null) {
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
        cardType: CardType.red.name,
        playerCarded: redCarded!.id,
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
            redCarded = null;
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
            redCarded = null;
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
        redCarded = player;

        setState(() {});
      },
      child: Card(
        color: redCarded != null && redCarded!.id == player.id
            ? AppThemeShared.secondaryColor
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            player.name,
            style: TextStyle(
              color: redCarded != null && redCarded!.id == player.id
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
