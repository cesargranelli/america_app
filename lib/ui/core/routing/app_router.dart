import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../athlete/views/athlete_list_screen.dart';
import '../../athlete/views/athlete_registration_screen.dart';
import '../../auth/views/signup_screen.dart';
import '../../championship/views/championship_list_screen.dart';
import '../../championship/views/championship_registration_screen.dart';
import '../../conference/views/conference_list_screen.dart';
import '../../conference/views/conference_registration_screen.dart';
import '../../division/views/division_list_screen.dart';
import '../../division/views/division_registration_screen.dart';
import '../../game/views/game_management_screen.dart';
import '../../game/views/game_timeline_screen.dart';
import '../../home/views/home_screen.dart';
import '../../league/views/league_registration_screen.dart';
import '../../standings/views/standings_screen.dart';
import '../../team/views/team_list_screen.dart';
import '../../team/views/team_registration_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String leagues = '/leagues';
  static const String leagueRegistration = '/leagues/register';
  static const String championships = '/championships';
  static const String championshipRegistration = '/championships/register';
  static const String conferences = '/conferences';
  static const String conferenceRegistration = '/conferences/register';
  static const String divisions = '/divisions';
  static const String divisionRegistration = '/divisions/register';
  static const String teams = '/teams';
  static const String teamRegistration = '/teams/register';
  static const String athletes = '/athletes';
  static const String athleteRegistration = '/athletes/register';
  static const String standings = '/standings';
  static const String gameManagement = '/games/:gameId';
  static const String gameTimeline = '/games/:gameId/timeline';
}

GoRouter createAppRouter(BuildContext context) {
  return GoRouter(
    initialLocation: AppRoutes.signIn,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => SignInScreen(
          providers: [EmailAuthProvider()],
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              context.go('/home');
            }),
          ],
          headerBuilder: (context, constraints, shrinkOffset) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset('assets/flutterfire_300x.png'),
              ),
            );
          },
          subtitleBuilder: (context, action) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: action == AuthAction.signIn
                  ? const Text('Welcome to FlutterFire, please sign in!')
                  : const Text('Welcome to Flutterfire, please sign up!'),
            );
          },
          footerBuilder: (context, action) {
            return const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'By signing in, you agree to our terms and conditions.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignupScreen(),
      ),

      // Main app routes
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) =>
            const ProfileScreen(children: [Text('data')]),
      ),

      // League routes
      GoRoute(
        path: AppRoutes.leagueRegistration,
        builder: (context, state) => const LeagueRegistrationScreen(),
      ),

      // Championship routes
      GoRoute(
        path: AppRoutes.championships,
        builder: (context, state) => const ChampionshipListScreen(),
      ),
      GoRoute(
        path: AppRoutes.championshipRegistration,
        builder: (context, state) => const ChampionshipRegistrationScreen(),
      ),

      // Conference routes
      GoRoute(
        path: AppRoutes.conferences,
        builder: (context, state) => const ConferenceListScreen(),
      ),
      GoRoute(
        path: AppRoutes.conferenceRegistration,
        builder: (context, state) => const ConferenceRegistrationScreen(),
      ),

      // Division routes
      GoRoute(
        path: AppRoutes.divisions,
        builder: (context, state) => const DivisionListScreen(),
      ),
      GoRoute(
        path: AppRoutes.divisionRegistration,
        builder: (context, state) => const DivisionRegistrationScreen(),
      ),

      // Team routes
      GoRoute(
        path: AppRoutes.teams,
        builder: (context, state) => const TeamListScreen(),
      ),
      GoRoute(
        path: AppRoutes.teamRegistration,
        builder: (context, state) => const TeamRegistrationScreen(),
      ),

      // Athlete routes
      GoRoute(
        path: AppRoutes.athletes,
        builder: (context, state) => const AthleteListScreen(),
      ),
      GoRoute(
        path: AppRoutes.athleteRegistration,
        builder: (context, state) => const AthleteRegistrationScreen(),
      ),

      // Standings
      GoRoute(
        path: AppRoutes.standings,
        builder: (context, state) => const StandingsScreen(),
      ),

      // Game routes
      GoRoute(
        path: AppRoutes.gameManagement,
        builder: (context, state) {
          final gameId = state.pathParameters['gameId']!;
          return GameManagementScreen(gameId: gameId);
        },
      ),
      GoRoute(
        path: AppRoutes.gameTimeline,
        builder: (context, state) {
          final gameId = state.pathParameters['gameId']!;
          return GameTimelineScreen(gameId: gameId);
        },
      ),
    ],
  );
}
