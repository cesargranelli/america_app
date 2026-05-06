import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/league.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class LeagueService {
  Future<League> register(League league);

  Future<List<League>> getAll();

  Future<void> update(League league);

  Future<void> delete(String id);
}

class LeagueServiceImpl implements LeagueService {
  final FirebaseFirestore _firestore;

  LeagueServiceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _leaguesCollection =>
      _firestore.collection('leagues');

  @override
  Future<League> register(League league) async {
    try {
      final docRef = await _leaguesCollection.add(league.toJson());
      return League(
        id: docRef.id,
        name: league.name,
        acronym: league.acronym,
        code: league.code,
      );
    } on FirebaseException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar liga no Firestore',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar a liga. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de liga',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<League>> getAll() async {
    try {
      final snapshot = await _leaguesCollection.get();
      return snapshot.docs.map((doc) {
        return League.fromFirestore(doc.id, doc.data());
      }).toList();
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao buscar ligas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar ligas.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao buscar ligas',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<void> update(League league) async {
    try {
      await _leaguesCollection.doc(league.id).update(league.toJson());
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao atualizar liga', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar liga.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao atualizar liga',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _leaguesCollection.doc(id).delete();
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao deletar liga', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar liga.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao deletar liga',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }
}
