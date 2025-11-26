import '../../data/models/league_registration_model.dart';
import '../../data/services/league_service.dart';

// Interface para facilitar a injeção de dependência
abstract class LeagueRepository {
  Future<void> register(LeagueRegistrationModel league);
}

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueService _leagueService;

  LeagueRepositoryImpl({required LeagueService leagueService})
    : _leagueService = leagueService;

  @override
  Future<void> register(LeagueRegistrationModel league) async {
    // A lógica aqui é simples, mas poderia incluir cache, por exemplo.
    await _leagueService.register(league);
  }
}
