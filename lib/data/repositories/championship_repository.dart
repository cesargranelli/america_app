import '../../domain/models/championship.dart';
import '../services/championship_service.dart';
import '../../ui/core/exceptions/repository_exception.dart';

abstract class ChampionshipRepository {
  Future<Championship> registerChampionship(Championship championship);
  Future<List<Championship>> getAllChampionships();
  Future<void> updateChampionship(Championship championship);
  Future<void> deleteChampionship(String id);
}

class ChampionshipRepositoryImpl implements ChampionshipRepository {
  final ChampionshipService _championshipService;

  ChampionshipRepositoryImpl({required ChampionshipService championshipService})
    : _championshipService = championshipService;

  @override
  Future<Championship> registerChampionship(Championship championship) async {
    try {
      return await _championshipService.register(championship);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar o campeonato.',
      );
    }
  }

  @override
  Future<List<Championship>> getAllChampionships() async {
    try {
      return await _championshipService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar campeonatos.');
    }
  }

  @override
  Future<void> updateChampionship(Championship championship) async {
    try {
      await _championshipService.update(championship);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar campeonato.');
    }
  }

  @override
  Future<void> deleteChampionship(String id) async {
    try {
      await _championshipService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar campeonato.');
    }
  }
}
