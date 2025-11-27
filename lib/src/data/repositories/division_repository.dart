import '../../domain/models/division.dart';
import '../services/division_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class DivisionRepository {
  Future<Division> registerDivision(Division division);
  Future<List<Division>> getAllDivisions();
  Future<void> updateDivision(Division division);
  Future<void> deleteDivision(String id);
}

class DivisionRepositoryImpl implements DivisionRepository {
  final DivisionService _divisionService;

  DivisionRepositoryImpl({required DivisionService divisionService})
      : _divisionService = divisionService;

  @override
  Future<Division> registerDivision(Division division) async {
    try {
      return await _divisionService.register(division);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar a divisão.',
      );
    }
  }

  @override
  Future<List<Division>> getAllDivisions() async {
    try {
      return await _divisionService.getAll();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar divisões.');
    }
  }

  @override
  Future<void> updateDivision(Division division) async {
    try {
      await _divisionService.update(division);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar divisão.');
    }
  }

  @override
  Future<void> deleteDivision(String id) async {
    try {
      await _divisionService.delete(id);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar divisão.');
    }
  }
}
