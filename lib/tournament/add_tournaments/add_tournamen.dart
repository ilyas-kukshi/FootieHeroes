import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';

class AddTournament extends StatefulWidget {
  PlayerPersonalInfo playerPersonalInfo;
  AddTournament({Key? key, required this.playerPersonalInfo}) : super(key: key);

  @override
  State<AddTournament> createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  DateTime calenderStartDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Tournament", context: context),
      body: SingleChildScrollView(
          child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              AppThemeShared.textFormField(
                context: context,
                labelText: "Tournament Name*",
                controller: nameController,
                validator: Utility.nameValidator,
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: AppThemeShared.textFormField(
                      context: context,
                      labelText: "Start Date*",
                      readonly: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: startDateController,
                      validator: Utility.nameValidator,
                      onTap: () {
                        selectStartDate(context);
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: AppThemeShared.primaryColor,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: AppThemeShared.textFormField(
                      context: context,
                      labelText: "End Date*",
                      readonly: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: endDateController,
                      validator: Utility.nameValidator,
                      onTap: () {
                        selectEndDate(context);
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: AppThemeShared.primaryColor,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Create Tournament",
                  onTap: () {
                    final valid = formKey.currentState!.validate();
                    if (valid) createTournament();
                  })
            ],
          ),
        ),
      )),
    );
  }

  createTournament() async {
    AddTournamentModel addTournamentModel = AddTournamentModel(
        name: nameController.text,
        organizer: widget.playerPersonalInfo,
        startDate: startDate,
        endDate: endDate);

    await FirebaseFirestore.instance
        .collection("Tournaments")
        .add(addTournamentModel.toJson())
        .then((value) {
      Fluttertoast.showToast(msg: "Tournament Created");
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: calenderStartDate,
        lastDate: DateTime(2025));

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        startDateController.text =
            '${startDate.day}-${startDate.month}-${startDate.year}';
      });
    }
  }

  selectEndDate(BuildContext context) async {
    if (startDateController.text.isNotEmpty) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: startDate.add(const Duration(days: 1)),
          firstDate: startDate,
          lastDate: DateTime(2025));

      if (picked != null && picked != endDate) {
        setState(() {
          endDate = picked;
          endDateController.text =
              '${endDate.day}-${endDate.month}-${endDate.year}';
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Select Start Date First");
    }
  }
}
