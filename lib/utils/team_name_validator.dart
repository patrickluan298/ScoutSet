import 'package:flutter/services.dart';

const int kMaxTeamNameLength = 10;
final RegExp kAllowedTeamNameCharacters = RegExp(r'[A-Za-z0-9À-ÖØ-öø-ÿ ]');
final RegExp kAllowedTeamNamePattern = RegExp(r'^[A-Za-z0-9À-ÖØ-öø-ÿ ]+$');

List<TextInputFormatter> teamNameInputFormatters() {
  return [
    FilteringTextInputFormatter.allow(kAllowedTeamNameCharacters),
    LengthLimitingTextInputFormatter(kMaxTeamNameLength),
  ];
}

String? validateTeamNameValue(
  String? value,
  String fieldLabel,
) {
  final normalizedValue = (value ?? '').trim();
  if (normalizedValue.isEmpty) {
    return 'Informe o nome do $fieldLabel.';
  }
  if (!kAllowedTeamNamePattern.hasMatch(normalizedValue)) {
    return 'Use apenas letras, numeros e espacos.';
  }
  return null;
}

bool hasDuplicatedTeamNames(Iterable<String> names) {
  final normalized = names
      .map((name) => name.trim().toLowerCase())
      .where((name) => name.isNotEmpty)
      .toList();
  return normalized.toSet().length != normalized.length;
}

String? validateDistinctTeamName(
  String? value,
  String fieldLabel,
  Iterable<String> allNames,
) {
  final validation = validateTeamNameValue(value, fieldLabel);
  if (validation != null) {
    return validation;
  }
  if (hasDuplicatedTeamNames(allNames)) {
    return 'Os times precisam ter nomes diferentes.';
  }
  return null;
}
