import 'dart:collection';

import 'package:flutter/material.dart';

import '../../../core/model/league.dart';

class LeagueViewModel extends ChangeNotifier {
  final List<League> _leagues = [
    League(
      'São Paulo',
      'SP',
      id: '1',
      name: 'Associação Paulista de Futebol Americano',
      description: 'Liga que organiza o futebol americano em São Paulo.',
      acronym: 'APFA',
      logo:
          'https://www.salaooval.com.br/wp-content/uploads/2016/05/campeonato_paulista_flag.png',
      country: 'Brasil',
    ),
    League(
      'São Paulo',
      'SP',
      id: '2',
      name: 'Federação de Futebol Americano de São Paulo',
      description: 'Liga que organiza o futebol americano no Rio de Janeiro.',
      acronym: 'FEFASP',
      // logo: 'https://placehold.co/60x60/F4F0E6/9E8747?text=FEFASP',
      logo:
          'https://fefasp.com.br/wp-content/uploads/2021/06/Logo-Novo-1-230x300.png',
      country: 'Brasil',
    ),
  ];

  UnmodifiableListView<League> get leagues => UnmodifiableListView(_leagues);

  void notifyerListeners() {
    super.notifyListeners();
  }
}
