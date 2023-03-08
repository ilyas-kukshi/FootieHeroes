import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class AddTeamBottomSheet extends StatefulWidget {
  AddTeamModel? teamModel;
  AddTournamentModel tournamentModel;
  AddTeamBottomSheet(
      {super.key, this.teamModel, required this.tournamentModel});

  @override
  State<AddTeamBottomSheet> createState() => _AddTeamBottomSheetState();
}

class _AddTeamBottomSheetState extends State<AddTeamBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController townController = TextEditingController();

  bool imageSelected = false;
  bool networkImage = false;

  String? imagePath;

  CroppedFile? croppedFile;
  @override
  void initState() {
    super.initState();

    if (widget.teamModel != null) {
      nameController.text = widget.teamModel!.name;
      townController.text = widget.teamModel!.townName;

      if (widget.teamModel!.logoUri != null) {
        imageSelected = true;
        networkImage = true;
        imagePath = widget.teamModel!.logoUri;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 480,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              imageSelected
                  ? Stack(children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            imageSelected = false;
                            imagePath = null;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppThemeShared.primaryColor,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: networkImage
                            ? CircleAvatar(
                                radius: 50,
                                child: CachedNetworkImage(
                                  imageUrl: imagePath!,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 75,
                                backgroundImage: FileImage(
                                  File(imagePath!),
                                ),
                              ),
                      ),
                    ])
                  : GestureDetector(
                      onTap: () => pickFile(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppThemeShared.secondaryColor,
                                    width: 5),
                                // borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.perm_identity,
                                  color: AppThemeShared.secondaryColor,
                                  size: 75,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              InkWell(
                onTap: () => pickFile(),
                child: Text(
                  imageSelected ? "Change Photo" : "Add Photo",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppThemeShared.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AppThemeShared.textFormField(
                  context: context,
                  widthPercent: 0.9,
                  labelText: 'Enter Name*',
                  controller: nameController,
                  validator: Utility.nameValidator,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)]),
              const SizedBox(height: 20),
              AppThemeShared.textFormField(
                  context: context,
                  widthPercent: 0.9,
                  labelText: 'Enter Town/City name*',
                  controller: townController,
                  validator: Utility.nameValidator,
                  inputFormatters: [LengthLimitingTextInputFormatter(28)]),
              const SizedBox(height: 20),
              AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  buttonText: "Add",
                  onTap: () {
                    bool valid = formKey.currentState!.validate();
                    !valid
                        ? Fluttertoast.showToast(msg: "Fill Details")
                        : imagePath == null
                            ? saveTeam(null)
                            : uploadLogo();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  pickFile() async {
    // Permission.storage.
    if (await Permission.storage.request().isGranted) {
      // file = null;
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      if (result != null) {
        imagePath = null;
        croppedFile = await ImageCropper().cropImage(
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
                initAspectRatio: CropAspectRatioPreset.ratio4x3,
              )
            ]);

        if (croppedFile == null) {
          Fluttertoast.showToast(msg: "Please crop the photo");
        } else {
          imageSelected = true;
          networkImage = false;
          imagePath = croppedFile?.path;
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

  uploadLogo() async {
    TaskSnapshot? fileUpload;

    fileUpload = await FirebaseStorage.instance
        .ref()
        .child("/Tournaments/${nameController.text}/Logo")
        .putFile(File(imagePath!));

    if (fileUpload.state == TaskState.success) {
      final String downloadUrl = await fileUpload.ref.getDownloadURL();
      saveTeam(downloadUrl);
    }
  }

  saveTeam(String? logoUrl) async {
    DialogShared.loadingDialog(context, "Adding Team");
    await FirebaseFirestore.instance
        .collection("Teams")
        .add(AddTeamModel(
                name: nameController.text,
                townName: townController.text,
                logoUri: logoUrl,
                tournamentId: [widget.tournamentModel.id!],
                isGrouped: false)
            .toJson())
        .then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }
}
