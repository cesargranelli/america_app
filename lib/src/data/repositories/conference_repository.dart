import '../../domain/models/conference.dart';
import '../services/conference_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class ConferenceRepository {
  Future<Conference> registerConference(Conference conference);
  Future<List<Conference>> getAllConferences();
  Future<void> updateConference(Conference conference);
  Future<void> deleteConference(String id);
}

class ConferenceRepositoryImpl implements ConferenceRepository {
  final ConferenceService _conferenceService;

  ConferenceRepositoryImpl({required ConferenceService conferenceService})
      : _conferenceService = conferenceService;

  @override
  Future<Conference> registerConference(Conference conference) async {
    try {
      return await _conferenceService.register(conference);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar a conferência.',
      );
    }
  }

  @override
  Future<List<Conference>> getAllConferences() async {
    try {
      return await _conferenceService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar conferências.');
    }
  }

  @override
  Future<void> updateConference(Conference conference) async {
    try {
      await _conferenceService.update(conference);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar conferência.');
    }
  }

  @override
  Future<void> deleteConference(String id) async {
    try {
      await _conferenceService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar conferência.');
    }
  }
}
