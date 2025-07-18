import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/standings.dart';
import '../models/team_standings.dart';

class StandingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Standings?> getStandings(String championship) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('standings')
          .doc(championship)
          .get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        var map = Map<String, List<TeamStanding>>.from(data as Map);
        print(data);
        return Standings(
          competitionStandings:
              Map<String, Map<String, List<TeamStanding>>>.from(data as Map),
          // uid: data['uuid'] ?? '',
          // email: data['email'] ?? '',
          // roles: List<String>.from(data['roles'] as List),
          // createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      print('Erro ao buscar perfil do usuário: $e');
      return null;
    }
  }
}
