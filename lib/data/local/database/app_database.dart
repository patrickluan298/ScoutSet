import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../seed/drills_seed.dart';
import '../seed/teams_seed.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get passwordHash => text().named('password_hash')();
  TextColumn get passwordSalt => text().named('password_salt')();
  TextColumn get teamId => text().named('team_id').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {email},
      ];
}

class UserSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().named('user_id').references(Users, #id)();
  TextColumn get startedAt => text().named('started_at')();
  BoolColumn get isActive => boolean().named('is_active')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Teams extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Athletes extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text().named('team_id').references(Teams, #id)();
  TextColumn get name => text()();
  TextColumn get position => text()();
  RealColumn get height => real()();
  IntColumn get age => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Strategies extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get gameMode => text().named('game_mode')();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StrategyPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get strategyId => text().named('strategy_id').references(Strategies, #id)();
  IntColumn get sortOrder => integer().named('sort_order').withDefault(const Constant(0))();
  TextColumn get playerId => text().named('player_id')();
  TextColumn get label => text()();
  RealColumn get x => real()();
  RealColumn get y => real()();
  RealColumn get defaultX => real().named('default_x').nullable()();
  RealColumn get defaultY => real().named('default_y').nullable()();
  BoolColumn get isStarter => boolean().named('is_starter')();
  BoolColumn get isLibero => boolean().named('is_libero')();
  BoolColumn get isBench => boolean().named('is_bench')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StrategyMovements extends Table {
  TextColumn get id => text()();
  TextColumn get strategyId => text().named('strategy_id').references(Strategies, #id)();
  IntColumn get sortOrder => integer().named('sort_order').withDefault(const Constant(0))();
  TextColumn get playerId => text().named('player_id')();
  RealColumn get fromX => real().named('from_x')();
  RealColumn get fromY => real().named('from_y')();
  RealColumn get toX => real().named('to_x')();
  RealColumn get toY => real().named('to_y')();
  TextColumn get movementType => text().named('movement_type')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StrategySubstitutions extends Table {
  TextColumn get id => text()();
  TextColumn get strategyId => text().named('strategy_id').references(Strategies, #id)();
  TextColumn get playerOutId => text().named('player_out_id')();
  TextColumn get playerInId => text().named('player_in_id')();
  TextColumn get createdAt => text().named('created_at')();
  BoolColumn get countsTowardLimit => boolean().named('counts_toward_limit')();
  BoolColumn get isLiberoExchange => boolean().named('is_libero_exchange')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Matches extends Table {
  TextColumn get id => text()();
  TextColumn get teamAName => text().named('team_a_name')();
  TextColumn get teamBName => text().named('team_b_name')();
  IntColumn get teamASetsWon => integer().named('team_a_sets_won')();
  IntColumn get teamBSetsWon => integer().named('team_b_sets_won')();
  IntColumn get currentSet => integer().named('current_set')();
  TextColumn get servingTeam => text().named('serving_team')();
  TextColumn get matchStatus => text().named('match_status')();
  TextColumn get winnerTeam => text().named('winner_team').nullable()();
  TextColumn get sourceType => text().named('source_type').withDefault(const Constant('manual'))();
  TextColumn get savedTeamGroupId => text().named('saved_team_group_id').nullable()();
  TextColumn get savedTeamGroupTitle => text().named('saved_team_group_title').nullable()();
  TextColumn get teamAOriginTeamId => text().named('team_a_origin_team_id').nullable()();
  TextColumn get teamBOriginTeamId => text().named('team_b_origin_team_id').nullable()();
  TextColumn get teamAPlayersJson => text().named('team_a_players_json').nullable()();
  TextColumn get teamBPlayersJson => text().named('team_b_players_json').nullable()();
  TextColumn get waitingPlayersSnapshotJson => text().named('waiting_players_snapshot_json').nullable()();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get finishedAt => text().named('finished_at').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MatchSets extends Table {
  TextColumn get id => text()();
  TextColumn get matchId => text().named('match_id').references(Matches, #id)();
  IntColumn get setNumber => integer().named('set_number')();
  IntColumn get teamAScore => integer().named('team_a_score')();
  IntColumn get teamBScore => integer().named('team_b_score')();
  TextColumn get winnerTeamId => text().named('winner_team_id')();
  IntColumn get targetPoints => integer().named('target_points')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Drills extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get objective => text()();
  TextColumn get difficulty => text()();
  TextColumn get duration => text()();
  BoolColumn get isFavorite => boolean().named('is_favorite')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  TextColumn get playerId => text().named('player_id')();
  TextColumn get label => text()();
  TextColumn get role => text()();
  IntColumn get colorHex => integer().named('color_hex')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillSteps extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();
  TextColumn get textValue => text().named('text_value')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillTips extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();
  TextColumn get textValue => text().named('text_value')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillErrors extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();
  TextColumn get textValue => text().named('text_value')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillVariations extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();
  TextColumn get textValue => text().named('text_value')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillAnimationFrames extends Table {
  TextColumn get id => text()();
  TextColumn get drillId => text().named('drill_id').references(Drills, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();
  IntColumn get timestamp => integer()();
  IntColumn get stepIndex => integer().named('step_index')();
  TextColumn get highlightPlayerId => text().named('highlight_player_id').nullable()();
  TextColumn get instructionText => text().named('instruction_text').nullable()();
  RealColumn get ballX => real().named('ball_x').nullable()();
  RealColumn get ballY => real().named('ball_y').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillFramePlayers extends Table {
  TextColumn get id => text()();
  TextColumn get frameId => text().named('frame_id').references(DrillAnimationFrames, #id)();
  TextColumn get playerId => text().named('player_id')();
  RealColumn get x => real()();
  RealColumn get y => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillFrameMovements extends Table {
  TextColumn get id => text()();
  TextColumn get frameId => text().named('frame_id').references(DrillAnimationFrames, #id)();
  TextColumn get playerId => text().named('player_id')();
  RealColumn get fromX => real().named('from_x')();
  RealColumn get fromY => real().named('from_y')();
  RealColumn get toX => real().named('to_x')();
  RealColumn get toY => real().named('to_y')();
  TextColumn get label => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrillFrameZones extends Table {
  TextColumn get id => text()();
  TextColumn get frameId => text().named('frame_id').references(DrillAnimationFrames, #id)();
  RealColumn get x => real()();
  RealColumn get y => real()();
  RealColumn get width => real()();
  RealColumn get height => real()();
  TextColumn get label => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TeamDrawPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get position => text()();
  TextColumn get level => text()();
  BoolColumn get isActive => boolean().named('is_active').withDefault(const Constant(true))();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrawSessions extends Table {
  TextColumn get id => text()();
  TextColumn get contextKey => text().named('context_key')();
  IntColumn get totalPlayers => integer().named('total_players')();
  IntColumn get numberOfTeams => integer().named('number_of_teams')();
  TextColumn get drawMode => text().named('draw_mode')();
  TextColumn get oddPlayerHandling => text().named('odd_player_handling')();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrawSessionTeams extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().named('session_id').references(DrawSessions, #id)();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DrawSessionTeamPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get sessionTeamId => text().named('session_team_id').references(DrawSessionTeams, #id)();
  TextColumn get playerId => text().named('player_id').references(TeamDrawPlayers, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WaitingQueueEntries extends Table {
  TextColumn get id => text()();
  TextColumn get contextKey => text().named('context_key')();
  TextColumn get playerId => text().named('player_id').references(TeamDrawPlayers, #id)();
  TextColumn get playerName => text().named('player_name')();
  TextColumn get waitingSince => text().named('waiting_since')();
  IntColumn get priorityOrder => integer().named('priority_order')();
  TextColumn get lastSessionId => text().named('last_session_id').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SavedTeamGroups extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get sourceType => text().named('source_type')();
  TextColumn get contextKey => text().named('context_key').nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SavedTeams extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text().named('group_id').references(SavedTeamGroups, #id)();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SavedTeamPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text().named('team_id').references(SavedTeams, #id)();
  TextColumn get playerId => text().named('player_id').references(TeamDrawPlayers, #id)();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SavedGroupWaitingPlayers extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text().named('group_id').references(SavedTeamGroups, #id)();
  TextColumn get playerId => text().named('player_id').references(TeamDrawPlayers, #id)();
  TextColumn get playerName => text().named('player_name')();
  TextColumn get waitingSince => text().named('waiting_since')();
  IntColumn get priorityOrder => integer().named('priority_order')();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'scoutset.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    Users,
    UserSessions,
    Teams,
    Athletes,
    Strategies,
    StrategyPlayers,
    StrategyMovements,
    StrategySubstitutions,
    Matches,
    MatchSets,
    Drills,
    DrillPlayers,
    DrillSteps,
    DrillTips,
    DrillErrors,
    DrillVariations,
    DrillAnimationFrames,
    DrillFramePlayers,
    DrillFrameMovements,
    DrillFrameZones,
    TeamDrawPlayers,
    DrawSessions,
    DrawSessionTeams,
    DrawSessionTeamPlayers,
    WaitingQueueEntries,
    SavedTeamGroups,
    SavedTeams,
    SavedTeamPlayers,
    SavedGroupWaitingPlayers,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await DrillsSeed.seed(this);
          await TeamsSeed.seed(this);
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(strategyPlayers, strategyPlayers.sortOrder);
            await m.addColumn(strategyMovements, strategyMovements.sortOrder);
          }
          if (from < 3) {
            await m.addColumn(matches, matches.sourceType);
            await m.addColumn(matches, matches.savedTeamGroupId);
            await m.addColumn(matches, matches.savedTeamGroupTitle);
            await m.addColumn(matches, matches.teamAOriginTeamId);
            await m.addColumn(matches, matches.teamBOriginTeamId);
            await m.addColumn(matches, matches.teamAPlayersJson);
            await m.addColumn(matches, matches.teamBPlayersJson);
            await m.addColumn(matches, matches.waitingPlayersSnapshotJson);
            await m.createTable(teamDrawPlayers);
            await m.createTable(drawSessions);
            await m.createTable(drawSessionTeams);
            await m.createTable(drawSessionTeamPlayers);
            await m.createTable(waitingQueueEntries);
            await m.createTable(savedTeamGroups);
            await m.createTable(savedTeams);
            await m.createTable(savedTeamPlayers);
            await m.createTable(savedGroupWaitingPlayers);
            await TeamsSeed.seed(this);
          }
          if (from < 4) {
            await TeamsSeed.cleanupLegacySeedData(this);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_users_email ON users (email)');
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_strategy_players_strategy_id ON strategy_players (strategy_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_strategy_movements_strategy_id ON strategy_movements (strategy_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_strategy_substitutions_strategy_id ON strategy_substitutions (strategy_id)',
          );
          await customStatement('CREATE INDEX IF NOT EXISTS idx_match_sets_match_id ON match_sets (match_id)');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_drill_players_drill_id ON drill_players (drill_id)');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_drill_steps_drill_id ON drill_steps (drill_id)');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_drill_tips_drill_id ON drill_tips (drill_id)');
          await customStatement('CREATE INDEX IF NOT EXISTS idx_drill_errors_drill_id ON drill_errors (drill_id)');
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_drill_variations_drill_id ON drill_variations (drill_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_drill_animation_frames_drill_id ON drill_animation_frames (drill_id)',
          );
          await customStatement('CREATE INDEX IF NOT EXISTS idx_athletes_team_id ON athletes (team_id)');
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_draw_sessions_context_key ON draw_sessions (context_key)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_draw_session_teams_session_id ON draw_session_teams (session_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_draw_session_team_players_session_team_id ON draw_session_team_players (session_team_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_waiting_queue_entries_context_key ON waiting_queue_entries (context_key)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_saved_teams_group_id ON saved_teams (group_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_saved_team_players_team_id ON saved_team_players (team_id)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_saved_group_waiting_players_group_id ON saved_group_waiting_players (group_id)',
          );
        },
      );
}
