import 'package:flutter/material.dart';

import 'src/admin/ui/pages/admin_home_page.dart';
import 'src/core/ui/themes/america_theme.dart';
import 'src/core/ui/themes/text_theme.dart';

void main() {
  runApp(const AmericaApp());
}

class AmericaApp extends StatelessWidget {
  const AmericaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Lexend", "Lexend");

    AmericaTheme americaTheme = AmericaTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App America',
      theme: brightness == Brightness.light
          ? americaTheme.light().copyWith()
          : americaTheme.dark(),
      home: AdminHomePage(),
    );
  }
}
