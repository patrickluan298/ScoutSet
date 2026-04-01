import 'package:flutter/material.dart';

Future<T?> pushPage<T>(
  BuildContext context,
  Widget page,
) {
  return Navigator.of(
    context,
  ).push<T>(MaterialPageRoute(builder: (_) => page));
}

Future<T?> pushPageAndReload<T>(
  BuildContext context,
  Widget page, {
  required Future<void> Function() onReturn,
}) async {
  final result = await pushPage<T>(context, page);
  if (!context.mounted) {
    return result;
  }
  await onReturn();
  return result;
}
