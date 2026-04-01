import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  bool clearCurrent = true,
}) {
  final messenger = ScaffoldMessenger.of(context);
  if (clearCurrent) {
    messenger.clearSnackBars();
  }
  messenger.showSnackBar(SnackBar(content: Text(message)));
}
