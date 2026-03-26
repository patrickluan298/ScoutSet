import 'dart:math';

import '../../../data/local/database/app_services.dart';
import '../../../data/local/repositories/teams_repository.dart';
import '../models/draw_team.dart';
import '../models/saved_team_group.dart';
import '../models/team_draw_player.dart';
import '../models/team_draw_result.dart';
import '../models/waiting_player.dart';

class TeamDrawService {
  TeamDrawService._();

  static final TeamDrawService instance = TeamDrawService._();

  static const int minPlayers = 4;
  static const int maxPlayers = 18;

  TeamsRepository get _repository => AppServices.teamsRepository;

  Future<void> initialize() async {
    await AppServices.initialize();
  }

  Future<List<TeamDrawPlayer>> listPlayers() => _repository.listPlayers();

  Future<void> savePlayer({
    String? id,
    required String name,
    required String position,
    required PlayerLevel level,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) {
      throw ArgumentError('Informe o nome do jogador.');
    }

    await _repository.savePlayer(
      TeamDrawPlayer(
        id: id ?? _buildId('player'),
        name: normalizedName,
        position: position.trim().isEmpty ? 'Sem posição' : position.trim(),
        level: level,
      ),
    );
  }

  Future<void> deactivatePlayer(String playerId) => _repository.deactivatePlayer(playerId);

  Future<List<TeamDrawResult>> listDrawHistory() => _repository.listDrawHistory();

  Future<List<WaitingPlayer>> listLatestWaitingPlayers() => _repository.listLatestWaitingPlayers();

  Future<TeamDrawResult?> getLatestDrawResult() => _repository.getLatestDrawResult();

  List<int> allowedTeamCounts(int totalPlayers) {
    if (totalPlayers < minPlayers || totalPlayers > maxPlayers) {
      return const [];
    }
    if (totalPlayers < 12) {
      return const [2];
    }
    final counts = <int>[2];
    if (totalPlayers >= 12) {
      counts.add(3);
    }
    return counts.where((count) => _isValidTeamCount(totalPlayers, count)).toList();
  }

  TeamDrawResult validateManualSetup({
    required List<TeamDrawPlayer> selectedPlayers,
    required List<DrawTeam> teams,
    required OddPlayerHandling oddPlayerHandling,
  }) {
    final normalizedPlayers = _normalizePlayers(selectedPlayers);
    _validateBaseRules(normalizedPlayers.length);
    if (!_isValidTeamCount(normalizedPlayers.length, teams.length)) {
      throw ArgumentError('Quantidade de equipes inválida para a quantidade de jogadores.');
    }

    final assignedPlayers = [
      for (final team in teams) ...team.players,
    ];
    final uniqueAssignedIds = assignedPlayers.map((player) => player.id).toSet();
    if (uniqueAssignedIds.length != assignedPlayers.length) {
      throw ArgumentError('O mesmo jogador não pode estar em mais de uma equipe.');
    }

    final allSelectedIds = normalizedPlayers.map((player) => player.id).toSet();
    final waitingCandidates = normalizedPlayers.where((player) => !uniqueAssignedIds.contains(player.id)).toList();

    if (!uniqueAssignedIds.every(allSelectedIds.contains)) {
      throw ArgumentError('Todas as equipes devem usar apenas jogadores selecionados.');
    }

    if (waitingCandidates.length > 1) {
      throw ArgumentError('No máximo um jogador pode ficar aguardando por rodada.');
    }

    if (waitingCandidates.isNotEmpty && oddPlayerHandling != OddPlayerHandling.waitingQueue) {
      throw ArgumentError('Se houver jogador aguardando, escolha a opção de fila de espera.');
    }

    _validateTeamBalance(teams);

    return TeamDrawResult(
      id: _buildId('draw'),
      contextKey: buildContextKey(normalizedPlayers.map((player) => player.id)),
      createdAt: DateTime.now(),
      totalPlayers: normalizedPlayers.length,
      numberOfTeams: teams.length,
      teams: teams,
      waitingPlayers: waitingCandidates.isEmpty
          ? const []
          : [
              WaitingPlayer(
                playerId: waitingCandidates.single.id,
                playerName: waitingCandidates.single.name,
                waitingSince: DateTime.now(),
                priorityOrder: 1,
              ),
            ],
      drawMode: DrawMode.manual,
      oddPlayerHandling: oddPlayerHandling,
    );
  }

  Future<TeamDrawResult> createDraw({
    required List<TeamDrawPlayer> selectedPlayers,
    required int numberOfTeams,
    required DrawMode drawMode,
    required OddPlayerHandling oddPlayerHandling,
    List<String>? teamNames,
    Random? testRandom,
  }) async {
    final normalizedPlayers = _normalizePlayers(selectedPlayers);
    _validateBaseRules(normalizedPlayers.length);
    if (!_isValidTeamCount(normalizedPlayers.length, numberOfTeams)) {
      throw ArgumentError('Quantidade de equipes inválida para a quantidade de jogadores.');
    }
    if (drawMode == DrawMode.manual) {
      throw ArgumentError('Use a validação manual para montagens manuais.');
    }

    final contextKey = buildContextKey(normalizedPlayers.map((player) => player.id));
    final waitingQueue = await _repository.listWaitingQueue(contextKey);
    final prioritizedPlayers = _applyWaitingPriority(normalizedPlayers, waitingQueue);

    final hasOddPlayerCount = prioritizedPlayers.length.isOdd;
    if (hasOddPlayerCount && oddPlayerHandling == OddPlayerHandling.waitingQueue) {
      if (prioritizedPlayers.length <= minPlayers) {
        throw ArgumentError('Não há jogadores suficientes para deixar alguém aguardando.');
      }
    }

    final workingPlayers = List<TeamDrawPlayer>.from(prioritizedPlayers);
    final waitingPlayers = <WaitingPlayer>[];
    if (workingPlayers.length.isOdd && oddPlayerHandling == OddPlayerHandling.waitingQueue) {
      final waitingPlayer = _pickWaitingPlayer(
        players: workingPlayers,
        prioritizedPlayers: waitingQueue.map((player) => player.playerId).toSet(),
      );
      workingPlayers.removeWhere((player) => player.id == waitingPlayer.id);
      waitingPlayers.add(
        WaitingPlayer(
          playerId: waitingPlayer.id,
          playerName: waitingPlayer.name,
          waitingSince: DateTime.now(),
          priorityOrder: 1,
        ),
      );
    }

    final shuffledPlayers = drawMode == DrawMode.random
        ? _shufflePlayers(workingPlayers, random: testRandom)
        : _buildBalancedOrder(workingPlayers, numberOfTeams, random: testRandom);

    var teams = _distributePlayers(
      shuffledPlayers,
      numberOfTeams: numberOfTeams,
      teamNames: teamNames,
    );
    _validateTeamBalance(teams);

    final previous = await _repository.getLatestDrawResult();
    if (previous != null &&
        previous.contextKey == contextKey &&
        _isSameComposition(previous.teams, teams) &&
        shuffledPlayers.length > numberOfTeams) {
      final reroll = drawMode == DrawMode.random
          ? _shufflePlayers(workingPlayers.reversed.toList(), random: testRandom)
          : _buildBalancedOrder(workingPlayers.reversed.toList(), numberOfTeams, random: testRandom);
      teams = _distributePlayers(
        reroll,
        numberOfTeams: numberOfTeams,
        teamNames: teamNames,
      );
    }

    final result = TeamDrawResult(
      id: _buildId('draw'),
      contextKey: contextKey,
      createdAt: DateTime.now(),
      totalPlayers: normalizedPlayers.length,
      numberOfTeams: numberOfTeams,
      teams: teams,
      waitingPlayers: waitingPlayers,
      drawMode: drawMode,
      oddPlayerHandling: oddPlayerHandling,
    );

    await _repository.saveDrawResult(result);
    await _repository.replaceWaitingQueue(contextKey, waitingPlayers, lastSessionId: result.id);
    return result;
  }

  Future<TeamDrawResult> saveManualResult(TeamDrawResult result) async {
    await _repository.saveDrawResult(result);
    await _repository.replaceWaitingQueue(result.contextKey, result.waitingPlayers, lastSessionId: result.id);
    return result;
  }

  Future<SavedTeamGroup> saveResultAsGroup({
    required TeamDrawResult result,
    required String title,
    String? notes,
  }) async {
    final group = SavedTeamGroup.fromDrawResult(
      id: _buildId('saved-group'),
      title: title.trim().isEmpty ? 'Formação ${_formatIndex(result.createdAt)}' : title.trim(),
      result: result,
      notes: notes,
    );
    await _repository.saveSavedTeamGroup(group);
    return group;
  }

  Future<void> clearAll() => _repository.clearTeamDrawData();

  String buildContextKey(Iterable<String> playerIds) {
    final sortedIds = playerIds.toList()..sort();
    return sortedIds.join('|');
  }

  List<TeamDrawPlayer> _normalizePlayers(List<TeamDrawPlayer> players) {
    final uniqueById = <String, TeamDrawPlayer>{};
    for (final player in players) {
      uniqueById[player.id] = player;
    }
    return uniqueById.values.toList();
  }

  void _validateBaseRules(int totalPlayers) {
    if (totalPlayers < minPlayers) {
      throw ArgumentError('São necessários pelo menos 4 jogadores para montar equipes.');
    }
    if (totalPlayers > maxPlayers) {
      throw ArgumentError('O limite máximo para montagem de equipes é 18 jogadores.');
    }
  }

  bool _isValidTeamCount(int totalPlayers, int numberOfTeams) {
    if (numberOfTeams == 2) {
      return totalPlayers >= 4 && totalPlayers <= 18;
    }
    if (numberOfTeams == 3) {
      return totalPlayers >= 12 && totalPlayers <= 18;
    }
    return false;
  }

  List<TeamDrawPlayer> _applyWaitingPriority(
    List<TeamDrawPlayer> players,
    List<WaitingPlayer> waitingQueue,
  ) {
    final queueById = {
      for (final waiting in waitingQueue) waiting.playerId: waiting,
    };
    final prioritized = <TeamDrawPlayer>[];
    final others = <TeamDrawPlayer>[];

    for (final player in players) {
      if (queueById.containsKey(player.id)) {
        prioritized.add(player.copyWith(wasWaitingLastRound: true));
      } else {
        others.add(player);
      }
    }

    prioritized.sort((a, b) {
      final left = queueById[a.id]?.priorityOrder ?? 0;
      final right = queueById[b.id]?.priorityOrder ?? 0;
      return left.compareTo(right);
    });
    return [...prioritized, ...others];
  }

  TeamDrawPlayer _pickWaitingPlayer({
    required List<TeamDrawPlayer> players,
    required Set<String> prioritizedPlayers,
  }) {
    final candidates = players.where((player) => !prioritizedPlayers.contains(player.id)).toList();
    if (candidates.isNotEmpty) {
      candidates.sort((a, b) => a.name.compareTo(b.name));
      return candidates.last;
    }
    return players.last;
  }

  List<TeamDrawPlayer> _shufflePlayers(
    List<TeamDrawPlayer> players, {
    Random? random,
  }) {
    final output = List<TeamDrawPlayer>.from(players);
    final rng = random ?? Random.secure();
    for (var index = output.length - 1; index > 0; index--) {
      final swapIndex = rng.nextInt(index + 1);
      final current = output[index];
      output[index] = output[swapIndex];
      output[swapIndex] = current;
    }
    return output;
  }

  List<TeamDrawPlayer> _buildBalancedOrder(
    List<TeamDrawPlayer> players,
    int numberOfTeams, {
    Random? random,
  }) {
    final rng = random ?? Random.secure();
    final buckets = <PlayerLevel, List<TeamDrawPlayer>>{
      PlayerLevel.avancado: [],
      PlayerLevel.intermediario: [],
      PlayerLevel.iniciante: [],
    };

    for (final player in players) {
      buckets[player.level]!.add(player);
    }

    final ordered = <TeamDrawPlayer>[];
    for (final level in [PlayerLevel.avancado, PlayerLevel.intermediario, PlayerLevel.iniciante]) {
      final shuffledBucket = _shufflePlayers(buckets[level]!, random: rng);
      ordered.addAll(shuffledBucket);
    }

    final lanes = List<List<TeamDrawPlayer>>.generate(numberOfTeams, (_) => <TeamDrawPlayer>[]);
    var direction = 1;
    var teamIndex = 0;
    for (final player in ordered) {
      lanes[teamIndex].add(player);
      if (direction == 1) {
        if (teamIndex == numberOfTeams - 1) {
          direction = -1;
        } else {
          teamIndex += 1;
        }
      } else {
        if (teamIndex == 0) {
          direction = 1;
        } else {
          teamIndex -= 1;
        }
      }
    }

    return [
      for (final lane in lanes) ...lane,
    ];
  }

  List<DrawTeam> _distributePlayers(
    List<TeamDrawPlayer> players, {
    required int numberOfTeams,
    List<String>? teamNames,
  }) {
    final names = teamNames == null || teamNames.length < numberOfTeams
        ? List<String>.generate(numberOfTeams, (index) => 'Time ${String.fromCharCode(65 + index)}')
        : teamNames;
    final buckets = List<List<TeamDrawPlayer>>.generate(numberOfTeams, (_) => <TeamDrawPlayer>[]);
    for (var index = 0; index < players.length; index++) {
      buckets[index % numberOfTeams].add(players[index]);
    }
    return List<DrawTeam>.generate(
      numberOfTeams,
      (index) => DrawTeam(
        id: _buildId('team-$index'),
        name: names[index],
        players: buckets[index],
      ),
    );
  }

  void _validateTeamBalance(List<DrawTeam> teams) {
    if (teams.isEmpty) {
      throw ArgumentError('Crie ao menos duas equipes.');
    }
    final counts = teams.map((team) => team.players.length).toList();
    final minCount = counts.reduce((left, right) => left < right ? left : right);
    final maxCount = counts.reduce((left, right) => left > right ? left : right);
    if (maxCount - minCount > 1) {
      throw ArgumentError('A distribuição entre as equipes precisa ficar equilibrada.');
    }
  }

  bool _isSameComposition(List<DrawTeam> left, List<DrawTeam> right) {
    if (left.length != right.length) {
      return false;
    }
    for (var index = 0; index < left.length; index++) {
      final leftIds = left[index].players.map((player) => player.id).toList();
      final rightIds = right[index].players.map((player) => player.id).toList();
      if (leftIds.length != rightIds.length) {
        return false;
      }
      for (var playerIndex = 0; playerIndex < leftIds.length; playerIndex++) {
        if (leftIds[playerIndex] != rightIds[playerIndex]) {
          return false;
        }
      }
    }
    return true;
  }

  String _buildId(String prefix) => '$prefix-${DateTime.now().microsecondsSinceEpoch}';

  String _formatIndex(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day$month-$hour$minute';
  }
}
