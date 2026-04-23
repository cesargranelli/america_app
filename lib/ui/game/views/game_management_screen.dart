import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/play.dart';
import '../view_models/game_management_view_model.dart';

class GameManagementScreen extends StatelessWidget {
  final String gameId;

  const GameManagementScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          GameManagementViewModel(playRepository: context.read())
            ..loadPlays(gameId),
      child: _GameManagementView(gameId: gameId),
    );
  }
}

class _GameManagementView extends StatefulWidget {
  final String gameId;

  const _GameManagementView({required this.gameId});

  @override
  State<_GameManagementView> createState() => _GameManagementViewState();
}

class _GameManagementViewState extends State<_GameManagementView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  final TextEditingController _yardsToGoCtrl = TextEditingController();
  final TextEditingController _yardLineCtrl = TextEditingController();

  PlayType _selectedType = PlayType.run;
  int _quarter = 1;
  int _down = 1;

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _timeCtrl.dispose();
    _yardsToGoCtrl.dispose();
    _yardLineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Jogo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.push('/games/${widget.gameId}/timeline');
            },
          ),
        ],
      ),
      body: Consumer<GameManagementViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == GameManagementState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registrar Nova Jogada',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<PlayType>(
                        initialValue: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de Jogada',
                        ),
                        items: PlayType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.toString().split('.').last.toUpperCase(),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _quarter,
                              decoration: const InputDecoration(
                                labelText: 'Quarto',
                              ),
                              items: [1, 2, 3, 4].map((q) {
                                return DropdownMenuItem(
                                  value: q,
                                  child: Text('$qº Quarto'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _quarter = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _timeCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Tempo (MM:SS)',
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _down,
                              decoration: const InputDecoration(
                                labelText: 'Descida (Down)',
                              ),
                              items: [1, 2, 3, 4].map((d) {
                                return DropdownMenuItem(
                                  value: d,
                                  child: Text('$dª Descida'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _down = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _yardsToGoCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Jardas para Avançar',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _yardLineCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Linha de Jardas (0-100)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            viewModel.registerPlay(
                              gameId: widget.gameId,
                              type: _selectedType,
                              description: _descriptionCtrl.text,
                              quarter: _quarter,
                              time: _timeCtrl.text,
                              down: _down,
                              yardsToGo:
                                  int.tryParse(_yardsToGoCtrl.text) ?? 10,
                              yardLine: int.tryParse(_yardLineCtrl.text) ?? 20,
                            );
                            _descriptionCtrl.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Registrar Jogada'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Jogadas Recentes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.recentPlays.length,
                  itemBuilder: (context, index) {
                    final play = viewModel.recentPlays[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${play.quarter}Q')),
                        title: Text(
                          play.type.toString().split('.').last.toUpperCase(),
                        ),
                        subtitle: Text(
                          '${play.description}\n${play.time} - ${play.down}ª & ${play.yardsToGo}',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
