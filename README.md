# ScoutSet

ScoutSet e um aplicativo Flutter voltado para volei, pensado para treinadores, atletas e equipes que querem organizar o jogo, visualizar cenarios taticos e preparar a base para analise e evolucao futura com IA.

## Simulador de Estrategias de Volei

A feature `lib/features/strategies/` agora inclui um simulador tatico completo com:

- lista de estrategias salvas
- criacao e edicao de estrategias
- visualizacao em modo leitura
- quadra interativa 2D responsiva
- jogadores arrastaveis
- desenho de movimentos taticos
- reset da quadra
- persistencia local mock em memoria

### Recursos do editor

- suporte a estrategias de `quadra` e `praia`
- 6 jogadores na quadra e 2 jogadores na praia
- desenho de movimentos dos tipos:
  - `attack`
  - `move`
  - `block`
  - `defense`
  - `coverage`
- historico de substituicoes por estrategia

### Regras de substituicao implementadas

- `Praia`: substituicoes nao sao permitidas
- `Quadra`: ate 6 substituicoes regulamentares por set
- um titular pode sair e retornar uma vez por set, apenas para o lugar de quem o substituiu
- trocas de libero sao ilimitadas e nao contam no limite regulamentar

## Estrutura principal

```text
lib/
  config/
  core/
  features/
    auth/
    dashboard/
    drills/
    profile/
    reports/
    rules/
    scoreboard/
    strategies/
      models/
      screens/
      services/
      widgets/
    teams/
    videos/
  utils/
  widgets/
```

Arquivos principais da feature de estrategias:

- `lib/features/strategies/models/strategy.dart`
- `lib/features/strategies/models/player_position.dart`
- `lib/features/strategies/models/movement.dart`
- `lib/features/strategies/models/substitution.dart`
- `lib/features/strategies/screens/strategies_screen.dart`
- `lib/features/strategies/screens/strategy_editor_screen.dart`
- `lib/features/strategies/screens/strategy_detail_screen.dart`
- `lib/features/strategies/services/strategy_service.dart`
- `lib/features/strategies/widgets/volleyball_court.dart`

## UI e padroes reutilizados

O app usa componentes compartilhados e tema centralizado, incluindo:

- `AppTheme` em `lib/core/theme/app_theme.dart`
- `AppCard`
- `AppButton`
- `SectionTitle`

## Persistencia

As estrategias sao armazenadas atualmente em memoria por `StrategyService`. Isso significa:

- os dados ficam disponiveis durante a sessao atual
- fechar o app limpa as estrategias salvas
- a estrutura ja foi preparada para futura troca por backend ou armazenamento persistente

## Testes

Existem testes adicionados para a feature de estrategias em:

- `test/features/strategies/strategy_service_test.dart`
- `test/features/strategies/strategies_feature_test.dart`

Coberturas principais:

- CRUD do servico de estrategias
- templates de quadra e praia
- fluxo basico de criacao
- alternancia entre quadra e praia
- visualizacao em modo leitura
- substituicoes em quadra
- bloqueio de substituicoes em praia

## Como executar

Com Flutter instalado no ambiente:

```bash
flutter pub get
flutter run
```

Para rodar os testes:

```bash
flutter test
```

## Proximos passos sugeridos

- persistencia local real
- animacao de jogadas
- simulacao de rally
- exportacao de estrategias
- integracao com backend
- analise tatica assistida por IA
