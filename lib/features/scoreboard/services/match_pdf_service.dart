import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../models/match_score.dart';

class MatchPdfService {
  MatchPdfService._();

  static final MatchPdfService instance = MatchPdfService._();

  Future<Uint8List> buildMatchPdf(MatchScore match) async {
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(24),
          theme: pw.ThemeData.withFont(),
        ),
        build: (context) => [
          pw.Container(
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
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          _sectionTitle('Resumo'),
          _detailRow('Data de início', _formatDate(match.createdAt)),
          _detailRow(
            'Data de encerramento',
            match.finishedAt == null ? '-' : _formatDate(match.finishedAt!),
          ),
          _detailRow('Status', match.matchStatus.label),
          _detailRow('Origem', match.sourceType == MatchSourceType.manual ? 'Manual' : 'Equipes salvas'),
          if (match.savedTeamGroupTitle != null) _detailRow('Formação', match.savedTeamGroupTitle!),
          _detailRow('Placar final', '${match.teamASetsWon} x ${match.teamBSetsWon}'),
          _detailRow(
            'Vencedor',
            match.winnerTeam == TeamSide.teamA.value
                ? match.teamAName
                : match.winnerTeam == TeamSide.teamB.value
                    ? match.teamBName
                    : 'Empate',
          ),
          pw.SizedBox(height: 20),
          _sectionTitle('Sets'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _tableCell('Set', isHeader: true),
                  _tableCell(match.teamAName, isHeader: true),
                  _tableCell(match.teamBName, isHeader: true),
                ],
              ),
              for (final set in match.sets)
                pw.TableRow(
                  children: [
                    _tableCell(set.setNumber.toString()),
                    _tableCell(set.teamAScore.toString()),
                    _tableCell(set.teamBScore.toString()),
                  ],
                ),
            ],
          ),
          if (match.teamAPlayers.isNotEmpty || match.teamBPlayers.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _sectionTitle('Jogadores'),
            _playersBlock(match.teamAName, match.teamAPlayers.map((player) => player.name).toList()),
            pw.SizedBox(height: 12),
            _playersBlock(match.teamBName, match.teamBPlayers.map((player) => player.name).toList()),
          ],
          if (match.waitingPlayersSnapshot.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _sectionTitle('Jogadores aguardando'),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                for (final player in match.waitingPlayersSnapshot)
                  pw.Text('${player.playerName} • prioridade ${player.priorityOrder}'),
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
    final sanitizedName = '${match.teamAName}_${match.teamBName}'.replaceAll(' ', '_');
    return _writePdfFile(
      directory: directory,
      fileName: 'partida_$sanitizedName.pdf',
      bytes: bytes,
    );
  }

  Future<void> sharePdf(MatchScore match) async {
    final bytes = await buildMatchPdf(match);
    final temporaryDirectory = await getTemporaryDirectory();
    final sanitizedName = '${match.teamAName}_${match.teamBName}'.replaceAll(' ', '_');
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
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        value,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
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
      final scoutSetDownloads = Directory(path.join(downloadsDirectory.path, 'ScoutSet'));
      await scoutSetDownloads.create(recursive: true);
      return scoutSetDownloads;
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final scoutSetDocuments = Directory(path.join(documentsDirectory.path, 'ScoutSet'));
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
