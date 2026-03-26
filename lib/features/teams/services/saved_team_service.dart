import '../../../data/local/database/app_services.dart';
import '../../../data/local/repositories/teams_repository.dart';
import '../models/saved_team_group.dart';

class SavedTeamService {
  SavedTeamService._();

  static final SavedTeamService instance = SavedTeamService._();

  TeamsRepository get _repository => AppServices.teamsRepository;

  Future<void> initialize() async {
    await AppServices.initialize();
  }

  Future<List<SavedTeamGroup>> listSavedGroups() => _repository.listSavedTeamGroups();

  Future<SavedTeamGroup?> getSavedGroupById(String id) => _repository.getSavedTeamGroupById(id);

  Future<SavedTeamGroup?> getLatestSavedGroup() => _repository.getLatestSavedTeamGroup();

  Future<void> renameGroup(String groupId, String title) =>
      _repository.renameSavedTeamGroup(groupId, title);

  Future<void> renameTeam(String teamId, String name) => _repository.renameSavedTeam(teamId, name);

  Future<SavedTeamGroup> duplicateGroup(String groupId) => _repository.duplicateSavedTeamGroup(groupId);

  Future<void> deleteGroup(String groupId) => _repository.deleteSavedTeamGroup(groupId);
}
