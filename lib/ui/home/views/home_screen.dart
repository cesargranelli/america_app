import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../core/routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('America App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthViewModel>().signOut();
              context.go(AppRoutes.signIn);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 24),
            Text('Bem-vindo ao America App!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.leagues),
              icon: const Icon(Icons.emoji_events),
              label: const Text('Ver Ligas'),
            ),
          ],
        ),
      ),
    );
  }
}
