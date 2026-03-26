# ScoutSet

ScoutSet é um aplicativo Flutter focado em vôlei para apoiar treinadores, atletas e equipes em rotinas de jogo, treino e organização tático-operacional. O projeto já opera com persistência local offline-first usando SQLite com Drift e está estruturado para evoluir para relatórios, gestão de elenco e futuras integrações com backend.

## Visão rápida

- autenticação local com sessão persistida
- dashboard com navegação principal do app
- placar de vôlei em melhor de 3 sets
- simulador de estratégias para quadra e praia
- módulo de equipes com sorteio, montagem manual e formações salvas
- catálogo de drills com detalhe e animação 2D
- exportação e compartilhamento de partidas em PDF

## Estado atual do projeto

Hoje o app já entrega:

- autenticação local com cadastro, login, sessão persistida e validação de senha forte
- dashboard com navegação por shell e atalhos para os módulos principais
- módulo completo de placar eletrônico de vôlei em melhor de 3 sets
- simulador de estratégias de vôlei de quadra e praia
- módulo de equipes e sorteio de times com persistência local
- biblioteca de drills com filtros e tela de detalhe
- perfil com logout

Ainda estão como placeholders visuais preparados para evolução:

- regras
- vídeos
- relatórios

## Como rodar

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Persistência local

O app usa SQLite com Drift como base local principal.

Hoje já persistem em banco:

- usuários
- sessão ativa
- estratégias
- histórico de partidas finalizadas
- catálogo de drills
- jogadores do módulo de equipes
- histórico de sorteios e montagens
- fila de espera por conjunto ativo
- grupos salvos de equipes
- estrutura base legada para equipes e atletas

Decisões atuais:

- o seed inicial dos drills é aplicado na criação do banco
- o módulo de equipes começa sem jogadores pré-cadastrados
- a partida ativa do placar continua em memória durante a execução
- o histórico finalizado do placar é salvo no SQLite
- a UI não acessa o Drift diretamente; os serviços continuam como fachada da aplicação

Arquivos centrais:

- `lib/data/local/database/app_database.dart`
- `lib/data/local/database/app_services.dart`
- `lib/data/local/repositories/`
- `lib/data/local/seed/drills_seed.dart`
- `lib/data/local/seed/drills_seed_data.dart`

## Principais módulos

### Autenticação local

A autenticação fica em `lib/services/auth_service.dart` e usa SQLite via repository.

Recursos atuais:

- cadastro com validação de senha forte
- login com sessão persistida localmente
- proteção de rotas autenticadas
- logout com limpeza da sessão ativa

Telas:

- `lib/features/auth/screens/login_screen.dart`
- `lib/features/auth/screens/register_screen.dart`

### Placar

A feature `lib/features/scoreboard/` funciona como um placar operacional para partidas de vôlei.

Recursos atuais:

- início de partida com nome dos dois times
- início de partida a partir de equipes salvas
- partida em melhor de 3 sets
- sets 1 e 2 até 25 pontos
- set 3 até 15 pontos
- exigência de vantagem mínima de 2 pontos para fechar o set
- encerramento automático em `2x0` ou `2x1`
- indicação visual de saque
- desfazer do último ponto do set atual
- reinício da partida atual
- finalização manual da partida
- nova partida sem perder o histórico salvo
- histórico persistido localmente com tela de lista e detalhe
- detalhamento da origem da partida
- exportação e compartilhamento de partida em PDF

Quando a partida vem do módulo de equipes, o histórico também pode exibir:

- nome da formação salva
- jogadores do time A e time B
- jogadores em espera da rodada

Arquivos principais:

- `lib/features/scoreboard/models/match_score.dart`
- `lib/features/scoreboard/models/set_score.dart`
- `lib/features/scoreboard/models/scoreboard_state.dart`
- `lib/features/scoreboard/services/scoreboard_service.dart`
- `lib/features/scoreboard/screens/scoreboard_screen.dart`
- `lib/features/scoreboard/screens/match_history_screen.dart`
- `lib/features/scoreboard/screens/match_detail_screen.dart`
- `lib/features/scoreboard/services/match_pdf_service.dart`

Observações:

- a partida em andamento é mantida em memória
- ao finalizar, a partida é persistida no SQLite

### Estratégias

A feature `lib/features/strategies/` oferece um simulador tático com persistência local.

Recursos atuais:

- lista de estratégias persistidas no SQLite
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

A feature `lib/features/drills/` já possui experiência funcional de catálogo e persistência local.

Recursos atuais:

- listagem de drills carregados do SQLite
- filtros por categoria e favoritos
- cards com metadados de dificuldade, duração e número de jogadores
- tela de detalhe com suporte a animação 2D

Arquivos principais:

- `lib/features/drills/screens/drills_screen.dart`
- `lib/features/drills/screens/drill_detail_screen.dart`
- `lib/features/drills/services/drills_service.dart`

### Equipes e Sorteio

A feature `lib/features/teams/` já possui fluxo funcional para organização de jogadores e montagem de equipes.

Recursos atuais:

- lista local de jogadores criada pelo próprio usuário
- cadastro e remoção de jogadores
- sorteio aleatório com `Random.secure()`
- sorteio balanceado simples por nível
- montagem manual por toque
- suporte a 2 ou 3 equipes conforme quantidade de jogadores
- tratamento de quantidade ímpar com equipe maior ou fila de espera
- prioridade para jogadores que ficaram aguardando
- histórico persistido de sorteios e montagens
- salvamento de formações para reutilização futura
- reutilização direta das equipes salvas no placar

Arquivos principais:

- `lib/features/teams/screens/teams_screen.dart`
- `lib/features/teams/screens/team_draw_screen.dart`
- `lib/features/teams/screens/team_manual_builder_screen.dart`
- `lib/features/teams/screens/team_draw_result_screen.dart`
- `lib/features/teams/screens/saved_teams_screen.dart`
- `lib/features/teams/screens/draw_history_screen.dart`
- `lib/features/teams/services/team_draw_service.dart`
- `lib/features/teams/services/saved_team_service.dart`

## Estrutura principal

```text
lib/
  config/
  core/
  data/
    local/
      database/
      repositories/
      seed/
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

Além da shell, o app também possui rotas dedicadas para:

- equipes
- drills
- regras
- vídeos

Padrões compartilhados:

- `AppTheme` em `lib/core/theme/app_theme.dart`
- `AppCard`
- `AppButton`
- `AppTextField`
- `SectionTitle`
- `AppShellScreen` em `lib/features/dashboard/screens/app_shell_screen.dart`

## Dependências principais

- `flutter`
- `drift`
- `sqlite3_flutter_libs`
- `path`
- `path_provider`
- `crypto`
- `pdf`
- `printing`
- `share_plus`

## Comandos úteis

Gerar arquivos do Drift:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Gerar APK de debug:

```bash
flutter build apk --debug
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

Rodar testes de equipes:

```bash
flutter test test/features/teams/team_draw_service_test.dart test/features/teams/teams_screen_test.dart
```

## Testes existentes

Cobertura atual inclui:

- autenticação e proteção de rotas
- regras e fluxos do placar eletrônico
- histórico e navegação do módulo de placar
- persistência e CRUD de estratégias
- regras principais do módulo de equipes
- renderização básica da tela de equipes
- modos quadra e praia
- comportamento de substituições
- drills e navegação básica
- smoke tests do app e do login

Arquivos de teste atuais:

- `test/widget_test.dart`
- `test/auth_guard_test.dart`
- `test/auth_service_test.dart`
- `test/features/scoreboard/scoreboard_service_test.dart`
- `test/features/scoreboard/scoreboard_feature_test.dart`
- `test/features/strategies/strategy_service_test.dart`
- `test/features/strategies/strategies_feature_test.dart`

## Próximos passos naturais

- implementar os módulos placeholder como features funcionais
- conectar equipes e atletas às estratégias e ao placar
- persistir também partidas em andamento, se desejado
- adicionar eventos de rally, timeout e scout ao placar
- construir relatórios a partir das tabelas locais
- integrar backend e sincronização entre dispositivos
- expandir relatórios e análises assistidas por IA
