import 'package:flutter/material.dart';

Future<dynamic> push(String named, {dynamic arg}) {
  return Navigator.of(navigator.currentContext!).pushNamed(named, arguments: arg);
}

Future<dynamic> replacement(String named, {dynamic arg}) {
  return Navigator.of(navigator.currentContext!).pushReplacementNamed(named, arguments: arg);
}

Future<dynamic> pushAndRemoveUntil(String named, {dynamic arg, String? until}) {
  return Navigator.of(navigator.currentContext!).pushNamedAndRemoveUntil(named, (route) => route.settings.name == until, arguments: arg);
}

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
