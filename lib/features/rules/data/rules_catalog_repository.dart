import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/sport_mode.dart';
import '../models/rules_models.dart';

class RulesCatalogRepository {
  const RulesCatalogRepository();

  static const String assetPath = 'assets/data/rules_official_catalog.json';

  Future<RulesCatalog> load({
    required SportMode sportMode,
    AssetBundle? bundle,
  }) async {
    if (sportMode == SportMode.beach) {
      return const RulesCatalog(
        sourceTitle: 'Praia',
        categories: [],
        chapters: [],
        documents: [],
      );
    }

    final resolvedBundle = bundle ?? rootBundle;
    final jsonString = await resolvedBundle.loadString(assetPath);
    return loadFromString(jsonString);
  }

  RulesCatalog loadFromString(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    return RulesCatalog.fromJson(decoded);
  }
}
