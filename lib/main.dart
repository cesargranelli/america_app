import 'package:flutter/material.dart';

import 'src/admin/ui/page/admin_home_page.dart';
import 'src/ui/core/themes/custom_theme.dart';

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
      theme: customTheme(),
      home: AdminHomePage(),
    );
  }
}
