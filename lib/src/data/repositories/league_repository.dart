import 'package:america_app/src/domain/models/league.dart';

import '../../data/models/league_registration_model.dart';
import '../../data/services/league_service.dart';

abstract class LeagueRepository {
  Future<League> register(LeagueRegistrationModel league);
}

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueService _leagueService;

  LeagueRepositoryImpl({required LeagueService leagueService})
    : _leagueService = leagueService;

  @override
  Future<League> register(LeagueRegistrationModel league) async {
    return await _leagueService.register(league);
  }
}
