import 'package:flutter/material.dart';

import '../../../domain/models/league.dart';

class LeagueScreen extends StatelessWidget {
  final League league;

  const LeagueScreen({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liga'), centerTitle: true, elevation: 0.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(league.name),
              const SizedBox(height: 20.0),
              Text(league.acronym),
              const SizedBox(height: 20.0),
              Text(league.foundationDate),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
