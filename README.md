# ScoutSet

ScoutSet é um aplicativo Flutter focado em vôlei para apoiar treinadores, atletas e equipes em rotinas de jogo, treino e organização tático-operacional. O projeto já opera com persistência local offline-first usando SQLite com Drift e está estruturado para evoluir para relatórios, gestão de elenco e futuras integrações com backend.

## Estado atual do projeto

Hoje o app já entrega:

- autenticação local com cadastro, login, sessão persistida e validação de senha forte
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

## Persistência local

O app usa SQLite com Drift como base local principal.

Hoje já persistem em banco:

- usuários
- sessão ativa
- estratégias
- histórico de partidas finalizadas
- catálogo de drills
- estrutura base para equipes e atletas

Decisões atuais:

- o seed inicial dos drills é aplicado na criação do banco
- a partida ativa do placar continua em memória durante a execução
- o histórico finalizado do placar é salvo no SQLite
- a UI não acessa o Drift diretamente; os serviços continuam como fachada da aplicação

Arquivos centrais:

- `lib/data/local/database/app_database.dart`
- `lib/data/local/database/app_services.dart`
- `lib/data/local/repositories/`
- `lib/data/local/seed/drills_seed.dart`
- `lib/data/local/seed/drills_seed_data.dart`

## Principais features

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
- nova partida sem perder o histórico salvo
- histórico persistido localmente com tela de lista e detalhe

Arquivos principais:

- `lib/features/scoreboard/models/match_score.dart`
- `lib/features/scoreboard/models/set_score.dart`
- `lib/features/scoreboard/models/scoreboard_state.dart`
- `lib/features/scoreboard/services/scoreboard_service.dart`
- `lib/features/scoreboard/screens/scoreboard_screen.dart`
- `lib/features/scoreboard/screens/match_history_screen.dart`
- `lib/features/scoreboard/screens/match_detail_screen.dart`

Observações:

- a partida em andamento é mantida em memória
- ao finalizar, a partida é persistida no SQLite

### Simulador de estratégias de vôlei

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

## Como executar

Com Flutter instalado no ambiente:

```bash
flutter pub get
flutter run
```

## Codegen

Sempre que houver mudança no schema do Drift, rode:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
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
- regras e fluxos do placar eletrônico
- histórico e navegação do módulo de placar
- persistência e CRUD de estratégias
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
