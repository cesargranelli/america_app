import 'package:flutter/material.dart';

class PresentationChampionshipPage extends StatelessWidget {
  const PresentationChampionshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Campeonatos')),
      body: Center(
        child: Text(
          'Página de Apresentação dos Campeonatos',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
