import 'package:drift/native.dart';

import '../repositories/auth_repository.dart';
import '../repositories/drills_repository.dart';
import '../repositories/matches_repository.dart';
import '../repositories/strategies_repository.dart';
import '../repositories/teams_repository.dart';
import 'app_database.dart';

class AppServices {
  AppServices._();

  static AppDatabase? _database;
  static AuthRepository? _authRepository;
  static StrategiesRepository? _strategiesRepository;
  static MatchesRepository? _matchesRepository;
  static DrillsRepository? _drillsRepository;
  static TeamsRepository? _teamsRepository;

  static AppDatabase get database => _database!;
  static AuthRepository get authRepository => _authRepository!;
  static StrategiesRepository get strategiesRepository => _strategiesRepository!;
  static MatchesRepository get matchesRepository => _matchesRepository!;
  static DrillsRepository get drillsRepository => _drillsRepository!;
  static TeamsRepository get teamsRepository => _teamsRepository!;

  static Future<void> initialize({AppDatabase? database}) async {
    if (_database != null && database == null) {
      return;
    }

    _database = database ?? AppDatabase();
    _authRepository = AuthRepository(_database!);
    _strategiesRepository = StrategiesRepository(_database!);
    _matchesRepository = MatchesRepository(_database!);
    _drillsRepository = DrillsRepository(_database!);
    _teamsRepository = TeamsRepository(_database!);

    await _database!.customSelect('SELECT 1').get();
  }

  static Future<void> resetForTesting() async {
    final db = _database;
    _authRepository = null;
    _strategiesRepository = null;
    _matchesRepository = null;
    _drillsRepository = null;
    _teamsRepository = null;
    _database = null;
    if (db != null) {
      await db.close();
    }
  }

  static Future<void> useInMemoryDatabaseForTesting() async {
    await resetForTesting();
    await initialize(
      database: AppDatabase.forTesting(
        NativeDatabase.memory(),
      ),
    );
  }
}
