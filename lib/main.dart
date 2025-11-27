import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/data/repositories/athlete_repository.dart';
import 'src/data/repositories/auth_repository.dart';
import 'src/data/repositories/championship_repository.dart';
import 'src/data/repositories/conference_repository.dart';
import 'src/data/repositories/division_repository.dart';
import 'src/data/repositories/league_repository.dart';
import 'src/data/repositories/play_repository.dart';
import 'src/data/repositories/standing_repository.dart';
import 'src/data/repositories/team_repository.dart';
import 'src/data/services/athlete_service.dart';
import 'src/data/services/auth_service.dart';
import 'src/data/services/championship_service.dart';
import 'src/data/services/conference_service.dart';
import 'src/data/services/division_service.dart';
import 'src/data/services/league_service.dart';
import 'src/data/services/play_service.dart';
import 'src/data/services/standing_service.dart';
import 'src/data/services/team_service.dart';
import 'src/ui/athlete/view_models/athlete_list_view_model.dart';
import 'src/ui/athlete/view_models/athlete_registration_view_model.dart';
import 'src/ui/auth/view_models/auth_view_model.dart';
import 'src/ui/auth/views/login_screen.dart';
import 'src/ui/championship/view_models/championship_list_view_model.dart';
import 'src/ui/championship/view_models/championship_registration_view_model.dart';
import 'src/ui/conference/view_models/conference_list_view_model.dart';
import 'src/ui/conference/view_models/conference_registration_view_model.dart';
import 'src/ui/division/view_models/division_list_view_model.dart';
import 'src/ui/division/view_models/division_registration_view_model.dart';
import 'src/ui/home/views/home_screen.dart';
import 'src/ui/league/view_models/league_registration_view_model.dart';
import 'src/ui/team/view_models/team_list_view_model.dart';
import 'src/ui/team/view_models/team_registration_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AmericaApp());
}

class AmericaApp extends StatelessWidget {
  const AmericaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(
          create: (_) => Dio(BaseOptions(baseUrl: 'http://localhost:8081')),
        ),
        // Auth
        Provider<AuthService>(create: (_) => AuthServiceImpl()),
        Provider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(authService: context.read<AuthService>()),
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) =>
              AuthViewModel(authRepository: context.read<AuthRepository>()),
        ),
        // League
        Provider<LeagueService>(
          create: (context) => LeagueServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<LeagueRepository>(
          create: (context) => LeagueRepositoryImpl(
            leagueService: context.read<LeagueService>(),
          ),
        ),
        ChangeNotifierProvider<LeagueRegistrationViewModel>(
          create: (context) => LeagueRegistrationViewModel(
            leagueRepository: context.read<LeagueRepository>(),
          ),
        ),
        // Championship
        Provider<ChampionshipService>(
          create: (context) =>
              ChampionshipServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<ChampionshipRepository>(
          create: (context) => ChampionshipRepositoryImpl(
            championshipService: context.read<ChampionshipService>(),
          ),
        ),
        ChangeNotifierProvider<ChampionshipRegistrationViewModel>(
          create: (context) => ChampionshipRegistrationViewModel(
            championshipRepository: context.read<ChampionshipRepository>(),
          ),
        ),
        ChangeNotifierProvider<ChampionshipListViewModel>(
          create: (context) => ChampionshipListViewModel(
            championshipRepository: context.read<ChampionshipRepository>(),
          ),
        ),
        // Conference
        Provider<ConferenceService>(
          create: (context) => ConferenceServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<ConferenceRepository>(
          create: (context) => ConferenceRepositoryImpl(
            conferenceService: context.read<ConferenceService>(),
          ),
        ),
        ChangeNotifierProvider<ConferenceRegistrationViewModel>(
          create: (context) => ConferenceRegistrationViewModel(
            conferenceRepository: context.read<ConferenceRepository>(),
            championshipRepository: context.read<ChampionshipRepository>(),
          ),
        ),
        ChangeNotifierProvider<ConferenceListViewModel>(
          create: (context) => ConferenceListViewModel(
            conferenceRepository: context.read<ConferenceRepository>(),
          ),
        ),
        // Division
        Provider<DivisionService>(
          create: (context) => DivisionServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<DivisionRepository>(
          create: (context) => DivisionRepositoryImpl(
            divisionService: context.read<DivisionService>(),
          ),
        ),
        ChangeNotifierProvider<DivisionRegistrationViewModel>(
          create: (context) => DivisionRegistrationViewModel(
            divisionRepository: context.read<DivisionRepository>(),
            conferenceRepository: context.read<ConferenceRepository>(),
          ),
        ),
        ChangeNotifierProvider<DivisionListViewModel>(
          create: (context) => DivisionListViewModel(
            divisionRepository: context.read<DivisionRepository>(),
          ),
        ),
        // Team
        Provider<TeamService>(
          create: (context) => TeamServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<TeamRepository>(
          create: (context) =>
              TeamRepositoryImpl(teamService: context.read<TeamService>()),
        ),
        ChangeNotifierProvider<TeamRegistrationViewModel>(
          create: (context) => TeamRegistrationViewModel(
            teamRepository: context.read<TeamRepository>(),
            divisionRepository: context.read<DivisionRepository>(),
          ),
        ),
        ChangeNotifierProvider<TeamListViewModel>(
          create: (context) =>
              TeamListViewModel(teamRepository: context.read<TeamRepository>()),
        ),
        // Athlete
        Provider<AthleteService>(
          create: (context) => AthleteServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<AthleteRepository>(
          create: (context) => AthleteRepositoryImpl(
            athleteService: context.read<AthleteService>(),
          ),
        ),
        Provider<PlayService>(
          create: (context) => PlayServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<PlayRepository>(
          create: (context) =>
              PlayRepositoryImpl(playService: context.read<PlayService>()),
        ),
        Provider<StandingService>(
          create: (context) => StandingServiceImpl(dio: context.read<Dio>()),
        ),
        Provider<StandingRepository>(
          create: (context) => StandingRepositoryImpl(
            standingService: context.read<StandingService>(),
          ),
        ),
        ChangeNotifierProvider<AthleteRegistrationViewModel>(
          create: (context) => AthleteRegistrationViewModel(
            athleteRepository: context.read<AthleteRepository>(),
            teamRepository: context.read<TeamRepository>(),
          ),
        ),
        ChangeNotifierProvider<AthleteListViewModel>(
          create: (context) => AthleteListViewModel(
            athleteRepository: context.read<AthleteRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App America',
        home: Consumer<AuthViewModel>(
          builder: (context, viewModel, _) {
            return StreamBuilder(
              stream: viewModel.authStateChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
