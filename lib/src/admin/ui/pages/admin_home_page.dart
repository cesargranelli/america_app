import 'package:flutter/material.dart';

import '../viewmodel/league_viewmodel.dart';
import 'presentation/presentation_championship_page.dart';
import 'presentation/presentation_conference_page.dart';
import 'presentation/presentation_divisional_page.dart';
import 'presentation/presentation_league_page.dart';
import 'presentation/presentation_player_page.dart';
import 'presentation/presentation_team_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrativo'), centerTitle: true),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
          _navigateToPage(context, index);
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sophia Carter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'sophia.carter@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          NavigationDrawerDestination(
            icon: const Icon(Icons.sports_football_outlined),
            selectedIcon: const Icon(Icons.sports_football),
            label: const Text('Ligas'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.emoji_events_outlined),
            selectedIcon: const Icon(Icons.emoji_events),
            label: const Text('Campeonatos'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.account_tree_outlined),
            selectedIcon: const Icon(Icons.account_tree),
            label: const Text('Conferências'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.view_list_outlined),
            selectedIcon: const Icon(Icons.view_list),
            label: const Text('Divisões'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.shield_moon_outlined),
            selectedIcon: const Icon(Icons.shield_moon),
            label: const Text('Agremiações'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.groups_outlined),
            selectedIcon: const Icon(Icons.groups),
            label: const Text('Atletas'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
            child: Divider(),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: const Text('Configurações'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.help_outline),
            selectedIcon: const Icon(Icons.help),
            label: const Text('Ajuda'),
          ),
        ],
      ),
      body: Center(child: _getPageContent(_selectedIndex)),
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _getPageName(index)),
    );
  }

  Widget _getPageName(int index) {
    switch (index) {
      case 0:
        return PresentationLeaguePage(viewModel: LeagueViewModel());
      case 1:
        return PresentationChampionshipPage();
      case 2:
        return PresentationConferencePage();
      case 3:
        return PresentationDivisionalPage();
      case 4:
        return PresentationTeamPage();
      case 5:
        return PresentationPlayerPage();
      default:
        return PresentationLeaguePage(viewModel: LeagueViewModel());
    }
  }

  Widget _getPageContent(int index) {
    String pageName = PresentationLeaguePage(
      viewModel: LeagueViewModel(),
    ).toString().replaceAll("Presentation", "");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Você está em:',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          pageName,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Botão da página $pageName pressionado!')),
            );
          },
          child: Text('Ação na página $pageName'),
        ),
      ],
    );
  }
}
