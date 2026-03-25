import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../seed/drills_seed.dart';

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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await DrillsSeed.seed(this);
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(strategyPlayers, strategyPlayers.sortOrder);
            await m.addColumn(strategyMovements, strategyMovements.sortOrder);
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
        },
      );
}
