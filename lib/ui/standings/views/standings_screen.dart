import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../view_models/standings_view_model.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, we hardcode a championship ID or pass it.
    // Assuming we want to show standings for a default or selected championship.
    const String defaultChampionshipId = '1';

    return ChangeNotifierProvider(
      create: (context) =>
          StandingsViewModel(standingRepository: context.read())
            ..loadStandings(defaultChampionshipId),
      child: const _StandingsView(),
    );
  }
}

class _StandingsView extends StatelessWidget {
  const _StandingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Classificação'), centerTitle: true),
      body: Consumer<StandingsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == StandingsState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == StandingsState.error) {
            return Center(
              child: Text(
                viewModel.errorMessage ?? 'Erro ao carregar classificação',
              ),
            );
          } else if (viewModel.standings.isEmpty) {
            return const Center(
              child: Text('Nenhuma classificação disponível.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'V',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'D',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Pts',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // List
                Expanded(
                  child: ListView.separated(
                    itemCount: viewModel.standings.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final standing = viewModel.standings[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(standing.teamName),
                              ),
                            ),
                            Expanded(
                              child: Center(child: Text('${standing.wins}')),
                            ),
                            Expanded(
                              child: Center(child: Text('${standing.losses}')),
                            ),
                            Expanded(
                              child: Center(child: Text('${standing.points}')),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
