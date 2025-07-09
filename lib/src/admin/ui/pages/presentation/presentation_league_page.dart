import 'package:flutter/material.dart';

import '../../../../core/model/league.dart';
import '../../viewmodel/league_viewmodel.dart';
import '../registration/registration_league_page.dart';

class PresentationLeaguePage extends StatelessWidget {
  const PresentationLeaguePage({super.key, required this.viewModel});

  final LeagueViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ligas'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              viewModel.notifyerListeners();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Gerencie suas Ligas',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          return ListView.builder(
            itemCount: viewModel.leagues.length,
            itemBuilder: (context, index) {
              final league = viewModel.leagues[index];
              return _buildLeagueCard(league);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationLeaguePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _buildLeagueCard(League league) {
  return Ink(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.lightGreen.shade100, width: 0.5),
      shape: BoxShape.rectangle,
    ),
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Ink(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.lightGreen.shade100,
                    width: 0.5,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  league.logo,
                  fit: BoxFit.scaleDown,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        league.acronym,
                        style: TextStyle(
                          color: const Color(0xFF9E8747),
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    league.acronym,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(league.name, style: TextStyle(fontSize: 12.0)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20.0),
          ],
        ),
      ),
    ),
  );
}
