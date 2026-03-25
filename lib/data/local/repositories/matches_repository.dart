import 'package:drift/drift.dart';

import '../../../features/scoreboard/models/match_score.dart' as scoreboard_model;
import '../../../features/scoreboard/models/set_score.dart';
import '../database/app_database.dart';

class MatchesRepository {
  MatchesRepository(this._database);

  final AppDatabase _database;

  Future<List<scoreboard_model.MatchScore>> listHistory() async {
    final rows = await (_database.select(_database.matches)
          ..orderBy([
            (t) => OrderingTerm.desc(t.finishedAt),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .get();
    return Future.wait(rows.map(_mapMatchRow));
  }

  Future<scoreboard_model.MatchScore?> getMatchById(String id) async {
    final row = await (_database.select(_database.matches)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapMatchRow(row);
  }

  Future<void> saveFinishedMatch(scoreboard_model.MatchScore match) async {
    await _database.transaction(() async {
      await _database.into(_database.matches).insertOnConflictUpdate(
            MatchesCompanion.insert(
              id: match.id,
              teamAName: match.teamAName,
              teamBName: match.teamBName,
              teamASetsWon: match.teamASetsWon,
              teamBSetsWon: match.teamBSetsWon,
              currentSet: match.currentSet,
              servingTeam: match.servingTeam.value,
              matchStatus: match.matchStatus.value,
              winnerTeam: Value(match.winnerTeam),
              createdAt: match.createdAt.toIso8601String(),
              finishedAt: Value(match.finishedAt?.toIso8601String()),
            ),
          );

      await (_database.delete(_database.matchSets)..where((tbl) => tbl.matchId.equals(match.id))).go();

      await _database.batch((batch) {
        for (final set in match.sets) {
          batch.insert(
            _database.matchSets,
            MatchSetsCompanion.insert(
              id: '${match.id}-set-${set.setNumber}',
              matchId: match.id,
              setNumber: set.setNumber,
              teamAScore: set.teamAScore,
              teamBScore: set.teamBScore,
              winnerTeamId: set.winnerTeamId,
              targetPoints: set.targetPoints,
            ),
          );
        }
      });
    });
  }

  Future<void> clearAll() async {
    await _database.transaction(() async {
      await _database.delete(_database.matchSets).go();
      await _database.delete(_database.matches).go();
    });
  }

  Future<scoreboard_model.MatchScore> _mapMatchRow(Matche row) async {
    final setRows = await (_database.select(_database.matchSets)
          ..where((tbl) => tbl.matchId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.setNumber)]))
        .get();

    return scoreboard_model.MatchScore(
      id: row.id,
      teamAName: row.teamAName,
      teamBName: row.teamBName,
      currentSet: row.currentSet,
      sets: setRows.map(_mapSet).toList(),
      teamASetsWon: row.teamASetsWon,
      teamBSetsWon: row.teamBSetsWon,
      servingTeam: scoreboard_model.TeamSide.fromValue(row.servingTeam),
      matchStatus: scoreboard_model.MatchStatus.fromValue(row.matchStatus),
      winnerTeam: row.winnerTeam,
      createdAt: DateTime.parse(row.createdAt),
      finishedAt: row.finishedAt == null ? null : DateTime.parse(row.finishedAt!),
    );
  }

  SetScore _mapSet(MatchSet row) {
    return SetScore(
      setNumber: row.setNumber,
      teamAScore: row.teamAScore,
      teamBScore: row.teamBScore,
      winnerTeamId: row.winnerTeamId,
      targetPoints: row.targetPoints,
    );
  }
}
