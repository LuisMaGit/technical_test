import 'package:flutter/material.dart';
import 'package:test_doodle/app_contracts.dart';
import 'package:test_doodle/router/navigator_service.dart';
import 'package:test_doodle/features/theme_builder/theme_builder.dart';
import 'package:test_doodle/features/transactions/transactions.dart';
import 'package:test_doodle/locator.dart';
import 'package:test_doodle/router/routes_handler.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = locator<NavigatorService>().navigatorKey;
    return ThemeBuilder(
      builder: (context, colors) => MaterialApp(
        title: AppContracts.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: colors.doodlePrimary,
          canvasColor: colors.background,
          scaffoldBackgroundColor: colors.background,
          useMaterial3: false,
        ),
        home: const Transactions(),
      ),
    );
  }
}
