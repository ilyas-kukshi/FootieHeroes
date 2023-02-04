// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
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
  TextEditingController minsEachHalfController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  DateTime calenderStartDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String? bannerUriPath;
  CroppedFile? bannerCropped;
  bool bannerSelected = false;

  String? logoUriPath;
  CroppedFile? logoCropped;
  bool logoSelected = false;

  String noOfHalfs = "1";

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
              const SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [pickBannerWidget(), pickLogoWidget()],
              ),
              const SizedBox(height: 50),
              AppThemeShared.textFormField(
                  context: context,
                  widthPercent: 0.95,
                  labelText: "Tournament Name*",
                  controller: nameController,
                  validator: Utility.nameValidator,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)]),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: AppThemeShared.textFormField(
                            context: context,
                            labelText: "Start Date*",
                            readonly: true,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: startDateController,
                            validator: Utility.nameValidator,
                            onTap: () => selectStartDate(context),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: AppThemeShared.primaryColor,
                            )),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppThemeShared.sharedDropDown(
                        value: noOfHalfs,
                        context: context,
                        widthPercent: 0.45,
                        labelText: "No of halfs",
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
                      labelText: "No of mins each half",
                      keyboardType: TextInputType.number,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Create Tournament",
                  onTap: () {
                    final valid = formKey.currentState!.validate();
                    if (valid && bannerUriPath != null && logoUriPath != null) {
                      createTournament();
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }

  Widget pickBannerWidget() {
    return InkWell(
      onTap: () => pickBanner(),
      child: Center(
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppThemeShared.primaryColor,
              width: 2.5,
            ),
          ),
          child: bannerSelected
              ? Image.file(
                  File(
                    bannerUriPath!,
                  ),
                  fit: BoxFit.fill,
                )
              : const Center(
                  child: Text(
                  "Add Banner",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
        ),
      ),
    );
  }

  pickBanner() async {
    // Permission.storage.
    if (await Permission.storage.request().isGranted) {
      // file = null;
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (result != null) {
        bannerUriPath = null;
        bannerCropped = await ImageCropper().cropImage(
            sourcePath: result.files.single.path!,
            // cropStyle: CropStyle.circle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                hideBottomControls: true,
                // lockAspectRatio: true,
                activeControlsWidgetColor: AppThemeShared.primaryColor,
                toolbarWidgetColor: AppThemeShared.primaryColor,
                initAspectRatio: CropAspectRatioPreset.ratio16x9,
              )
            ]);

        if (bannerCropped == null) {
          Fluttertoast.showToast(msg: "Please crop the photo");
        } else {
          bannerSelected = true;

          bannerUriPath = bannerCropped?.path;
          setState(() {});
        }
      } else {
        // User canceled the picker
      }
    } else if (await Permission.storage.isPermanentlyDenied ||
        await Permission.storage.isDenied) {
      openAppSettings();
      Fluttertoast.showToast(
          msg: "FootieHeroes need permission to access photos");
    }
  }

  Widget pickLogoWidget() {
    return Positioned(
      bottom: -40,
      left: 10,
      child: InkWell(
        onTap: () => pickLogo(),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppThemeShared.primaryColor,
              width: 2,
            ),
          ),
          child: logoSelected
              ? CircleAvatar(
                  backgroundImage: FileImage(File(logoUriPath!)),
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                    "Add\nLogo",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                ),
        ),
      ),
    );
  }

  pickLogo() async {
    // Permission.storage.
    if (await Permission.storage.request().isGranted) {
      // file = null;
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (result != null) {
        logoUriPath = null;
        logoCropped = await ImageCropper().cropImage(
            sourcePath: result.files.single.path!,
            cropStyle: CropStyle.circle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                hideBottomControls: true,
                // lockAspectRatio: true,
                activeControlsWidgetColor: AppThemeShared.primaryColor,
                toolbarWidgetColor: AppThemeShared.primaryColor,
                initAspectRatio: CropAspectRatioPreset.ratio16x9,
              )
            ]);

        if (logoCropped == null) {
          Fluttertoast.showToast(msg: "Please crop the photo");
        } else {
          logoSelected = true;

          logoUriPath = logoCropped?.path;
          setState(() {});
        }
      } else {
        // User canceled the picker
      }
    } else if (await Permission.storage.isPermanentlyDenied ||
        await Permission.storage.isDenied) {
      openAppSettings();
      Fluttertoast.showToast(
          msg: "FootieHeroes need permission to access photos");
    }
  }

  Future<String?> uploadFile(String path) async {
    TaskSnapshot? fileUpload;
    try {
      fileUpload = await FirebaseStorage.instance
          .ref()
          .child("players/" +
              FirebaseAuth.instance.currentUser!.uid.toString() +
              "/Tournaments/")
          .putFile(File(path));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    if (fileUpload!.state == TaskState.success) {
      try {
        final String downloadUrl = await fileUpload.ref.getDownloadURL();
        return downloadUrl;
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    return null;
  }

  createTournament() async {
    String? bannerUri = await uploadFile(bannerUriPath!);
    String? logoUri = await uploadFile(logoUriPath!);
    AddTournamentModel addTournamentModel = AddTournamentModel(
        name: nameController.text,
        organizer: widget.playerPersonalInfo,
        startDate: startDate,
        endDate: endDate,
        bannerUri: bannerUri!,
        logoUri: logoUri!,
        minsEachHalf: int.parse(minsEachHalfController.text),
        noOfHalfs: int.parse(noOfHalfs),
        scorers: [widget.playerPersonalInfo.id]);

    await FirebaseFirestore.instance
        .collection("Tournaments")
        .add(addTournamentModel.toJson())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("Players")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Tournaments")
          .doc(value.id)
          .set(addTournamentModel.toJson())
          .then((value) {
        Fluttertoast.showToast(msg: "Tournament Created");
        Navigator.pushNamed(context, '/tournamentMain');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  selectStartDate(BuildContext context) async {
    final DateTime? picked = await Utility().selectDate(context,
        startDate.add(const Duration(days: 1)), startDate, DateTime(2025));

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
      final DateTime? picked = await Utility().selectDate(context,
          startDate.add(const Duration(days: 1)), startDate, DateTime(2025));

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
