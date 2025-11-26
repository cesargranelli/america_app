import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/data/repositories/league_repository.dart';
import 'src/data/services/league_service.dart';
import 'src/ui/league/view_models/league_registration_view_model.dart';
import 'src/ui/league/views/league_registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AmericaApp());
}

class AmericaApp extends StatelessWidget {
  const AmericaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Provedor do Dio (dependência mais básica)
        Provider<Dio>(
          create: (_) => Dio(BaseOptions(baseUrl: 'http://localhost:8081')),
        ),
        // 2. Provedor do Service, que depende do Dio
        Provider<LeagueService>(
          create: (context) => LeagueServiceImpl(
            dio: context.read<Dio>(), // Lê a instância de Dio registrada acima
          ),
        ),
        // 3. Provedor do Repository, que depende do Service
        Provider<LeagueRepository>(
          create: (context) => LeagueRepositoryImpl(
            leagueService: context.read<LeagueService>(), // Lê o Service
          ),
        ),
        // 4. Provedor do ViewModel, que é um ChangeNotifier
        ChangeNotifierProvider<LeagueRegistrationViewModel>(
          create: (context) => LeagueRegistrationViewModel(
            leagueRepository: context
                .read<LeagueRepository>(), // Lê o Repository
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App America',
        home: Consumer<LeagueRegistrationViewModel>(
          // stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, viewModel, _) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            // if (snapshot.hasData) {
            //   // return HomeScreen();
            //   return LeagueRegistrationScreen(viewModel: viewModel);
            // } else {
            // return LoginScreen();
            return LeagueRegistrationScreen(viewModel: viewModel);
            // },
          },
        ),
      ),
    );
  }
}
