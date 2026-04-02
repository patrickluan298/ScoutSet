import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/match_score.dart';
import '../models/set_point_event.dart';
import '../models/set_score.dart';

class MatchPdfService {
  MatchPdfService._();

  static final MatchPdfService instance = MatchPdfService._();

  static const _fontRegularAsset = 'assets/fonts/DejaVuSans.ttf';
  static const _fontBoldAsset = 'assets/fonts/DejaVuSans-Bold.ttf';

  pw.Font? _cachedRegularFont;
  pw.Font? _cachedBoldFont;

  Future<Uint8List> buildMatchPdf(MatchScore match) async {
    final document = pw.Document();
    final fonts = await _loadFonts();
    final consolidated = _buildConsolidatedStats(match);

    document.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(24),
          theme: pw.ThemeData.withFont(
            base: fonts.regular,
            bold: fonts.bold,
          ),
        ),
        build: (context) => [
          _buildHeader(match),
          pw.SizedBox(height: 20),
          _buildSummarySection(match),
          pw.SizedBox(height: 20),
          _buildSetsTable(match),
          pw.SizedBox(height: 20),
          _buildSetBreakdownSection(match),
          pw.SizedBox(height: 20),
          _buildMatchTotalsSection(match, consolidated),
          if (consolidated.ranking.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _buildRankingSection(match, consolidated),
          ],
          if (match.teamAPlayers.isNotEmpty ||
              match.teamBPlayers.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _sectionTitle('Jogadores vinculados'),
            _playersBlock(match.teamAName,
                match.teamAPlayers.map((player) => player.name).toList()),
            pw.SizedBox(height: 12),
            _playersBlock(match.teamBName,
                match.teamBPlayers.map((player) => player.name).toList()),
          ],
          if (match.waitingPlayersSnapshot.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _sectionTitle('Jogadores aguardando'),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                for (final player in match.waitingPlayersSnapshot)
                  pw.Text(
                      '${player.playerName} • prioridade ${player.priorityOrder}'),
              ],
            ),
          ],
        ],
      ),
    );

    return document.save();
  }

  Future<File> savePdf(MatchScore match) async {
    final bytes = await buildMatchPdf(match);
    final directory = await _resolveSaveDirectory();
    final sanitizedName =
        '${match.teamAName}_${match.teamBName}'.replaceAll(' ', '_');
    return _writePdfFile(
      directory: directory,
      fileName: 'partida_$sanitizedName.pdf',
      bytes: bytes,
    );
  }

  Future<void> sharePdf(MatchScore match) async {
    final bytes = await buildMatchPdf(match);
    final temporaryDirectory = await getTemporaryDirectory();
    final sanitizedName =
        '${match.teamAName}_${match.teamBName}'.replaceAll(' ', '_');
    final file = await _writePdfFile(
      directory: temporaryDirectory,
      fileName: 'partida_$sanitizedName.pdf',
      bytes: bytes,
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Partida ${match.teamAName} x ${match.teamBName}',
        subject: 'ScoutSet - PDF da partida',
      ),
    );
  }

  Future<_PdfFonts> _loadFonts() async {
    _cachedRegularFont ??=
        pw.Font.ttf(await rootBundle.load(_fontRegularAsset));
    _cachedBoldFont ??= pw.Font.ttf(await rootBundle.load(_fontBoldAsset));
    return _PdfFonts(
      regular: _cachedRegularFont!,
      bold: _cachedBoldFont!,
    );
  }

  pw.Widget _buildHeader(MatchScore match) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#081426'),
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ScoutSet - Detalhes da Partida',
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            '${match.teamAName} x ${match.teamBName}',
            style: const pw.TextStyle(
              color: PdfColors.white,
              fontSize: 16,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            'Status: ${match.matchStatus.label} • Vencedor: ${_winnerLabel(match)}',
            style: const pw.TextStyle(
              color: PdfColors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSummarySection(MatchScore match) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Resumo geral'),
        _detailRow('Data de início', _formatDate(match.createdAt)),
        _detailRow(
          'Data de encerramento',
          match.finishedAt == null ? '-' : _formatDate(match.finishedAt!),
        ),
        _detailRow('Status', match.matchStatus.label),
        _detailRow(
            'Origem',
            match.sourceType == MatchSourceType.manual
                ? 'Manual'
                : 'Equipes salvas'),
        if (match.savedTeamGroupTitle != null)
          _detailRow('Formação', match.savedTeamGroupTitle!),
        _detailRow(
            'Placar final', '${match.teamASetsWon} x ${match.teamBSetsWon}'),
        _detailRow('Vencedor', _winnerLabel(match)),
      ],
    );
  }

  pw.Widget _buildSetsTable(MatchScore match) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Tabela de sets'),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableCell('Set', isHeader: true),
                _tableCell(match.teamAName, isHeader: true),
                _tableCell(match.teamBName, isHeader: true),
                _tableCell('Duração', isHeader: true),
              ],
            ),
            for (final set in match.sets)
              pw.TableRow(
                children: [
                  _tableCell(set.setNumber.toString()),
                  _tableCell(set.teamAScore.toString()),
                  _tableCell(set.teamBScore.toString()),
                  _tableCell(_formatDuration(set.durationSeconds)),
                ],
              ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildSetBreakdownSection(MatchScore match) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Detalhamento por set'),
        if (match.sets.isEmpty)
          pw.Text('Nenhum set registrado.')
        else
          ...match.sets.expand(
            (set) => [
              _buildSingleSetSection(match, set),
              pw.SizedBox(height: 16),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildSingleSetSection(MatchScore match, SetScore set) {
    final setStats = _buildSetStats(match, set);

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Set ${set.setNumber} • ${set.teamAScore} x ${set.teamBScore} • ${_formatDuration(set.durationSeconds)}',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 13,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildTeamCategorySummary(
            title: match.teamAName,
            totals: setStats.teamTotals[TeamSide.teamA]!,
          ),
          pw.SizedBox(height: 8),
          _buildTeamCategorySummary(
            title: match.teamBName,
            totals: setStats.teamTotals[TeamSide.teamB]!,
          ),
          pw.SizedBox(height: 12),
          _buildPlayerStatsTable(
            title: 'Jogadores ${match.teamAName}',
            rows: setStats.teamPlayerStats[TeamSide.teamA]!,
            emptyLabel:
                'Sem pontuação individual registrada para ${match.teamAName}.',
          ),
          pw.SizedBox(height: 10),
          _buildPlayerStatsTable(
            title: 'Jogadores ${match.teamBName}',
            rows: setStats.teamPlayerStats[TeamSide.teamB]!,
            emptyLabel:
                'Sem pontuação individual registrada para ${match.teamBName}.',
          ),
          if (set.pointEvents.isEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              'Sem eventos detalhados registrados para este set.',
              style: const pw.TextStyle(color: PdfColors.grey700),
            ),
          ],
        ],
      ),
    );
  }

  pw.Widget _buildMatchTotalsSection(
      MatchScore match, _ConsolidatedStats consolidated) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Consolidado da partida'),
        _buildTeamCategorySummary(
          title: '${match.teamAName} • Totais por categoria',
          totals: consolidated.teamTotals[TeamSide.teamA]!,
        ),
        pw.SizedBox(height: 8),
        _buildTeamCategorySummary(
          title: '${match.teamBName} • Totais por categoria',
          totals: consolidated.teamTotals[TeamSide.teamB]!,
        ),
        pw.SizedBox(height: 12),
        _buildPlayerStatsTable(
          title: 'Jogadores ${match.teamAName}',
          rows: consolidated.teamPlayerStats[TeamSide.teamA]!,
          emptyLabel:
              'Sem pontuação individual consolidada para ${match.teamAName}.',
        ),
        pw.SizedBox(height: 10),
        _buildPlayerStatsTable(
          title: 'Jogadores ${match.teamBName}',
          rows: consolidated.teamPlayerStats[TeamSide.teamB]!,
          emptyLabel:
              'Sem pontuação individual consolidada para ${match.teamBName}.',
        ),
      ],
    );
  }

  pw.Widget _buildRankingSection(
      MatchScore match, _ConsolidatedStats consolidated) {
    final mvp = consolidated.ranking.first;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('Ranking da partida'),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#F6E7A6'),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Text(
            'MVP da partida: ${mvp.playerName} (${_teamName(match, mvp.teamSide)}) • ${mvp.total} ponto(s)',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: const {
            0: pw.FixedColumnWidth(42),
            1: pw.FlexColumnWidth(2),
            2: pw.FlexColumnWidth(1.5),
            3: pw.FixedColumnWidth(48),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableCell('Pos.', isHeader: true),
                _tableCell('Jogador', isHeader: true),
                _tableCell('Time', isHeader: true),
                _tableCell('Total', isHeader: true),
              ],
            ),
            for (var index = 0; index < consolidated.ranking.length; index++)
              pw.TableRow(
                children: [
                  _tableCell('${index + 1}'),
                  _tableCell(consolidated.ranking[index].playerName),
                  _tableCell(
                      _teamName(match, consolidated.ranking[index].teamSide)),
                  _tableCell('${consolidated.ranking[index].total}'),
                ],
              ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildTeamCategorySummary({
    required String title,
    required _CategoryTotals totals,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Total ${totals.total} • '
          'Ataque ${totals.attack} • '
          'Bloqueio ${totals.block} • '
          'Saque ${totals.serve} • '
          'Erro adv. ${totals.opponentError} • '
          'Outro ${totals.other}',
        ),
      ],
    );
  }

  pw.Widget _buildPlayerStatsTable({
    required String title,
    required List<_PlayerCategoryTotals> rows,
    required String emptyLabel,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#0F58B5'),
          ),
        ),
        pw.SizedBox(height: 4),
        if (rows.isEmpty)
          pw.Text(emptyLabel)
        else
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400),
            columnWidths: const {
              0: pw.FlexColumnWidth(2.2),
              1: pw.FixedColumnWidth(42),
              2: pw.FixedColumnWidth(42),
              3: pw.FixedColumnWidth(52),
              4: pw.FixedColumnWidth(42),
              5: pw.FixedColumnWidth(58),
              6: pw.FixedColumnWidth(42),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _tableCell('Jogador', isHeader: true),
                  _tableCell('Total', isHeader: true),
                  _tableCell('Ataq.', isHeader: true),
                  _tableCell('Bloq.', isHeader: true),
                  _tableCell('Saq.', isHeader: true),
                  _tableCell('Erro adv.', isHeader: true),
                  _tableCell('Outro', isHeader: true),
                ],
              ),
              for (final row in rows)
                pw.TableRow(
                  children: [
                    _tableCell(row.playerName),
                    _tableCell('${row.total}'),
                    _tableCell('${row.attack}'),
                    _tableCell('${row.block}'),
                    _tableCell('${row.serve}'),
                    _tableCell('${row.opponentError}'),
                    _tableCell('${row.other}'),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  _SetStats _buildSetStats(MatchScore match, SetScore set) {
    final teamTotals = _emptyTeamTotals();
    final playerTotals = <String, _PlayerCategoryTotals>{};

    for (final event in set.pointEvents) {
      final teamTotal = teamTotals[event.scoringTeam]!;
      teamTotal.add(event.pointOrigin);

      final playerId = event.playerId;
      final playerName = event.playerName;
      if (playerId == null ||
          playerId.isEmpty ||
          playerName == null ||
          playerName.isEmpty) {
        continue;
      }

      final key = '${event.scoringTeam.value}::$playerId';
      final playerTotal = playerTotals.putIfAbsent(
        key,
        () => _PlayerCategoryTotals(
          playerId: playerId,
          playerName: playerName,
          teamSide: event.scoringTeam,
        ),
      );
      playerTotal.add(event.pointOrigin);
    }

    return _SetStats(
      teamTotals: teamTotals,
      teamPlayerStats: _groupPlayersByTeam(playerTotals.values.toList()),
    );
  }

  _ConsolidatedStats _buildConsolidatedStats(MatchScore match) {
    final teamTotals = _emptyTeamTotals();
    final playerTotals = <String, _PlayerCategoryTotals>{};

    for (final set in match.sets) {
      for (final event in set.pointEvents) {
        teamTotals[event.scoringTeam]!.add(event.pointOrigin);

        final playerId = event.playerId;
        final playerName = event.playerName;
        if (playerId == null ||
            playerId.isEmpty ||
            playerName == null ||
            playerName.isEmpty) {
          continue;
        }

        final key = '${event.scoringTeam.value}::$playerId';
        final playerTotal = playerTotals.putIfAbsent(
          key,
          () => _PlayerCategoryTotals(
            playerId: playerId,
            playerName: playerName,
            teamSide: event.scoringTeam,
          ),
        );
        playerTotal.add(event.pointOrigin);
      }
    }

    final groupedPlayers = _groupPlayersByTeam(playerTotals.values.toList());
    final ranking = playerTotals.values.toList()
      ..sort((a, b) {
        final byTotal = b.total.compareTo(a.total);
        if (byTotal != 0) {
          return byTotal;
        }
        final byAttack = b.attack.compareTo(a.attack);
        if (byAttack != 0) {
          return byAttack;
        }
        return a.playerName.compareTo(b.playerName);
      });

    return _ConsolidatedStats(
      teamTotals: teamTotals,
      teamPlayerStats: groupedPlayers,
      ranking: ranking,
    );
  }

  Map<TeamSide, _CategoryTotals> _emptyTeamTotals() {
    return {
      TeamSide.teamA: _CategoryTotals(),
      TeamSide.teamB: _CategoryTotals(),
    };
  }

  Map<TeamSide, List<_PlayerCategoryTotals>> _groupPlayersByTeam(
      List<_PlayerCategoryTotals> rows) {
    final grouped = {
      TeamSide.teamA: <_PlayerCategoryTotals>[],
      TeamSide.teamB: <_PlayerCategoryTotals>[],
    };
    for (final row in rows) {
      grouped[row.teamSide]!.add(row);
    }
    for (final key in grouped.keys) {
      grouped[key]!.sort((a, b) {
        final byTotal = b.total.compareTo(a.total);
        if (byTotal != 0) {
          return byTotal;
        }
        return a.playerName.compareTo(b.playerName);
      });
    }
    return grouped;
  }

  String _winnerLabel(MatchScore match) {
    if (match.winnerTeam == TeamSide.teamA.value) {
      return match.teamAName;
    }
    if (match.winnerTeam == TeamSide.teamB.value) {
      return match.teamBName;
    }
    return 'Empate';
  }

  String _teamName(MatchScore match, TeamSide side) {
    return side == TeamSide.teamA ? match.teamAName : match.teamBName;
  }

  pw.Widget _sectionTitle(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: PdfColor.fromHex('#0F58B5'),
        ),
      ),
    );
  }

  pw.Widget _detailRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              label,
              style: const pw.TextStyle(color: PdfColors.grey700),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _tableCell(String value, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        value,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  pw.Widget _playersBlock(String title, List<String> players) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 4),
        pw.Text(players.join(', ')),
      ],
    );
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} $hour:$minute';
  }

  String _formatDuration(int durationSeconds) {
    if (durationSeconds <= 0) {
      return '-';
    }
    final duration = Duration(seconds: durationSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '${duration.inMinutes.toString().padLeft(2, '0')}:$seconds';
  }

  Future<Directory> _resolveSaveDirectory() async {
    if (Platform.isAndroid) {
      final publicDownloads = await _tryAndroidPublicDownloadsDirectory();
      if (publicDownloads != null) {
        return publicDownloads;
      }
      throw const FileSystemException(
        'Não foi possível acessar a pasta pública de Downloads do dispositivo.',
      );
    }

    final downloadsDirectory = await getDownloadsDirectory();
    if (downloadsDirectory != null) {
      final scoutSetDownloads =
          Directory(path.join(downloadsDirectory.path, 'ScoutSet'));
      await scoutSetDownloads.create(recursive: true);
      return scoutSetDownloads;
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final scoutSetDocuments =
        Directory(path.join(documentsDirectory.path, 'ScoutSet'));
    await scoutSetDocuments.create(recursive: true);
    return scoutSetDocuments;
  }

  Future<Directory?> _tryAndroidPublicDownloadsDirectory() async {
    const candidates = [
      '/storage/emulated/0/Download/ScoutSet',
      '/sdcard/Download/ScoutSet',
    ];

    for (final candidate in candidates) {
      try {
        final directory = Directory(candidate);
        await directory.create(recursive: true);
        final probe = File(path.join(directory.path, '.probe'));
        await probe.writeAsString('ok', flush: true);
        if (await probe.exists()) {
          await probe.delete();
          return directory;
        }
      } catch (_) {
        continue;
      }
    }

    return null;
  }

  Future<File> _writePdfFile({
    required Directory directory,
    required String fileName,
    required Uint8List bytes,
  }) async {
    await directory.create(recursive: true);
    final file = File(path.join(directory.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

class _PdfFonts {
  const _PdfFonts({
    required this.regular,
    required this.bold,
  });

  final pw.Font regular;
  final pw.Font bold;
}

class _SetStats {
  const _SetStats({
    required this.teamTotals,
    required this.teamPlayerStats,
  });

  final Map<TeamSide, _CategoryTotals> teamTotals;
  final Map<TeamSide, List<_PlayerCategoryTotals>> teamPlayerStats;
}

class _ConsolidatedStats {
  const _ConsolidatedStats({
    required this.teamTotals,
    required this.teamPlayerStats,
    required this.ranking,
  });

  final Map<TeamSide, _CategoryTotals> teamTotals;
  final Map<TeamSide, List<_PlayerCategoryTotals>> teamPlayerStats;
  final List<_PlayerCategoryTotals> ranking;
}

class _CategoryTotals {
  int attack = 0;
  int block = 0;
  int serve = 0;
  int opponentError = 0;
  int other = 0;

  void add(PointOrigin origin) {
    switch (origin) {
      case PointOrigin.attack:
        attack += 1;
      case PointOrigin.block:
        block += 1;
      case PointOrigin.serve:
        serve += 1;
      case PointOrigin.opponentError:
        opponentError += 1;
      case PointOrigin.other:
        other += 1;
    }
  }

  int get total => attack + block + serve + opponentError + other;
}

class _PlayerCategoryTotals extends _CategoryTotals {
  _PlayerCategoryTotals({
    required this.playerId,
    required this.playerName,
    required this.teamSide,
  });

  final String playerId;
  final String playerName;
  final TeamSide teamSide;
}
