import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';

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
              context.go(AppRoutes.signIn);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Ligas'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.leagueRegistration);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_football),
              title: const Text('Campeonatos'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.championships);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_work),
              title: const Text('Conferências'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.conferences);
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_module),
              title: const Text('Divisões'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.divisions);
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Equipes'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.teams);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Atletas'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.athletes);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Classificação'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.standings);
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Bem-vindo ao America App!')),
    );
  }
}
