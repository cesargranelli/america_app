import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/championship.dart';
import '../../domain/models/league.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class ChampionshipService {
  Future<Championship> register(Championship championship);

  Future<List<Championship>> getAll();

  Future<List<Championship>> getChampionships(League league);

  Future<void> update(Championship championship);

  Future<void> delete(String id);
}

class ChampionshipServiceImpl implements ChampionshipService {
  final FirebaseFirestore _firestore;

  ChampionshipServiceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _championshipsCollection =>
      _firestore.collection('championships');

  @override
  Future<Championship> register(Championship championship) async {
    try {
      final docRef = await _championshipsCollection.add(championship.toJson());

      return Championship(
        id: docRef.id,
        name: championship.name,
        season: championship.season,
        startDate: championship.startDate,
        endDate: championship.endDate,
        leagueId: championship.leagueId,
      );
    } on FirebaseException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar campeonato no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar o campeonato. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de campeonato',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Championship>> getAll() async {
    try {
      final snapshot = await _championshipsCollection.get();
      return snapshot.docs.map((doc) {
        return Championship.fromFirestore(doc.id, doc.data());
      }).toList();
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao buscar campeonatos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar campeonatos.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao buscar campeonatos',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Championship>> getChampionships(League league) async {
    try {
      final snapshot = await _championshipsCollection
          .where("leagueId", isEqualTo: league.id)
          .get();
      return snapshot.docs.map((doc) {
        return Championship.fromFirestore(doc.id, doc.data());
      }).toList();
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao buscar campeonatos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar campeonatos.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao buscar campeonatos',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<void> update(Championship championship) async {
    try {
      await _championshipsCollection
          .doc(championship.id)
          .update(championship.toJson());
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao atualizar campeonato', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar campeonato.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao atualizar campeonato',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _championshipsCollection.doc(id).delete();
    } on FirebaseException catch (e, s) {
      AppLogger.error('Erro ao deletar campeonato', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar campeonato.');
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado ao deletar campeonato',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }
}
