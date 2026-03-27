import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/scoreboard/models/match_score.dart' as scoreboard_model;
import '../../../features/scoreboard/models/set_score.dart';
import '../../../features/teams/models/team_draw_player.dart' as team_models;
import '../../../features/teams/models/waiting_player.dart' as team_models;
import '../database/app_database.dart';

class MatchesRepository {
  MatchesRepository(this._database);

  final AppDatabase _database;

  static const Duration historyRetention = Duration(days: 7);

  Future<void> cleanupExpiredHistory() async {
    final cutoff = DateTime.now().subtract(historyRetention).toIso8601String();
    final expiredMatches = await (_database.select(_database.matches)
          ..where((tbl) => tbl.createdAt.isSmallerThanValue(cutoff)))
        .get();
    final expiredIds = expiredMatches.map((match) => match.id).toList();
    if (expiredIds.isEmpty) {
      return;
    }

    await _database.transaction(() async {
      await (_database.delete(_database.matchSets)..where((tbl) => tbl.matchId.isIn(expiredIds))).go();
      await (_database.delete(_database.matches)..where((tbl) => tbl.id.isIn(expiredIds))).go();
    });
  }

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
              sourceType: Value(match.sourceType.value),
              winnerTeam: Value(match.winnerTeam),
              savedTeamGroupId: Value(match.savedTeamGroupId),
              savedTeamGroupTitle: Value(match.savedTeamGroupTitle),
              teamAOriginTeamId: Value(match.teamAOriginTeamId),
              teamBOriginTeamId: Value(match.teamBOriginTeamId),
              teamAPlayersJson: Value(_encodePlayers(match.teamAPlayers)),
              teamBPlayersJson: Value(_encodePlayers(match.teamBPlayers)),
              waitingPlayersSnapshotJson: Value(_encodeWaitingPlayers(match.waitingPlayersSnapshot)),
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
      sourceType: scoreboard_model.MatchSourceType.fromValue(row.sourceType),
      winnerTeam: row.winnerTeam,
      createdAt: DateTime.parse(row.createdAt),
      finishedAt: row.finishedAt == null ? null : DateTime.parse(row.finishedAt!),
      savedTeamGroupId: row.savedTeamGroupId,
      savedTeamGroupTitle: row.savedTeamGroupTitle,
      teamAPlayers: _decodePlayers(row.teamAPlayersJson),
      teamBPlayers: _decodePlayers(row.teamBPlayersJson),
      teamAOriginTeamId: row.teamAOriginTeamId,
      teamBOriginTeamId: row.teamBOriginTeamId,
      waitingPlayersSnapshot: _decodeWaitingPlayers(row.waitingPlayersSnapshotJson),
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

  String? _encodePlayers(List<team_models.TeamDrawPlayer> players) {
    if (players.isEmpty) {
      return null;
    }
    return jsonEncode(players.map((player) => player.toJson()).toList());
  }

  List<team_models.TeamDrawPlayer> _decodePlayers(String? source) {
    if (source == null || source.isEmpty) {
      return const [];
    }
    final decoded = jsonDecode(source) as List<dynamic>;
    return decoded
        .map((item) => team_models.TeamDrawPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  String? _encodeWaitingPlayers(List<team_models.WaitingPlayer> players) {
    if (players.isEmpty) {
      return null;
    }
    return jsonEncode(players.map((player) => player.toJson()).toList());
  }

  List<team_models.WaitingPlayer> _decodeWaitingPlayers(String? source) {
    if (source == null || source.isEmpty) {
      return const [];
    }
    final decoded = jsonDecode(source) as List<dynamic>;
    return decoded
        .map((item) => team_models.WaitingPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }
}
