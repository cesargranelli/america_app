import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import '../../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  UserProfile? _userProfile;
  bool _isLoadingProfile = true;
  String? _profileError;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _profileError = null;
    });
    try {
      final User? currentUser = _authService.getCurrentUser();
      if (currentUser != null) {
        _userProfile = await _authService.getUserProfile(currentUser.uid);
        print('Perfil do usuário: $_userProfile');
        if (_userProfile?.email == null) {
          _profileError = 'Perfil do usuário não encontrado no Firestore.';
        }
      } else {
        _profileError = 'Nenhum usuário logado.';
      }
    } catch (e) {
      _profileError = 'Erro ao carregar perfil: ${e.toString()}';
    } finally {
      setState(() {
        _isLoadingProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _authService.getCurrentUser(); // Pega o usuário logado

    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              // O StreamBuilder em main.dart detectará o logout
              // e navegará de volta para a LoginScreen.
            },
          ),
        ],
      ),
      body: Center(
        child: _isLoadingProfile
            ? const CircularProgressIndicator()
            : _profileError != null
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _profileError!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Bem-vindo!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  if (_userProfile != null)
                    Text(
                      'Olá, ${_userProfile!.email}!', // Exibe o nome do perfil
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 10),
                  if (user != null)
                    Text(
                      'Seu e-mail: ${user.email}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                    },
                    child: const Text('Sair'),
                  ),
                ],
              ),
      ),
    );
  }
}
