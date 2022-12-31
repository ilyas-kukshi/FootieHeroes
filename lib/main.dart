import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/authentication/otp.dart';
import 'package:footie_heroes/authentication/otp_model.dart';
import 'package:footie_heroes/authentication/signin.dart';
import 'package:footie_heroes/dashboard/dashboard_main.dart';
import 'package:footie_heroes/player_profile/create_profile.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournamen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff439A97),
      ),
      onGenerateRoute: routing,
      home: const SignIn(),
    );
  }

  Route routing(RouteSettings settings) {
    switch (settings.name) {
      //authentication
      case '/otp':
        return PageTransition(
            child: Otp(otpModel: settings.arguments as OtpModel),
            type: PageTransitionType.leftToRight);
      case '/createProfile':
        return PageTransition(
            child: CreateProfile(user: settings.arguments as UserCredential),
            type: PageTransitionType.leftToRight);
      case '/dashboardMain':
        return PageTransition(
            child: DashboardMain(), type: PageTransitionType.leftToRight);


            //Tournament
case '/addTournament':
        return PageTransition(
            child: AddTournament(
              playerPersonalInfo: settings.arguments as PlayerPersonalInfo,
            ), type: PageTransitionType.leftToRight);


      default:
        return PageTransition(
            child: const SignIn(), type: PageTransitionType.leftToRight);
    }
  }
}
