import 'package:flutter/material.dart';

import 'models/team_draw_result.dart';
import 'widgets/draw_options_sheet.dart';

Future<OddPlayerHandling?> resolveOddPlayerHandling(
  BuildContext context,
  int selectedPlayersCount,
) async {
  if (selectedPlayersCount.isEven) {
    return OddPlayerHandling.extraPlayerOnTeam;
  }

  return DrawOptionsSheet.show(context);
}
