import 'package:flutter/cupertino.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_props.dart';
import 'package:test_doodle/router/routes.dart';

Route _cupertino(Widget route, RouteSettings settings) {
  return CupertinoPageRoute(settings: settings, builder: (_) => route);
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.transactionEditor:
      final props = settings.arguments as TransactionEditorProps;
      return _cupertino(TransactionEditor(props: props), settings);

    default:
      return _cupertino(const SizedBox(), settings);
  }
}
