import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../domain/models/championship.dart';
import '../../conference/views/conference_list_screen.dart';

class ChampionshipScreen extends StatefulWidget {
  final Championship championship;

  const ChampionshipScreen({super.key, required this.championship});

  @override
  State<ChampionshipScreen> createState() => _ChampionshipScreenState();
}

class _ChampionshipScreenState extends State<ChampionshipScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.championship.name), centerTitle: true),
      body: _selectedIndex == 0 ? _buildHome() : const ConferenceListScreen(),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.group_work),
            title: const Text("Conferências"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.championship.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Temporada: ${widget.championship.season}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text('Início: ${widget.championship.startDate}'),
          const SizedBox(height: 4),
          Text('Fim: ${widget.championship.endDate}'),
        ],
      ),
    );
  }
}
