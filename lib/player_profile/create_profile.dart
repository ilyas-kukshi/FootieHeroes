import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class CreateProfile extends StatefulWidget {
  UserCredential user;
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
  bool imageSelected = false;

  String position = 'DEF';
  String role = "GK";
  String prefFoot = "Left";
  String gender = "Male";

  List<String> posList = ["DEF", "MID", "ATT"];
  List<String> defRoles = ["GK", "CB", "LB", "RB", "LWB", "RWB"];
  List<String> midRoles = ["CM", "CDM", "CAM", "LM", "RM"];
  List<String> attRoles = ["ST", "CF", "LW", "RW"];
  List<String> prefFootList = ["Left", "Right", "Both"];
  List<String> genderList = ["Male", "Female"];

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.user.user!.phoneNumber.toString();
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
                      ? Image.file(
                          file!,
                          fit: BoxFit.contain,
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.85,
                        )
                      : GestureDetector(
                          onTap: () => pickFile(),
                          child: Column(
                            children: [
                              Container(
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
                              Text(
                                "Add Photo",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppThemeShared.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 30),
                  AppThemeShared.textFormField(
                    context: context,
                    labelText: 'Enter Name*',
                    controller: nameController,
                    validator: Utility.nameValidator,
                  ),
                  //  const SizedBox(height: 30),
                  // AppThemeShared.textFormField(
                  //   context: context,
                  //   labelText: 'Enter Email*',
                  //   controller: nameController,
                  //   validator: Utility.nameValidator,
                  // ),
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

                        if (valid) saveProfile();
                      })
                ],
              ),
            )),
      ),
    );
  }

  pickFile() async {
    if (await Permission.photos.request().isGranted) {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = File(result.files.single.path!);
        setState(() {
          imageSelected = true;
          imagePath = result.files.single.path;
        });
      } else {
        // User canceled the picker
      }
    } else {
      Permission.photos.request();
    }
  }

  saveProfile() async {
    DialogShared.loadingDialog(context, "Updating Profile");
    PlayerPersonalInfo playerPersonalInfo = PlayerPersonalInfo(
      id: widget.user.user!.uid,
      name: nameController.text,
      phoneNo: phoneNumberController.text,
      position: position,
      role: role,
      prefFoot: prefFoot,
      gender: gender,
    );

    await FirebaseFirestore.instance
        .collection("Players")
        .doc(widget.user.user!.uid)
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
