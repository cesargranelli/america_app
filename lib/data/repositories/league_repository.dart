import '../../domain/models/league.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../services/league_service.dart';

abstract class LeagueRepository {
  Future<League> registerLeague(League league);

  Future<List<League>> getAllLeagues();

  Future<void> updateLeague(League league);

  Future<void> deleteLeague(String id);
}

class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueService _leagueService;

  LeagueRepositoryImpl({required LeagueService leagueService})
    : _leagueService = leagueService;

  @override
  Future<League> registerLeague(League league) async {
    try {
      return await _leagueService.register(league);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar a liga.',
      );
    }
  }

  @override
  Future<List<League>> getAllLeagues() async {
    try {
      return await _leagueService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar ligas.');
    }
  }

  @override
  Future<void> updateLeague(League league) async {
    try {
      await _leagueService.update(league);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar liga.');
    }
  }

  @override
  Future<void> deleteLeague(String id) async {
    try {
      await _leagueService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar liga.');
    }
  }
}
