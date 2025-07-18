import 'package:america_app/views/standing/standing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/core/ui/themes/america_theme.dart';
import 'src/core/ui/themes/text_theme.dart';
import 'views/common/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AmericaApp());
}

class AmericaApp extends StatelessWidget {
  const AmericaApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Lexend", "Lexend");

    AmericaTheme americaTheme = AmericaTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App America',
      theme: americaTheme.light().copyWith(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // return HomeScreen();
            return FlagStandingsScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
