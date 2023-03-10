import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footie_heroes/authentication/otp.dart';
import 'package:footie_heroes/authentication/otp_model.dart';
import 'package:footie_heroes/authentication/signin.dart';
import 'package:footie_heroes/dashboard/dashboard_main.dart';
import 'package:footie_heroes/dashboard/my_tournaments.dart';
import 'package:footie_heroes/player_profile/create_profile.dart';
import 'package:footie_heroes/player_profile/player_personal_info_model/player_personal_info.dart';
import 'package:footie_heroes/tournament/Scoring/goal_event.dart';
import 'package:footie_heroes/tournament/Scoring/red_card_event.dart';
import 'package:footie_heroes/tournament/Scoring/scoring_main.dart';
import 'package:footie_heroes/tournament/Scoring/substitution_event.dart';
import 'package:footie_heroes/tournament/Scoring/yellow_card_event.dart';
import 'package:footie_heroes/tournament/add_team/add_team_model.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament.dart';
import 'package:footie_heroes/tournament/add_tournaments/add_tournament_model/add_tournament_model.dart';
import 'package:footie_heroes/tournament/match_dashboard/match_main.dart';
import 'package:footie_heroes/tournament/match_dashboard/line_ups/set_lineups.dart';
import 'package:footie_heroes/tournament/matches/add_match_model.dart';
import 'package:footie_heroes/tournament/matches/add_matches.dart';
import 'package:footie_heroes/tournament/players/options_add_players.dart';
import 'package:footie_heroes/tournament/players/players.dart';
import 'package:footie_heroes/tournament/tournament_dashboard/tournament_main.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
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
      case '/signIn':
        return PageTransition(
            child: const SignIn(), type: PageTransitionType.leftToRight);
      case '/otp':
        return PageTransition(
            child: Otp(otpModel: settings.arguments as OtpModel),
            type: PageTransitionType.leftToRight);
      case '/createProfile':
        return PageTransition(
            child:
                CreateProfile(user: settings.arguments as PlayerPersonalInfo),
            type: PageTransitionType.leftToRight);
      case '/dashboardMain':
        return PageTransition(
            child: const DashboardMain(), type: PageTransitionType.leftToRight);

      //Drawer
      case '/addTournament':
        return PageTransition(
            child: AddTournament(
              playerPersonalInfo: settings.arguments as PlayerPersonalInfo,
            ),
            type: PageTransitionType.leftToRight);
      case '/myTournaments':
        return PageTransition(
            child: const MyTournaments(), type: PageTransitionType.leftToRight);

      //Tournament
      case '/tournamentMain':
        return PageTransition(
            child: TournamentMain(
              tournamentAbout: settings.arguments as AddTournamentModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/players':
        return PageTransition(
            child: Players(
              teamModel: settings.arguments as AddTeamModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/optionsAddPlayers':
        return PageTransition(
            child: OptionsAddPlayers(
              teamModel: settings.arguments as AddTeamModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/addMatches':
        return PageTransition(
            child: AddMatches(
              tournamentModel: settings.arguments as AddTournamentModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/matchMain':
        return PageTransition(
            child: MatchMain(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);

      case '/setLineups':
        return PageTransition(
            child: SetLineUps(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/scoringMain':
        return PageTransition(
            child: ScoringMain(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/goalEvent':
        return PageTransition(
            child: GoalEvent(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/substitutionEvent':
        return PageTransition(
            child: SubstitutionEvent(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/yellowCardEvent':
        return PageTransition(
            child: YellowCardEvent(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/redCardEvent':
        return PageTransition(
            child: RedCardEvent(
              matchModel: settings.arguments as AddMatchModel,
            ),
            type: PageTransitionType.leftToRight);

      default:
        return PageTransition(
            child: const SignIn(), type: PageTransitionType.leftToRight);
    }
  }
}
