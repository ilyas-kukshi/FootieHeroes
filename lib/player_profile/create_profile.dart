import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class CreateProfile extends StatefulWidget {
  PlayerPersonalInfo user;
  CreateProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // TextEditingController position = TextEditingController();

  File? file;
  String? imagePath;
  CroppedFile? croppedFile;
  bool imageSelected = false;
  bool networkImage = false;

  late String position;
  late String role;
  late String prefFoot;
  late String gender;

  List<String> posList = ["DEF", "MID", "ATT"];
  List<String> defRoles = ["GK", "CB", "LB", "RB", "LWB", "RWB"];
  List<String> midRoles = ["CM", "CDM", "CAM", "LM", "RM"];
  List<String> attRoles = ["ST", "CF", "LW", "RW"];
  List<String> prefFootList = ["Left", "Right", "Both"];
  List<String> genderList = ["Male", "Female"];

  @override
  void initState() {
    super.initState();

    widget.user.position == ""
        ? position = 'DEF'
        : position = widget.user.position;
    widget.user.role == "" ? role = 'GK' : role = widget.user.role;
    widget.user.prefFoot == ""
        ? prefFoot = 'Left'
        : prefFoot = widget.user.prefFoot;
    widget.user.gender == "" ? gender = 'Male' : gender = widget.user.gender;

    nameController.text = widget.user.name;
    phoneNumberController.text = widget.user.phoneNo;

    if (widget.user.photoUri != null) {
      imagePath = widget.user.photoUri;
      imageSelected = true;
      networkImage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Create Profile", context: context),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  imageSelected
                      ? Stack(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                file = null;
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
                                      imageUrl: widget.user.photoUri!,
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
                    labelText: 'Enter Name*',
                    controller: nameController,
                    validator: Utility.nameValidator,
                  ),
                  
                  const SizedBox(height: 20),
                  AppThemeShared.textFormField(
                    context: context,
                    readonly: true,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    labelText: "Phone Number*",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),
                  AppThemeShared.sharedDropDown(
                      value: gender,
                      hint: "Gender*",
                      context: context,
                      items: genderList,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      }),
                  const SizedBox(height: 20),
                  AppThemeShared.sharedDropDown(
                      value: position,
                      hint: "Select Position*",
                      context: context,
                      items: posList,
                      onChanged: (value) {
                        setState(() {
                          position = value!;
                          role = position == posList.elementAt(0)
                              ? defRoles.elementAt(0)
                              : position == posList.elementAt(1)
                                  ? midRoles.elementAt(0)
                                  : attRoles.elementAt(0);
                        });
                      }),
                  const SizedBox(height: 20),
                  AppThemeShared.sharedDropDown(
                      value: role,
                      hint: "Select Role*",
                      context: context,
                      items: position == posList.elementAt(0)
                          ? defRoles
                          : position == posList.elementAt(1)
                              ? midRoles
                              : attRoles,
                      onChanged: (value) {
                        setState(() {
                          role = value!;
                        });
                      }),
                  const SizedBox(height: 20),
                  AppThemeShared.sharedDropDown(
                      value: prefFoot,
                      hint: "Select Position*",
                      context: context,
                      items: prefFootList,
                      onChanged: (value) {
                        setState(() {
                          prefFoot = value!;
                        });
                      }),
                  const SizedBox(height: 20),
                  AppThemeShared.sharedButton(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.85,
                      buttonText: "Save Profile",
                      onTap: () {
                        final valid = formKey.currentState!.validate();

                        !valid
                            ? Fluttertoast.showToast(msg: "Complete Details ")
                            : file != null
                                ? uploadFile()
                                : saveProfile(imagePath);
                      })
                ],
              ),
            )),
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
        file = File(result.files.single.path!);
        imagePath = null;
        croppedFile = await ImageCropper().cropImage(
            sourcePath: file!.path,
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
          file?.delete();
          Fluttertoast.showToast(msg: "Please crop the photo");
        } else {
          imageSelected = true;

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

  uploadFile() async {
    TaskSnapshot? fileUpload;
    try {
      fileUpload = await FirebaseStorage.instance
          .ref()
          // ignore: prefer_interpolation_to_compose_strings
          .child("players/" +
              FirebaseAuth.instance.currentUser!.uid.toString() +
              "/ProfilePic/")
          .putFile(File(croppedFile!.path));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    if (fileUpload!.state == TaskState.success) {
      try {
        final String downloadUrl = await fileUpload.ref.getDownloadURL();
        saveProfile(downloadUrl);
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  saveProfile(String? photoUri) async {
    DialogShared.loadingDialog(context, "Updating Profile");
    PlayerPersonalInfo playerPersonalInfo = PlayerPersonalInfo(
        id: widget.user.id,
        name: nameController.text,
        phoneNo: phoneNumberController.text,
        position: position,
        role: role,
        prefFoot: prefFoot,
        gender: gender,
        photoUri: photoUri);

    await FirebaseFirestore.instance
        .collection("Players")
        .doc(widget.user.id)
        .set(playerPersonalInfo.toJson())
        .then((value) {})
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }).whenComplete(() {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Profile Updated");
      Navigator.pushNamed(context, "/dashboardMain");
    });
  }
}
