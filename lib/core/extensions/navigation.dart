import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigatorExtension on BuildContext {
  void pushTo(String routeName) {
    push(routeName);
  }

  void pushToBase(String routName) {
    go(
      routName,
    );
  }

  void pushToReplace(String routName, {Object? extra}) {
    pushReplacement(routName, extra: extra);
  }
}
