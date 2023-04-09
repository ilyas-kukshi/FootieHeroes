import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/authentication/otp_model.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/utility.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String verificationIdLocal = '';
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkLogin();
    Utility().initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppThemeShared.appBar(
        title: "",
        context: context,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/auth/signin.jpg',
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.transparent,
                ),
              )),
              Image.asset(
                'assets/images/auth/logo.png',
                fit: BoxFit.cover,
              )
            ],
          ),
          AppThemeShared.textFormField(
              context: context,
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              hintText: "Phone Number",
              validator: Utility.phoneNumberValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "+91",
                  style: TextStyle(fontSize: 18),
                ),
              )),
          const SizedBox(height: 20),
          AppThemeShared.sharedButton(
              context: context,
              height: 50,
              width: 200,
              buttonText: "Get Otp",
              onTap: () {
                if (phoneNumberController.text.length != 10 ||
                    int.tryParse(phoneNumberController.text.toString()) !=
                        null) {
                  sendOtp();
                }
              })
        ],
      ),
    );
  }

  void sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumberController.text}",
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void codeAutoRetrievalTimeout(String verificationId) {}
  void codeSent(String verificationId, [int? smsCode]) async {
    Navigator.pushNamed(context, '/otp',
        arguments:
            OtpModel(verificationId, "+91${phoneNumberController.text}"));
  }

  void verificationFailed(FirebaseAuthException exception) {
    Fluttertoast.showToast(msg: exception.toString());

    Fluttertoast.showToast(msg: exception.message.toString());
  }

  void verificationCompleted(PhoneAuthCredential credential) async {}

  checkLogin() async {
    if (await Utility().userLoggedIn()) {
      if (await Utility().userProfileComplete()) {
        toDashboard();
      } else {
        toProfile();
      }
    }
  }

  toDashboard() {
    Navigator.pushNamed(context, "/dashboardMain");
  }

  toProfile() {
    Navigator.pushNamed(context, '/createProfile',
        arguments: PlayerPersonalInfo(
            name: "",
            phoneNo: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
            position: "",
            role: "",
            prefFoot: "",
            gender: ""));
  }
}
