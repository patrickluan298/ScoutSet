import '../../../models/athlete.dart' as domain;
import '../../../models/team.dart' as domain;
import '../database/app_database.dart';

class TeamsRepository {
  TeamsRepository(this._database);

  final AppDatabase _database;

  Future<List<domain.Team>> listTeams() async {
    final teamRows = await _database.select(_database.teams).get();
    final athleteRows = await _database.select(_database.athletes).get();

    return teamRows.map((teamRow) {
      final athletes = athleteRows
          .where((athlete) => athlete.teamId == teamRow.id)
          .map(
            (athlete) => domain.Athlete(
              id: athlete.id,
              name: athlete.name,
              position: athlete.position,
              height: athlete.height,
              age: athlete.age,
              teamId: athlete.teamId,
            ),
          )
          .toList();

      return domain.Team(
        id: teamRow.id,
        name: teamRow.name,
        athletes: athletes,
      );
    }).toList();
  }
}
