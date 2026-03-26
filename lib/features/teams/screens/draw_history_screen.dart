import 'package:flutter/material.dart';

import '../../../../utils/app_spacing.dart';
import '../../../../widgets/app_card.dart';
import '../models/team_draw_result.dart';
import '../services/team_draw_service.dart';
import 'team_draw_result_screen.dart';

class DrawHistoryScreen extends StatefulWidget {
  const DrawHistoryScreen({super.key});

  @override
  State<DrawHistoryScreen> createState() => _DrawHistoryScreenState();
}

class _DrawHistoryScreenState extends State<DrawHistoryScreen> {
  final TeamDrawService _service = TeamDrawService.instance;

  bool _isLoading = true;
  List<TeamDrawResult> _history = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final history = await _service.listDrawHistory();
    if (!mounted) {
      return;
    }
    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Sorteios')),
      body: _history.isEmpty
          ? ListView(
              padding: AppSpacing.screen,
              children: [
                Text(
                  'Nenhuma rodada registrada ainda.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          : ListView.separated(
              padding: AppSpacing.screen,
              itemCount: _history.length,
              separatorBuilder: (_, __) => AppSpacing.gapMedium,
              itemBuilder: (context, index) {
                final result = _history[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => TeamDrawResultScreen(result: result),
                      ),
                    );
                  },
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${result.numberOfTeams} equipe(s) • ${result.drawMode.label}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text('${result.totalPlayers} jogadores'),
                        const SizedBox(height: 8),
                        Text(
                          result.teams.map((team) => '${team.name} (${team.players.length})').join(' • '),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
