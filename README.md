# ScoutSet

ScoutSet é um aplicativo Flutter focado em vôlei para apoiar treinadores, atletas e equipes em rotinas de jogo, treino e organização tático-operacional. O projeto combina módulos funcionais já implementados com uma base pronta para evoluir para persistência local real, backend e futuras integrações com análise e scout.

## Estado atual do projeto

Hoje o app já entrega:

- autenticação local com cadastro, login, sessão e migração de usuários legados
- dashboard com navegação por shell e atalhos para os módulos principais
- módulo completo de placar eletrônico de vôlei em melhor de 3 sets
- simulador de estratégias de vôlei de quadra e praia
- biblioteca de drills com filtros e tela de detalhe
- perfil com logout

Ainda estão como placeholders visuais preparados para evolução:

- regras
- vídeos
- relatórios
- equipes

## Principais features

### Autenticação local

A autenticação fica em `lib/services/auth_service.dart` e usa `shared_preferences` via `StorageService`.

Recursos atuais:

- cadastro com validação de senha forte
- login com sessão persistida localmente
- proteção de rotas autenticadas
- migração automática de usuários antigos salvos com senha em formato legado

Telas:

- `lib/features/auth/screens/login_screen.dart`
- `lib/features/auth/screens/register_screen.dart`

### Placar Eletrônico de Vôlei

A feature `lib/features/scoreboard/` funciona como um placar operacional para partidas de vôlei.

Recursos atuais:

- início de partida com nome dos dois times
- partida em melhor de 3 sets
- sets 1 e 2 até 25 pontos
- set 3 até 15 pontos
- exigência de vantagem mínima de 2 pontos para fechar o set
- encerramento automático em `2x0` ou `2x1`
- indicação visual de saque
- desfazer do último ponto do set atual
- reinício da partida atual
- finalização manual da partida
- nova partida sem perder o histórico da sessão
- histórico em memória com tela de lista e detalhe

Arquivos principais:

- `lib/features/scoreboard/models/match_score.dart`
- `lib/features/scoreboard/models/set_score.dart`
- `lib/features/scoreboard/models/scoreboard_state.dart`
- `lib/features/scoreboard/services/scoreboard_service.dart`
- `lib/features/scoreboard/screens/scoreboard_screen.dart`
- `lib/features/scoreboard/screens/match_history_screen.dart`
- `lib/features/scoreboard/screens/match_detail_screen.dart`

Observações:

- o histórico do placar é mantido em memória durante a execução atual do app
- a estrutura foi separada em modelos, serviço, telas e widgets para facilitar futura persistência local ou backend

### Simulador de estratégias de vôlei

A feature `lib/features/strategies/` oferece um simulador tático já bem avançado.

Recursos atuais:

- lista de estratégias salvas em memória
- criação e edição de estratégias
- visualização em modo leitura
- suporte a vôlei de quadra e praia
- quadra interativa 2D responsiva
- jogadores arrastáveis
- desenho de movimentos táticos
- reset de disposição dos jogadores
- histórico de substituições por estratégia

Regras implementadas:

- praia sem substituições durante o set
- quadra com até 6 substituições regulamentares por set
- controle básico de retorno do titular e trocas de líbero

Arquivos principais:

- `lib/features/strategies/models/strategy.dart`
- `lib/features/strategies/models/player_position.dart`
- `lib/features/strategies/models/movement.dart`
- `lib/features/strategies/models/substitution.dart`
- `lib/features/strategies/screens/strategies_screen.dart`
- `lib/features/strategies/screens/strategy_editor_screen.dart`
- `lib/features/strategies/screens/strategy_detail_screen.dart`
- `lib/features/strategies/services/strategy_service.dart`
- `lib/features/strategies/widgets/volleyball_court.dart`

### Drills

A feature `lib/features/drills/` já possui experiência funcional de catálogo.

Recursos atuais:

- listagem de drills mockados
- filtros por categoria e favoritos
- cards com metadados de dificuldade, duração e número de jogadores
- tela de detalhe com suporte a animação 2D

Arquivos principais:

- `lib/features/drills/screens/drills_screen.dart`
- `lib/features/drills/screens/drill_detail_screen.dart`
- `lib/features/drills/services/drill_mock_service.dart`

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
    teams/
    videos/
  models/
  services/
  utils/
  widgets/
```

## Navegação e UI

O app usa uma shell principal com abas para:

- dashboard
- placar
- estratégias
- relatórios
- perfil

Padrões compartilhados:

- `AppTheme` em `lib/core/theme/app_theme.dart`
- `AppCard`
- `AppButton`
- `AppTextField`
- `SectionTitle`
- `AppShellScreen` em `lib/features/dashboard/screens/app_shell_screen.dart`

## Dependências principais

- `flutter`
- `shared_preferences`
- `crypto`

## Como executar

Com Flutter instalado no ambiente:

```bash
flutter pub get
flutter run
```

## Como testar

Rodar toda a suíte:

```bash
flutter test
```

Rodar apenas análise estática:

```bash
flutter analyze
```

Rodar testes do placar:

```bash
flutter test test/features/scoreboard/scoreboard_service_test.dart test/features/scoreboard/scoreboard_feature_test.dart
```

Rodar testes de estratégias:

```bash
flutter test test/features/strategies/strategy_service_test.dart test/features/strategies/strategies_feature_test.dart
```

## Testes existentes

Cobertura atual inclui:

- autenticação e proteção de rotas
- migração de usuários legados
- regras e fluxos do placar eletrônico
- histórico e navegação do módulo de placar
- CRUD e regras de estratégias
- modos quadra e praia
- comportamento de substituições
- smoke tests do app e do login

Arquivos de teste atuais:

- `test/widget_test.dart`
- `test/auth_guard_test.dart`
- `test/auth_service_test.dart`
- `test/features/scoreboard/scoreboard_service_test.dart`
- `test/features/scoreboard/scoreboard_feature_test.dart`
- `test/features/strategies/strategy_service_test.dart`
- `test/features/strategies/strategies_feature_test.dart`

## Persistência atual

O projeto hoje mistura dois cenários:

- autenticação com persistência local em `shared_preferences`
- features de domínio como placar e estratégias ainda salvas em memória durante a sessão

Isso significa:

- usuários e sessão sobrevivem ao fechamento do app
- histórico do placar e estratégias não sobrevivem ao fechamento do app
- a arquitetura atual já facilita trocar serviços em memória por persistência local real no futuro

## Próximos passos naturais

- persistir histórico do placar e estratégias em armazenamento local
- evoluir os módulos placeholder para features funcionais
- conectar equipes cadastradas ao placar e às estratégias
- adicionar eventos de rally, timeout e scout ao placar
- integrar backend e sincronização entre dispositivos
- expandir relatórios e análises assistidas por IA
