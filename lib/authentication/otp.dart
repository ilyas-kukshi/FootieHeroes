import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/authentication/otp_model.dart';
import 'package:footie_heroes/shared/app_theme_shared.dart';
import 'package:footie_heroes/shared/dialogs.dart';
import 'package:footie_heroes/shared/utility.dart';

class Otp extends StatefulWidget {
  final OtpModel otpModel;
  const Otp({Key? key, required this.otpModel}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 300,
                      child: Image.asset(
                        'assets/images/auth/logo.png',
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.otpModel.phoneNumber,
              style: const TextStyle(
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We have sent an SMS with a code to the number above.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
                "To complete your phone number verification, please enter the 5-digit activation code. Enter Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: AppThemeShared.textFormField(
                context: context,
                controller: otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                hintText: "OTP",
                validator: Utility.otpValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(height: 20),
            AppThemeShared.sharedButton(
                context: context,
                height: 50,
                width: 200,
                buttonText: "Sign in",
                onTap: () {
                  if (otpController.text.length != 6 ||
                      int.tryParse(otpController.text.toString()) != null) {
                    verifyOtp();
                  }
                }),
          ],
        ),
      ),
    );
  }

  void verifyOtp() async {
    DialogShared.loadingDialog(context, "Loading...");
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.otpModel.verificationId,
        smsCode: otpController.text);

    UserCredential user = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });

   
    await FirebaseFirestore.instance
        .collection("Players")
        .where("phoneNumber", isEqualTo: user.user!.phoneNumber)
        .get()
        .then((document) {
      if (document.size > 0) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    });

    // Navigator.pop(context);
    // Navigator.pushNamed(context, '/dashboardMain');
  }
}
