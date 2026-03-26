import '../database/app_database.dart';

class TeamsSeed {
  TeamsSeed._();

  static const List<String> legacySeedPlayerIds = [
    'player-01',
    'player-02',
    'player-03',
    'player-04',
    'player-05',
    'player-06',
    'player-07',
    'player-08',
    'player-09',
    'player-10',
    'player-11',
    'player-12',
  ];

  static Future<void> seed(
    // ignore: unused_element_parameter
    AppDatabase database,
  ) async {}

  static Future<void> cleanupLegacySeedData(AppDatabase database) async {
    final existingPlayers = await database.select(database.teamDrawPlayers).get();
    if (existingPlayers.isEmpty) {
      return;
    }

    final existingIds = existingPlayers.map((player) => player.id).toSet();
    final legacyIds = legacySeedPlayerIds.toSet();
    final containsOnlyLegacySeedPlayers = existingIds.difference(legacyIds).isEmpty;
    if (!containsOnlyLegacySeedPlayers) {
      return;
    }

    await database.transaction(() async {
      await (database.delete(database.waitingQueueEntries)
            ..where((tbl) => tbl.playerId.isIn(legacySeedPlayerIds)))
          .go();
      await (database.delete(database.savedGroupWaitingPlayers)
            ..where((tbl) => tbl.playerId.isIn(legacySeedPlayerIds)))
          .go();
      await (database.delete(database.savedTeamPlayers)
            ..where((tbl) => tbl.playerId.isIn(legacySeedPlayerIds)))
          .go();
      await (database.delete(database.drawSessionTeamPlayers)
            ..where((tbl) => tbl.playerId.isIn(legacySeedPlayerIds)))
          .go();
      await (database.delete(database.teamDrawPlayers)..where((tbl) => tbl.id.isIn(legacySeedPlayerIds))).go();
    });
  }
}
