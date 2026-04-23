import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../auth/views/login_screen.dart';
import '../../auth/views/signup_screen.dart';
import '../../home/views/home_screen.dart';
import '../../athlete/views/athlete_list_screen.dart';
import '../../athlete/views/athlete_registration_screen.dart';
import '../../championship/views/championship_list_screen.dart';
import '../../championship/views/championship_registration_screen.dart';
import '../../conference/views/conference_list_screen.dart';
import '../../conference/views/conference_registration_screen.dart';
import '../../division/views/division_list_screen.dart';
import '../../division/views/division_registration_screen.dart';
import '../../game/views/game_management_screen.dart';
import '../../game/views/game_timeline_screen.dart';
import '../../league/views/league_registration_screen.dart';
import '../../standings/views/standings_screen.dart';
import '../../team/views/team_list_screen.dart';
import '../../team/views/team_registration_screen.dart';

/// Nomes das rotas para navegação type-safe.
class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/';
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

/// Configuração do GoRouter para a aplicação.
GoRouter createAppRouter(BuildContext context) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      // Redirect logic is handled by the auth stream in the shell
      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),

      // Main app routes
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
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
