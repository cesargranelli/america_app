import 'package:america_app/src/user/ui/page/my_app_page.dart';
import 'package:flutter/material.dart';

import '../../src/admin/ui/pages/admin_home_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Escolha seu perfil:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
              },
              child: const Text("Administrador"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAppPage(title: "My App Page"),
                  ),
                );
              },
              child: const Text("Usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
