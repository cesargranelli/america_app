import 'package:flutter/material.dart';

import 'src/admin/ui/page/register_league_page.dart';

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
      home: RegisterLeaguePage(),
    );
  }
}
