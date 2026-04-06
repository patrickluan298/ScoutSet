import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:scoutset/features/scoreboard/models/match_score.dart';
import 'package:scoutset/features/scoreboard/models/set_point_event.dart';
import 'package:scoutset/features/scoreboard/models/set_score.dart';
import 'package:scoutset/features/scoreboard/services/match_pdf_service.dart';
import 'package:scoutset/features/teams/models/team_draw_player.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MatchScore buildDetailedMatch() {
    final createdAt = DateTime(2026, 4, 2, 10, 34);
    return MatchScore(
      id: 'pdf-match-1',
      teamAName: 'TIME A',
      teamBName: 'TIME B',
      currentSet: 2,
      sets: [
        SetScore(
          setNumber: 1,
          teamAScore: 25,
          teamBScore: 7,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
          durationSeconds: 114,
          pointEvents: [
            SetPointEvent(
              sequence: 1,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.attack,
              playerId: 'patrick',
              playerName: 'Patrick',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 2,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.attack,
              playerId: 'patrick',
              playerName: 'Patrick',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 3,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.block,
              playerId: 'joao',
              playerName: 'João',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 4,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.opponentError,
              recordedAt: createdAt,
            ),
          ],
        ),
        SetScore(
          setNumber: 2,
          teamAScore: 25,
          teamBScore: 20,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
          durationSeconds: 124,
          pointEvents: [
            SetPointEvent(
              sequence: 1,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.serve,
              playerId: 'joao',
              playerName: 'João',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 2,
              scoringTeam: TeamSide.teamA,
              pointOrigin: PointOrigin.other,
              playerId: 'patrick',
              playerName: 'Patrick',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 3,
              scoringTeam: TeamSide.teamB,
              pointOrigin: PointOrigin.attack,
              playerId: 'libero',
              playerName: 'Líbero',
              recordedAt: createdAt,
            ),
            SetPointEvent(
              sequence: 4,
              scoringTeam: TeamSide.teamB,
              pointOrigin: PointOrigin.opponentError,
              recordedAt: createdAt,
            ),
          ],
        ),
      ],
      teamASetsWon: 2,
      teamBSetsWon: 0,
      servingTeam: TeamSide.teamA,
      matchStatus: MatchStatus.finished,
      sourceType: MatchSourceType.savedTeamGroup,
      winnerTeam: TeamSide.teamA.value,
      createdAt: createdAt,
      finishedAt: createdAt.add(const Duration(minutes: 3)),
      savedTeamGroupTitle: 'Formação Não Oficial',
      teamAPlayers: const [
        TeamDrawPlayer(
          id: 'patrick',
          name: 'Patrick',
          position: 'Ponteiro',
          level: PlayerLevel.avancado,
        ),
        TeamDrawPlayer(
          id: 'joao',
          name: 'João',
          position: 'Levantador',
          level: PlayerLevel.intermediario,
        ),
      ],
      teamBPlayers: const [
        TeamDrawPlayer(
          id: 'libero',
          name: 'Líbero',
          position: 'Líbero',
          level: PlayerLevel.avancado,
        ),
      ],
    );
  }

  Future<String> extractPdfText(MatchScore match) async {
    final bytes = await MatchPdfService.instance.buildMatchPdf(match);
    final tempDir = await Directory.systemTemp.createTemp('scoutset-pdf-test');
    final file = File(p.join(tempDir.path, 'match.pdf'));
    await file.writeAsBytes(bytes, flush: true);
    final result = await Process.run('pdftotext', [file.path, '-']);
    expect(result.exitCode, 0,
        reason: 'Falha ao extrair texto do PDF: ${result.stderr}');
    return result.stdout as String;
  }

  test('builds pdf with category tables consolidated totals and ranking',
      () async {
    final text = await extractPdfText(buildDetailedMatch());

    expect(text, contains('Consolidado da partida'));
    expect(text, contains('Ranking da partida'));
    expect(text, contains('MVP da partida: Patrick'));
    expect(text, contains('Erro adv.'));
    expect(text, contains('Patrick'));
    expect(text, contains('João'));
    expect(text, contains('Líbero'));
    expect(text, contains('Ataq.'));
    expect(text, contains('Bloq.'));
    expect(text, contains('Saq.'));
  });

  test('renders portuguese accents and legacy matches without point events',
      () async {
    final match = buildDetailedMatch().copyWith(
      sets: [
        const SetScore(
          setNumber: 1,
          teamAScore: 25,
          teamBScore: 21,
          winnerTeamId: 'team_a',
          targetPoints: 25,
          durationSeconds: 90,
        ),
      ],
      teamASetsWon: 1,
      teamBSetsWon: 0,
      teamBPlayers: const [
        TeamDrawPlayer(
          id: 'libero',
          name: 'Líbero',
          position: 'Líbero',
          level: PlayerLevel.avancado,
        ),
      ],
    );

    final text = await extractPdfText(match);

    expect(text, contains('Formação Não Oficial'));
    expect(text, contains('Equipes Salvas'));
    expect(text, contains('Líbero'));
    expect(text, contains('Sem eventos detalhados registrados para este set.'));
  });
}
