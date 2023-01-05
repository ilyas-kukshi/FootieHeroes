import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';

class Utility {
  static String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your name";
    }
    return null;
  }

  static String? categoryNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your category name";
    }
    return null;
  }

  static String? productPriceValidator(String? name) {
    if (name!.isEmpty) {
      return "Please enter your product price";
    }
    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber?.length != 10 ||
        int.tryParse(phoneNumber.toString()) == null) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordLengthValidator(String? password) {
    if (password!.length < 6) {
      return 'Pleas enter a valid phone number';
    }
    return null;
  }

  static String? passwordSameValidator(
      String? setPassword, String? confirmPassword) {
    if (confirmPassword!.length < 6) {
      return 'Pleas enter a valid phone number';
    } else if (setPassword != confirmPassword) {
      return 'Both passwords should be same';
    }
    return null;
  }

  static String? otpValidator(String? otp) {
    if (otp!.length != 6) {
      return 'Pleas enter a valid otp';
    }
    return null;
  }

  static String? shopNameValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop name";
    }
    return null;
  }

  static String? shopLocationValidator(String? name) {
    if (name!.isEmpty) {
      return " Please set your shop location";
    }
    return null;
  }

  static String? shopAddressValidator(String? name) {
    if (name!.isEmpty) {
      return " Please enter your shop address";
    }
    return null;
  }

  Future<Uri> createLink(String refCode) async {
    final String url =
        "https://com.example.footie_heroes/tournaments?ref=$refCode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://footheroes.page.link",
        androidParameters: const AndroidParameters(
            packageName: "com.example.footie_heroes", minimumVersion: 0));

    final refLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return refLink.shortUrl;
  }

  Future<void> initDynamicLink(BuildContext context) async {
    // final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    FirebaseDynamicLinks.instance.onLink.listen((instanceLink) async {
      if (instanceLink.link.queryParameters.isNotEmpty) {
        String id = instanceLink.link.queryParameters["ref"]!;
        AddTournamentModel addTournamentModel;
        await FirebaseFirestore.instance
            .collection("Tournaments")
            .doc(id)
            .get()
            .then((value) {
          if (value.exists) {
            addTournamentModel = AddTournamentModel.fromDocument(value);
            Navigator.pushNamed(context, "/tournamentMain",
                arguments: addTournamentModel);
          } else {
            Fluttertoast.showToast(msg: "Tournament was deleted.");
          }
        }).onError((error, stackTrace) {
          print(error);
        });
      }
    });
  }

  Future<bool> userLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> userProfileComplete() async {
    bool complete = false;
    await FirebaseFirestore.instance
        .collection("Players")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        complete = true;
        // Navigator.pushNamed(context, "/dashboardMain");
      } else {
        complete = false;
        // Navigator.pushNamed(context, '/createProfile');
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      complete = false;
    });
    return complete;
  }

  static String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';

  // initDynamicLinks() async {
  //   final dynamicLinkParams = DynamicLinkParameters(
  //     link: Uri.parse("https://www.example.com/"),
  //     uriPrefix: "https://example.page.link",
  //     androidParameters: const AndroidParameters(
  //       packageName: "com.example.app.android",
  //       minimumVersion: 30,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: "com.example.app.ios",
  //       appStoreId: "123456789",
  //       minimumVersion: "1.0.1",
  //     ),
  //     googleAnalyticsParameters: const GoogleAnalyticsParameters(
  //       source: "twitter",
  //       medium: "social",
  //       campaign: "example-promo",
  //     ),
  //     socialMetaTagParameters: SocialMetaTagParameters(
  //       title: "Example of a Dynamic Link",
  //       imageUrl: Uri.parse("https://example.com/image.png"),
  //     ),
  //   );
  //   final dynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  // }

  // extension StringExtension on String {
  //   String capitalize() {
  //     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  //   }
// }

}
