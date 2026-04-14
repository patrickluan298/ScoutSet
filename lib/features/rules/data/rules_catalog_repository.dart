import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/sport_mode.dart';
import '../models/rules_models.dart';

class RulesCatalogRepository {
  const RulesCatalogRepository();

  static const String assetPath = 'assets/data/rules_official_catalog.json';
  static const String beachAssetPath =
      'assets/data/rules_official_catalog_beach.json';

  String assetPathForMode(SportMode sportMode) {
    return sportMode == SportMode.beach ? beachAssetPath : assetPath;
  }

  Future<RulesCatalog> load({
    required SportMode sportMode,
    AssetBundle? bundle,
  }) async {
    final resolvedBundle = bundle ?? rootBundle;
    final jsonString =
        await resolvedBundle.loadString(assetPathForMode(sportMode));
    return loadFromString(jsonString);
  }

  RulesCatalog loadFromString(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    return RulesCatalog.fromJson(decoded);
  }
}
