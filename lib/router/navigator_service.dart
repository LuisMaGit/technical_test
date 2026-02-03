import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> goTo(String routeName, {dynamic arguments}) async {
    final nav = navigatorKey.currentState;
    if (nav == null || !nav.mounted) {
      return Future.value();
    }

    return await nav.pushNamed(routeName, arguments: arguments);
  }

  void goBack([dynamic arguments]) {
    final nav = navigatorKey.currentState;
    if (nav == null || !nav.canPop()) return;

    nav.pop(arguments);
  }
}
