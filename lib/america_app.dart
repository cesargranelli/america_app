import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/core/providers/app_providers.dart';
import 'ui/core/routing/app_router.dart';
import 'ui/core/theme/app_theme.dart';

class AmericaApp extends StatelessWidget {
  const AmericaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.all,
      child: Builder(
        builder: (context) {
          final router = createAppRouter(context);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'App America',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
