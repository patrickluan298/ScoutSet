import 'package:flutter/foundation.dart';

import '../models/sport_mode.dart';

class SportModeService {
  SportModeService._();

  static final SportModeService instance = SportModeService._();

  final ValueNotifier<SportMode?> modeNotifier = ValueNotifier<SportMode?>(null);

  bool _initialized = false;

  SportMode? get currentMode => modeNotifier.value;
  bool get hasSelection => currentMode != null;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    modeNotifier.value = null;
    _initialized = true;
  }

  void selectMode(SportMode mode) {
    modeNotifier.value = mode;
  }

  void clearSelection() {
    modeNotifier.value = null;
  }

  void resetState() {
    _initialized = false;
    modeNotifier.value = null;
  }

  @visibleForTesting
  void resetForTesting() {
    resetState();
  }
}
