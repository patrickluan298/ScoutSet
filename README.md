# ScoutSet

ScoutSet é um aplicativo Flutter voltado ao voleibol para apoiar treino, organização de equipes, consulta de regras e operação de jogo. O projeto hoje funciona de forma offline-first, com persistência local em SQLite via Drift, e já reúne módulos funcionais para autenticação, placar, estratégias, equipes, drills e regras oficiais.

## Visão geral

O app atualmente entrega:

- autenticação local com cadastro, login e sessão persistida
- dashboard com atalhos para os módulos principais
- shell com navegação inferior entre dashboard, placar, estratégias, relatórios e perfil
- placar eletrônico de vôlei em melhor de 3 sets, com histórico local e exportação em PDF
- simulador tático de quadra e praia com persistência local
- módulo de equipes com sorteio, montagem manual, fila de espera e formações salvas
- catálogo de drills com filtros, favoritos e tela de detalhe
- módulo de regras oficiais com navegação lateral, busca local e leitura por capítulos e seções
- perfil com logout

Ainda permanecem como placeholders:

- relatórios
- vídeos

## Como rodar

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Stack e dependências principais

- `flutter`
- `drift`
- `sqlite3_flutter_libs`
- `path`
- `path_provider`
- `crypto`
- `diacritic`
- `pdf`
- `printing`
- `share_plus`

## Persistência local

O app usa SQLite com Drift como camada principal de dados locais.

Hoje já persistem em banco:

- usuários
- sessão autenticada
- estratégias
- histórico de partidas finalizadas
- catálogo de drills e favoritos
- jogadores do módulo de equipes
- histórico de sorteios e montagens
- fila de espera por conjunto ativo
- grupos salvos de equipes

Observações atuais:

- os drills são semeados na criação do banco
- a partida ativa do placar continua em memória durante a execução
- o histórico finalizado do placar é salvo no SQLite
- históricos persistidos de partidas e sorteios são limpos automaticamente após 7 dias
- a UI acessa os dados por serviços e repositórios, não diretamente pelo Drift

Arquivos centrais:

- `lib/data/local/database/app_database.dart`
- `lib/data/local/database/app_services.dart`
- `lib/data/local/repositories/`
- `lib/data/local/seed/drills_seed.dart`
- `lib/data/local/seed/drills_seed_data.dart`

## Módulos principais

### Autenticação

Arquivos principais:

- `lib/services/auth_service.dart`
- `lib/features/auth/screens/login_screen.dart`
- `lib/features/auth/screens/register_screen.dart`

Recursos atuais:

- cadastro com validação de senha forte
- login local com sessão persistida
- proteção de rotas autenticadas
- recuperação local de senha pela tela de login
- logout com limpeza da sessão ativa

### Placar

Arquivos principais:

- `lib/features/scoreboard/models/match_score.dart`
- `lib/features/scoreboard/models/set_score.dart`
- `lib/features/scoreboard/models/scoreboard_state.dart`
- `lib/features/scoreboard/services/scoreboard_service.dart`
- `lib/features/scoreboard/services/match_pdf_service.dart`
- `lib/features/scoreboard/screens/scoreboard_screen.dart`
- `lib/features/scoreboard/screens/match_history_screen.dart`
- `lib/features/scoreboard/screens/match_detail_screen.dart`

Recursos atuais:

- início de partida com nome dos dois times
- início de partida a partir de equipes salvas
- partidas em melhor de 3 sets
- sets 1 e 2 até 25 pontos
- set 3 até 15 pontos
- vantagem mínima de 2 pontos para fechar set e partida
- indicação visual de saque
- desfazer do último ponto do set atual
- reinício da partida atual
- finalização manual da partida
- histórico persistido com lista e detalhe
- exportação e compartilhamento de partida em PDF

### Estratégias

Arquivos principais:

- `lib/features/strategies/models/strategy.dart`
- `lib/features/strategies/models/player_position.dart`
- `lib/features/strategies/models/movement.dart`
- `lib/features/strategies/models/substitution.dart`
- `lib/features/strategies/services/strategy_service.dart`
- `lib/features/strategies/screens/strategies_screen.dart`
- `lib/features/strategies/screens/strategy_editor_screen.dart`
- `lib/features/strategies/screens/strategy_detail_screen.dart`
- `lib/features/strategies/widgets/volleyball_court.dart`

Recursos atuais:

- lista de estratégias persistidas no SQLite
- criação, edição e visualização em modo leitura
- suporte a vôlei de quadra e praia
- quadra 2D responsiva
- jogadores arrastáveis
- desenho de movimentos táticos
- reset de disposição dos jogadores
- histórico de substituições por estratégia

### Equipes

Arquivos principais:

- `lib/features/teams/screens/teams_screen.dart`
- `lib/features/teams/screens/team_draw_screen.dart`
- `lib/features/teams/screens/team_manual_builder_screen.dart`
- `lib/features/teams/screens/team_draw_result_screen.dart`
- `lib/features/teams/screens/saved_teams_screen.dart`
- `lib/features/teams/screens/draw_history_screen.dart`
- `lib/features/teams/services/team_draw_service.dart`
- `lib/features/teams/services/saved_team_service.dart`

Recursos atuais:

- cadastro local de jogadores
- remoção de jogadores
- sorteio aleatório com `Random.secure()`
- sorteio balanceado simples por nível
- montagem manual por toque
- suporte a 2 ou 3 equipes conforme quantidade de jogadores
- limite de até 6 jogadores por equipe
- tratamento de quantidade ímpar com equipe maior ou fila de espera
- prioridade para jogadores que ficaram aguardando
- histórico persistido de sorteios e montagens
- salvamento de formações para reutilização
- reutilização direta das equipes salvas no placar

### Drills

Arquivos principais:

- `lib/features/drills/screens/drills_screen.dart`
- `lib/features/drills/screens/drill_detail_screen.dart`
- `lib/features/drills/services/drills_service.dart`

Recursos atuais:

- listagem de drills carregados do SQLite
- filtros por categoria e favoritos
- favoritar e desfavoritar com persistência local
- cards com metadados de dificuldade, duração e número de jogadores
- tela de detalhe com suporte a animação 2D

### Regras Oficiais

Arquivos principais:

- `assets/data/rules_official_catalog.json`
- `lib/features/rules/data/rules_catalog_repository.dart`
- `lib/features/rules/models/rules_models.dart`
- `lib/features/rules/screens/rules_screen.dart`
- `lib/features/rules/widgets/rules_section_panel.dart`

Recursos atuais:

- catálogo local de regras oficiais carregado de asset JSON
- tela de leitura com identidade visual integrada ao ScoutSet
- sumário lateral para categorias, capítulos e documentos oficiais
- busca textual local no conteúdo
- leitura por capítulos e seções expansíveis
- suporte ao fluxo mobile com abertura do sumário em painel lateral

Observação:

- o módulo usa um catálogo local em português com estrutura oficial de capítulos e seções; o conteúdo é consumido offline pelo app

### Placeholders atuais

Arquivos:

- `lib/features/reports/screens/reports_screen.dart`
- `lib/features/videos/screens/videos_screen.dart`

Status:

- relatórios e vídeos ainda usam `ModulePlaceholderScreen`

## Navegação e UI

Rotas principais definidas em `lib/config/app_routes.dart`.

O app usa:

- shell principal em `lib/features/dashboard/screens/app_shell_screen.dart`
- navegação inferior entre dashboard, placar, estratégias, relatórios e perfil
- rotas dedicadas para drills, regras, equipes e vídeos

Padrões compartilhados:

- `AppTheme` em `lib/core/theme/app_theme.dart`
- `AppCard`
- `AppButton`
- `AppTextField`
- `SectionTitle`
- `AppPageScaffold`

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
assets/
  data/
  fonts/
  images/
test/
```

## Comandos úteis

Gerar arquivos do Drift:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Rodar a suíte inteira:

```bash
flutter test
```

Rodar análise estática:

```bash
flutter analyze
```

Rodar os testes do módulo de regras:

```bash
flutter test test/features/rules/rules_catalog_repository_test.dart test/features/rules/rules_screen_test.dart
```

Rodar os testes do placar:

```bash
flutter test test/features/scoreboard/scoreboard_service_test.dart test/features/scoreboard/scoreboard_feature_test.dart test/features/scoreboard/match_pdf_service_test.dart
```

Rodar os testes de estratégias:

```bash
flutter test test/features/strategies/strategy_service_test.dart test/features/strategies/strategies_feature_test.dart
```

Rodar os testes de equipes:

```bash
flutter test test/features/teams/team_draw_service_test.dart test/features/teams/teams_screen_test.dart
```

## Testes existentes

Arquivos de teste atuais:

- `test/widget_test.dart`
- `test/auth_guard_test.dart`
- `test/auth_service_test.dart`
- `test/features/rules/rules_catalog_repository_test.dart`
- `test/features/rules/rules_screen_test.dart`
- `test/features/scoreboard/match_pdf_service_test.dart`
- `test/features/scoreboard/scoreboard_feature_test.dart`
- `test/features/scoreboard/scoreboard_service_test.dart`
- `test/features/strategies/strategies_feature_test.dart`
- `test/features/strategies/strategy_service_test.dart`
- `test/features/teams/team_draw_service_test.dart`
- `test/features/teams/teams_screen_test.dart`

Cobertura atual inclui:

- autenticação e proteção de rotas
- módulo de regras e navegação lateral
- renderização e busca do catálogo de regras
- regras de negócio do placar
- histórico e navegação do módulo de placar
- exportação de partidas em PDF
- persistência e CRUD de estratégias
- regras principais do módulo de equipes
- renderização básica da tela de equipes
- drills e smoke tests do app

## Próximos passos naturais

- transformar relatórios e vídeos em features funcionais
- conectar ainda mais equipes, estratégias e placar entre si
- persistir também partidas em andamento, se fizer sentido para o produto
- expandir o placar com eventos de rally, timeout e scout
- ampliar relatórios e análises de desempenho
- avaliar sincronização futura com backend
