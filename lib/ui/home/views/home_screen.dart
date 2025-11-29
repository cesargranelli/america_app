import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../athlete/views/athlete_list_screen.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../auth/views/login_screen.dart';
import '../../championship/views/championship_list_screen.dart';
import '../../conference/views/conference_list_screen.dart';
import '../../division/views/division_list_screen.dart';
import '../../league/views/league_registration_screen.dart';
import '../../standings/views/standings_screen.dart';
import '../../team/views/team_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('America App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              authViewModel.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFAC638)),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Ligas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeagueRegistrationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_football),
              title: const Text('Campeonatos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChampionshipListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_work),
              title: const Text('Conferências'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConferenceListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_module),
              title: const Text('Divisões'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DivisionListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Equipes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Atletas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AthleteListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Classificação'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StandingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Bem-vindo ao America App!')),
    );
  }
}
