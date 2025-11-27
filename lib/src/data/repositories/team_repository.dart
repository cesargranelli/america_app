import '../../domain/models/team.dart';
import '../services/team_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class TeamRepository {
  Future<Team> registerTeam(Team team);
  Future<List<Team>> getAllTeams();
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(String id);
}

class TeamRepositoryImpl implements TeamRepository {
  final TeamService _teamService;

  TeamRepositoryImpl({required TeamService teamService})
      : _teamService = teamService;

  @override
  Future<Team> registerTeam(Team team) async {
    try {
      return await _teamService.register(team);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar o time.',
      );
    }
  }

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      return await _teamService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar times.');
    }
  }

  @override
  Future<void> updateTeam(Team team) async {
    try {
      await _teamService.update(team);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar time.');
    }
  }

  @override
  Future<void> deleteTeam(String id) async {
    try {
      await _teamService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar time.');
    }
  }
}
