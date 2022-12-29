import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footie_heroes/authentication/otp.dart';
import 'package:footie_heroes/authentication/otp_model.dart';
import 'package:footie_heroes/authentication/signin.dart';
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
    switch(settings.name) {
      //authentication
      case '/otp':
        return PageTransition(
            child: Otp(otpModel: settings.arguments as OtpModel),
            type: PageTransitionType.leftToRight);

      default:
        return PageTransition(
            child: const SignIn(), type: PageTransitionType.leftToRight);
    }
  }
}
