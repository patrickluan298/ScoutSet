enum SportMode {
  court(
    value: 'court',
    label: 'Vôlei de Quadra',
    shortLabel: 'Quadra',
    dashboardTitle: 'Treinos de Quadra',
    dashboardSubtitle: 'Organize os módulos e acompanhe a rotina da modalidade indoor.',
    accentDescription: 'Fluxo completo para seis jogadores, rotação e leitura tática de quadra.',
  ),
  beach(
    value: 'beach',
    label: 'Vôlei de Praia',
    shortLabel: 'Praia',
    dashboardTitle: 'Rotina de Praia',
    dashboardSubtitle: 'Acesse os módulos com contexto ativo para a modalidade de areia.',
    accentDescription: 'Base compartilhada do app com regras e navegação já contextualizadas.',
  );

  const SportMode({
    required this.value,
    required this.label,
    required this.shortLabel,
    required this.dashboardTitle,
    required this.dashboardSubtitle,
    required this.accentDescription,
  });

  final String value;
  final String label;
  final String shortLabel;
  final String dashboardTitle;
  final String dashboardSubtitle;
  final String accentDescription;

  static SportMode fromValue(String? value) {
    return SportMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => SportMode.court,
    );
  }
}
