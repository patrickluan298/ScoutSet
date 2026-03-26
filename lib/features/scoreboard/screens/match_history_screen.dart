import 'package:flutter/material.dart';

import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../models/match_score.dart';
import '../services/match_pdf_service.dart';
import '../services/scoreboard_service.dart';
import 'match_detail_screen.dart';

class MatchHistoryScreen extends StatelessWidget {
  const MatchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ScoreboardService.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Partidas')),
      body: ValueListenableBuilder(
        valueListenable: service.stateNotifier,
        builder: (context, state, _) {
          final history = state.history;
          if (history.isEmpty) {
            return ListView(
              padding: AppSpacing.screen,
              children: [
                AppCard(
                  child: Text(
                    'Nenhuma partida registrada ainda. Inicie um jogo no placar para salvar o histórico.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            );
          }

          return ListView.separated(
            padding: AppSpacing.screen,
            itemBuilder: (context, index) {
              final match = history[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => MatchDetailScreen(match: match),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${match.teamAName} x ${match.teamBName}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Resultado em sets: ${match.teamASetsWon} x ${match.teamBSetsWon}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _buildSetSummary(match),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Vencedor: ${_winnerLabel(match)}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Text(
                            _formatDate(match.finishedAt ?? match.createdAt),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () async {
                              final file = await MatchPdfService.instance.savePdf(match);
                              if (!context.mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('PDF salvo em ${file.path}')),
                              );
                            },
                            icon: const Icon(Icons.download_outlined),
                            label: const Text('Baixar PDF'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              await MatchPdfService.instance.sharePdf(match);
                            },
                            icon: const Icon(Icons.share_outlined),
                            label: const Text('Compartilhar PDF'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => AppSpacing.gapMedium,
            itemCount: history.length,
          );
        },
      ),
    );
  }

  String _buildSetSummary(MatchScore match) {
    return match.sets
        .map((set) => 'S${set.setNumber}: ${set.teamAScore}-${set.teamBScore}')
        .join('  •  ');
  }

  String _winnerLabel(MatchScore match) {
    if (match.winnerTeam == TeamSide.teamA.value) {
      return match.teamAName;
    }
    return match.teamBName;
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} $hour:$minute';
  }
}
