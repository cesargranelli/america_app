import '../../domain/models/athlete.dart';
import '../services/athlete_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class AthleteRepository {
  Future<Athlete> registerAthlete(Athlete athlete);
  Future<List<Athlete>> getAllAthletes();
  Future<void> updateAthlete(Athlete athlete);
  Future<void> deleteAthlete(String id);
}

class AthleteRepositoryImpl implements AthleteRepository {
  final AthleteService _athleteService;

  AthleteRepositoryImpl({required AthleteService athleteService})
    : _athleteService = athleteService;

  @override
  Future<Athlete> registerAthlete(Athlete athlete) async {
    try {
      return await _athleteService.register(athlete);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar o atleta.',
      );
    }
  }

  @override
  Future<List<Athlete>> getAllAthletes() async {
    try {
      return await _athleteService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar atletas.');
    }
  }

  @override
  Future<void> updateAthlete(Athlete athlete) async {
    try {
      await _athleteService.update(athlete);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar atleta.');
    }
  }

  @override
  Future<void> deleteAthlete(String id) async {
    try {
      await _athleteService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar atleta.');
    }
  }
}
