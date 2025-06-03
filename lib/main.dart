import 'package:flutter/material.dart';

import 'src/user/ui/page/my_app_teams_page9.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App America',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        appBarTheme: AppBarTheme(backgroundColor: Colors.lightGreen.shade300),
      ),
      home: MyAppTeamsPage9(),
    );
  }
}
