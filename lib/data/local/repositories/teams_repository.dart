import 'package:drift/drift.dart';

import '../../../features/teams/models/draw_team.dart' as team_models;
import '../../../features/teams/models/saved_team_group.dart' as team_models;
import '../../../features/teams/models/saved_team.dart' as saved_models;
import '../../../features/teams/models/team_draw_player.dart' as team_models;
import '../../../features/teams/models/team_draw_result.dart' as team_models;
import '../../../features/teams/models/waiting_player.dart' as team_models;
import '../../../models/athlete.dart' as legacy_domain;
import '../../../models/team.dart' as legacy_domain;
import '../database/app_database.dart';

class TeamsRepository {
  TeamsRepository(this._database);

  final AppDatabase _database;

  Future<List<legacy_domain.Team>> listTeams() async {
    final teamRows = await _database.select(_database.teams).get();
    final athleteRows = await _database.select(_database.athletes).get();

    return teamRows.map((teamRow) {
      final athletes = athleteRows
          .where((athlete) => athlete.teamId == teamRow.id)
          .map(
            (athlete) => legacy_domain.Athlete(
              id: athlete.id,
              name: athlete.name,
              position: athlete.position,
              height: athlete.height,
              age: athlete.age,
              teamId: athlete.teamId,
            ),
          )
          .toList();

      return legacy_domain.Team(
        id: teamRow.id,
        name: teamRow.name,
        athletes: athletes,
      );
    }).toList();
  }

  Future<List<team_models.TeamDrawPlayer>> listPlayers() async {
    final rows = await (_database.select(_database.teamDrawPlayers)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([
            (t) => OrderingTerm(expression: t.name),
          ]))
        .get();

    return rows.map(_mapPlayerRow).toList();
  }

  Future<void> savePlayer(team_models.TeamDrawPlayer player) async {
    await _database.into(_database.teamDrawPlayers).insertOnConflictUpdate(
          TeamDrawPlayersCompanion.insert(
            id: player.id,
            name: player.name.trim(),
            position: player.position.trim(),
            level: player.level.value,
            createdAt: DateTime.now().toIso8601String(),
            isActive: Value(true),
          ),
        );
  }

  Future<void> deactivatePlayer(String playerId) async {
    await (_database.update(_database.teamDrawPlayers)..where((tbl) => tbl.id.equals(playerId))).write(
      const TeamDrawPlayersCompanion(
        isActive: Value(false),
      ),
    );
  }

  Future<void> saveDrawResult(team_models.TeamDrawResult result) async {
    await _database.transaction(() async {
      await _database.into(_database.drawSessions).insertOnConflictUpdate(
            DrawSessionsCompanion.insert(
              id: result.id,
              contextKey: result.contextKey,
              totalPlayers: result.totalPlayers,
              numberOfTeams: result.numberOfTeams,
              drawMode: result.drawMode.value,
              oddPlayerHandling: result.oddPlayerHandling.value,
              createdAt: result.createdAt.toIso8601String(),
            ),
          );

      await (_database.delete(_database.drawSessionTeams)
            ..where((tbl) => tbl.sessionId.equals(result.id)))
          .go();

      for (var teamIndex = 0; teamIndex < result.teams.length; teamIndex++) {
        final team = result.teams[teamIndex];
        await _database.into(_database.drawSessionTeams).insert(
              DrawSessionTeamsCompanion.insert(
                id: team.id,
                sessionId: result.id,
                name: team.name,
                sortOrder: teamIndex,
              ),
            );
        for (var playerIndex = 0; playerIndex < team.players.length; playerIndex++) {
          final player = team.players[playerIndex];
          await _database.into(_database.drawSessionTeamPlayers).insert(
                DrawSessionTeamPlayersCompanion.insert(
                  id: '${team.id}-${player.id}',
                  sessionTeamId: team.id,
                  playerId: player.id,
                  sortOrder: playerIndex,
                ),
              );
        }
      }
    });
  }

  Future<List<team_models.TeamDrawResult>> listDrawHistory() async {
    final sessionRows = await (_database.select(_database.drawSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return Future.wait(sessionRows.map(_mapDrawSessionRow));
  }

  Future<team_models.TeamDrawResult?> getLatestDrawResult() async {
    final row = await (_database.select(_database.drawSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _mapDrawSessionRow(row);
  }

  Future<void> replaceWaitingQueue(
    String contextKey,
    List<team_models.WaitingPlayer> waitingPlayers, {
    String? lastSessionId,
  }) async {
    await _database.transaction(() async {
      await (_database.delete(_database.waitingQueueEntries)
            ..where((tbl) => tbl.contextKey.equals(contextKey)))
          .go();

      for (final waitingPlayer in waitingPlayers) {
        await _database.into(_database.waitingQueueEntries).insert(
              WaitingQueueEntriesCompanion.insert(
                id: '$contextKey-${waitingPlayer.playerId}',
                contextKey: contextKey,
                playerId: waitingPlayer.playerId,
                playerName: waitingPlayer.playerName,
                waitingSince: waitingPlayer.waitingSince.toIso8601String(),
                priorityOrder: waitingPlayer.priorityOrder,
                lastSessionId: Value(lastSessionId),
              ),
            );
      }
    });
  }

  Future<List<team_models.WaitingPlayer>> listWaitingQueue(String contextKey) async {
    final rows = await (_database.select(_database.waitingQueueEntries)
          ..where((tbl) => tbl.contextKey.equals(contextKey))
          ..orderBy([(t) => OrderingTerm(expression: t.priorityOrder)]))
        .get();
    return rows.map(_mapWaitingRow).toList();
  }

  Future<List<team_models.WaitingPlayer>> listLatestWaitingPlayers() async {
    final latestSession = await (_database.select(_database.drawSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (latestSession == null) {
      return const [];
    }
    return listWaitingQueue(latestSession.contextKey);
  }

  Future<void> saveSavedTeamGroup(team_models.SavedTeamGroup group) async {
    await _database.transaction(() async {
      await _database.into(_database.savedTeamGroups).insertOnConflictUpdate(
            SavedTeamGroupsCompanion.insert(
              id: group.id,
              title: group.title,
              sourceType: group.sourceType.value,
              contextKey: Value(group.contextKey),
              notes: Value(group.notes),
              createdAt: group.createdAt.toIso8601String(),
            ),
          );

      await (_database.delete(_database.savedTeams)..where((tbl) => tbl.groupId.equals(group.id))).go();
      await (_database.delete(_database.savedGroupWaitingPlayers)
            ..where((tbl) => tbl.groupId.equals(group.id)))
          .go();

      for (var teamIndex = 0; teamIndex < group.teams.length; teamIndex++) {
        final team = group.teams[teamIndex];
        await _database.into(_database.savedTeams).insert(
              SavedTeamsCompanion.insert(
                id: team.id,
                groupId: group.id,
                name: team.name,
                sortOrder: teamIndex,
              ),
            );
        for (var playerIndex = 0; playerIndex < team.players.length; playerIndex++) {
          final player = team.players[playerIndex];
          await _database.into(_database.savedTeamPlayers).insert(
                SavedTeamPlayersCompanion.insert(
                  id: '${team.id}-${player.id}',
                  teamId: team.id,
                  playerId: player.id,
                  sortOrder: playerIndex,
                ),
              );
        }
      }

      for (var waitingIndex = 0; waitingIndex < group.waitingPlayers.length; waitingIndex++) {
        final waitingPlayer = group.waitingPlayers[waitingIndex];
        await _database.into(_database.savedGroupWaitingPlayers).insert(
              SavedGroupWaitingPlayersCompanion.insert(
                id: '${group.id}-${waitingPlayer.playerId}',
                groupId: group.id,
                playerId: waitingPlayer.playerId,
                playerName: waitingPlayer.playerName,
                waitingSince: waitingPlayer.waitingSince.toIso8601String(),
                priorityOrder: waitingPlayer.priorityOrder,
                sortOrder: waitingIndex,
              ),
            );
      }
    });
  }

  Future<List<team_models.SavedTeamGroup>> listSavedTeamGroups() async {
    final rows = await (_database.select(_database.savedTeamGroups)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return Future.wait(rows.map(_mapSavedGroupRow));
  }

  Future<team_models.SavedTeamGroup?> getSavedTeamGroupById(String groupId) async {
    final row = await (_database.select(_database.savedTeamGroups)..where((tbl) => tbl.id.equals(groupId)))
        .getSingleOrNull();
    return row == null ? null : _mapSavedGroupRow(row);
  }

  Future<team_models.SavedTeamGroup?> getLatestSavedTeamGroup() async {
    final row = await (_database.select(_database.savedTeamGroups)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _mapSavedGroupRow(row);
  }

  Future<void> renameSavedTeamGroup(String groupId, String title) async {
    await (_database.update(_database.savedTeamGroups)..where((tbl) => tbl.id.equals(groupId))).write(
      SavedTeamGroupsCompanion(
        title: Value(title.trim()),
      ),
    );
  }

  Future<void> renameSavedTeam(String teamId, String name) async {
    await (_database.update(_database.savedTeams)..where((tbl) => tbl.id.equals(teamId))).write(
      SavedTeamsCompanion(
        name: Value(name.trim()),
      ),
    );
  }

  Future<void> deleteSavedTeamGroup(String groupId) async {
    await (_database.delete(_database.savedTeamGroups)..where((tbl) => tbl.id.equals(groupId))).go();
  }

  Future<team_models.SavedTeamGroup> duplicateSavedTeamGroup(String groupId) async {
    final original = await getSavedTeamGroupById(groupId);
    if (original == null) {
      throw ArgumentError('Grupo salvo não encontrado.');
    }

    final duplicated = original.copyWith(
      id: _buildId('saved-group'),
      title: '${original.title} (Cópia)',
      createdAt: DateTime.now(),
      teams: [
        for (var index = 0; index < original.teams.length; index++)
          original.teams[index].copyWith(
            id: _buildId('saved-team-$index'),
          ),
      ],
    );
    await saveSavedTeamGroup(duplicated);
    return duplicated;
  }

  Future<void> clearTeamDrawData() async {
    await _database.transaction(() async {
      await _database.delete(_database.savedGroupWaitingPlayers).go();
      await _database.delete(_database.savedTeamPlayers).go();
      await _database.delete(_database.savedTeams).go();
      await _database.delete(_database.savedTeamGroups).go();
      await _database.delete(_database.waitingQueueEntries).go();
      await _database.delete(_database.drawSessionTeamPlayers).go();
      await _database.delete(_database.drawSessionTeams).go();
      await _database.delete(_database.drawSessions).go();
      await _database.delete(_database.teamDrawPlayers).go();
    });
  }

  Future<team_models.TeamDrawResult> _mapDrawSessionRow(DrawSession row) async {
    final teamRows = await (_database.select(_database.drawSessionTeams)
          ..where((tbl) => tbl.sessionId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final waitingPlayers = await listWaitingQueue(row.contextKey);

    final teams = <team_models.DrawTeam>[];
    for (final teamRow in teamRows) {
      final playerLinks = await (_database.select(_database.drawSessionTeamPlayers)
            ..where((tbl) => tbl.sessionTeamId.equals(teamRow.id))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
      final players = await _loadPlayersByIds(playerLinks.map((link) => link.playerId).toList());
      teams.add(
        team_models.DrawTeam(
          id: teamRow.id,
          name: teamRow.name,
          players: players,
        ),
      );
    }

    return team_models.TeamDrawResult(
      id: row.id,
      contextKey: row.contextKey,
      createdAt: DateTime.parse(row.createdAt),
      totalPlayers: row.totalPlayers,
      numberOfTeams: row.numberOfTeams,
      teams: teams,
      waitingPlayers: waitingPlayers,
      drawMode: team_models.DrawMode.fromValue(row.drawMode),
      oddPlayerHandling: team_models.OddPlayerHandling.fromValue(row.oddPlayerHandling),
    );
  }

  Future<team_models.SavedTeamGroup> _mapSavedGroupRow(SavedTeamGroup row) async {
    final teamRows = await (_database.select(_database.savedTeams)
          ..where((tbl) => tbl.groupId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final waitingRows = await (_database.select(_database.savedGroupWaitingPlayers)
          ..where((tbl) => tbl.groupId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();

    final teams = <team_models.DrawTeam>[];
    for (final teamRow in teamRows) {
      final playerRows = await (_database.select(_database.savedTeamPlayers)
            ..where((tbl) => tbl.teamId.equals(teamRow.id))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();
      teams.add(
        team_models.DrawTeam(
          id: teamRow.id,
          name: teamRow.name,
          players: await _loadPlayersByIds(playerRows.map((row) => row.playerId).toList()),
        ),
      );
    }

    return team_models.SavedTeamGroup(
      id: row.id,
      title: row.title,
      teams: teams,
      waitingPlayers: waitingRows.map(_mapSavedWaitingRow).toList(),
      createdAt: DateTime.parse(row.createdAt),
      sourceType: saved_models.SavedGroupSourceType.fromValue(row.sourceType),
      contextKey: row.contextKey,
      notes: row.notes,
    );
  }

  Future<List<team_models.TeamDrawPlayer>> _loadPlayersByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return const [];
    }
    final rows = await (_database.select(_database.teamDrawPlayers)
          ..where((tbl) => tbl.id.isIn(ids)))
        .get();
    final byId = {
      for (final row in rows) row.id: _mapPlayerRow(row),
    };
    return ids.map((id) => byId[id]).whereType<team_models.TeamDrawPlayer>().toList();
  }

  team_models.TeamDrawPlayer _mapPlayerRow(TeamDrawPlayer row) {
    return team_models.TeamDrawPlayer(
      id: row.id,
      name: row.name,
      position: row.position,
      level: team_models.PlayerLevel.fromValue(row.level),
    );
  }

  team_models.WaitingPlayer _mapWaitingRow(WaitingQueueEntry row) {
    return team_models.WaitingPlayer(
      playerId: row.playerId,
      playerName: row.playerName,
      waitingSince: DateTime.parse(row.waitingSince),
      priorityOrder: row.priorityOrder,
    );
  }

  team_models.WaitingPlayer _mapSavedWaitingRow(SavedGroupWaitingPlayer row) {
    return team_models.WaitingPlayer(
      playerId: row.playerId,
      playerName: row.playerName,
      waitingSince: DateTime.parse(row.waitingSince),
      priorityOrder: row.priorityOrder,
    );
  }

  String _buildId(String prefix) => '$prefix-${DateTime.now().microsecondsSinceEpoch}';
}
