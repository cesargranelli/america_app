import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../data/repositories/athlete_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/championship_repository.dart';
import '../../../data/repositories/conference_repository.dart';
import '../../../data/repositories/division_repository.dart';
import '../../../data/repositories/league_repository.dart';
import '../../../data/repositories/play_repository.dart';
import '../../../data/repositories/standing_repository.dart';
import '../../../data/repositories/team_repository.dart';
import '../../../data/services/athlete_service.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/championship_service.dart';
import '../../../data/services/conference_service.dart';
import '../../../data/services/division_service.dart';
import '../../../data/services/league_service.dart';
import '../../../data/services/play_service.dart';
import '../../../data/services/standing_service.dart';
import '../../../data/services/team_service.dart';
import '../../athlete/view_models/athlete_list_view_model.dart';
import '../../athlete/view_models/athlete_registration_view_model.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../championship/view_models/championship_list_view_model.dart';
import '../../championship/view_models/championship_registration_view_model.dart';
import '../../conference/view_models/conference_list_view_model.dart';
import '../../conference/view_models/conference_registration_view_model.dart';
import '../../division/view_models/division_list_view_model.dart';
import '../../division/view_models/division_registration_view_model.dart';
import '../../league/view_models/league_registration_view_model.dart';
import '../../team/view_models/team_list_view_model.dart';
import '../../team/view_models/team_registration_view_model.dart';
import '../config/app_config.dart';

/// Providers centralizados da aplicação.
///
/// Extraídos do main.dart para manter o entry point limpo.
class AppProviders {
  AppProviders._();

  static List<SingleChildWidget> get all => [
    // Core
    Provider<Dio>(
      create: (_) => Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl)),
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
      create: (context) =>
          LeagueRepositoryImpl(leagueService: context.read<LeagueService>()),
    ),
    ChangeNotifierProvider<LeagueRegistrationViewModel>(
      create: (context) => LeagueRegistrationViewModel(
        leagueRepository: context.read<LeagueRepository>(),
      ),
    ),

    // Championship
    Provider<ChampionshipService>(
      create: (context) => ChampionshipServiceImpl(dio: context.read<Dio>()),
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
      create: (context) =>
          AthleteRepositoryImpl(athleteService: context.read<AthleteService>()),
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

    // Play
    Provider<PlayService>(
      create: (context) => PlayServiceImpl(dio: context.read<Dio>()),
    ),
    Provider<PlayRepository>(
      create: (context) =>
          PlayRepositoryImpl(playService: context.read<PlayService>()),
    ),

    // Standing
    Provider<StandingService>(
      create: (context) => StandingServiceImpl(dio: context.read<Dio>()),
    ),
    Provider<StandingRepository>(
      create: (context) => StandingRepositoryImpl(
        standingService: context.read<StandingService>(),
      ),
    ),
  ];
}
