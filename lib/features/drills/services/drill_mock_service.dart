import '../models/drill.dart';

class DrillMockService {
  const DrillMockService._();

  static const DrillMockService instance = DrillMockService._();

  List<Drill> getDrills() => _drills;

  Drill getById(String id) {
    return _drills.firstWhere(
      (drill) => drill.id == id,
      orElse: () => _drills.first,
    );
  }
}

const _teamBlue = 0xFF0F58B5;
const _teamOrange = 0xFFF5BE00;
const _teamDark = 0xFF081426;

const List<Drill> _drills = [
  Drill(
    id: 'reception-triangle',
    name: 'Recepção em Triângulo com Transição',
    category: 'Recepção',
    objective: 'Melhorar leitura do saque, estabilidade de manchete e transição para levantamento.',
    difficulty: 'Intermediário',
    duration: '12 min',
    isFavorite: true,
    players: [
      DrillPlayer(id: 'a', label: 'A', role: 'Passadora', colorHex: _teamBlue),
      DrillPlayer(id: 'b', label: 'B', role: 'Levantadora', colorHex: _teamOrange),
      DrillPlayer(id: 'c', label: 'C', role: 'Atacante', colorHex: _teamDark),
    ],
    steps: [
      'Jogadora A se prepara na base para receber o saque.',
      'A bola é direcionada para a levantadora B na zona central.',
      'B faz o levantamento e C ajusta a aproximação para atacar.',
      'C finaliza o lance e o grupo retorna para a posição inicial.',
    ],
    tips: [
      'Mantenha a base baixa antes do contato com a bola.',
      'Direcione a manchete para a frente da testa da levantadora.',
      'A atacante deve iniciar a passada no momento da saída da bola.',
    ],
    commonErrors: [
      'Receber com ombros desequilibrados e mandar a bola para fora da zona de levantamento.',
      'Iniciar a corrida de ataque cedo demais.',
      'Levantar com os pés desalinhados em relação ao alvo.',
    ],
    variations: [
      'Alternar o alvo do ataque entre diagonal e paralela.',
      'Adicionar saque flutuante curto para exigir ajuste rápido.',
      'Trocar a recebedora a cada três repetições.',
    ],
    animationFrames: [
      AnimationFrame(
        timestamp: 0,
        stepIndex: 0,
        highlightPlayerId: 'a',
        instructionText: 'Prepare a base',
        ballPosition: BallPosition(x: 50, y: 10),
        highlightedZones: [
          CourtZoneHighlight(x: 40, y: 63, width: 18, height: 18, label: 'Zona de recepção'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'a', x: 48, y: 72),
          PlayerPosition(playerId: 'b', x: 50, y: 54),
          PlayerPosition(playerId: 'c', x: 70, y: 44),
        ],
        movements: [
          MovementPath(playerId: 'a', fromX: 48, fromY: 78, toX: 48, toY: 72, label: 'ajuste'),
        ],
      ),
      AnimationFrame(
        timestamp: 1800,
        stepIndex: 1,
        highlightPlayerId: 'a',
        instructionText: 'Antecipe o movimento',
        ballPosition: BallPosition(x: 49, y: 58),
        playersPositions: [
          PlayerPosition(playerId: 'a', x: 49, y: 68),
          PlayerPosition(playerId: 'b', x: 50, y: 52),
          PlayerPosition(playerId: 'c', x: 68, y: 42),
        ],
        movements: [
          MovementPath(playerId: 'a', fromX: 48, fromY: 72, toX: 49, toY: 68, label: 'recebe'),
          MovementPath(playerId: 'b', fromX: 50, fromY: 54, toX: 50, toY: 52, label: 'abre alvo'),
        ],
      ),
      AnimationFrame(
        timestamp: 3400,
        stepIndex: 2,
        highlightPlayerId: 'b',
        instructionText: 'Solte a bola no tempo da atacante',
        ballPosition: BallPosition(x: 60, y: 47),
        highlightedZones: [
          CourtZoneHighlight(x: 55, y: 36, width: 16, height: 16, label: 'Janela de ataque'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'a', x: 47, y: 70),
          PlayerPosition(playerId: 'b', x: 52, y: 50),
          PlayerPosition(playerId: 'c', x: 64, y: 40),
        ],
        movements: [
          MovementPath(playerId: 'b', fromX: 50, fromY: 52, toX: 52, toY: 50, label: 'levanta'),
          MovementPath(playerId: 'c', fromX: 68, fromY: 42, toX: 64, toY: 40, label: 'aproxima'),
        ],
      ),
      AnimationFrame(
        timestamp: 5000,
        stepIndex: 3,
        highlightPlayerId: 'c',
        instructionText: 'Ataque na diagonal',
        ballPosition: BallPosition(x: 76, y: 24),
        highlightedZones: [
          CourtZoneHighlight(x: 70, y: 16, width: 18, height: 18, label: 'Alvo diagonal'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'a', x: 46, y: 72),
          PlayerPosition(playerId: 'b', x: 52, y: 50),
          PlayerPosition(playerId: 'c', x: 72, y: 34),
        ],
        movements: [
          MovementPath(playerId: 'c', fromX: 64, fromY: 40, toX: 72, toY: 34, label: 'ataca'),
        ],
      ),
    ],
  ),
  Drill(
    id: 'attack-timing',
    name: 'Ataque com Tempo de Aproximação',
    category: 'Ataque',
    objective: 'Treinar a coordenação entre chamada, passada de aproximação, salto e finalização.',
    difficulty: 'Avançado',
    duration: '15 min',
    isFavorite: false,
    players: [
      DrillPlayer(id: 'setter', label: 'L', role: 'Levantadora', colorHex: _teamOrange),
      DrillPlayer(id: 'hitter', label: 'H', role: 'Ponteira', colorHex: _teamBlue),
      DrillPlayer(id: 'block', label: 'B', role: 'Bloqueio', colorHex: _teamDark),
    ],
    steps: [
      'A levantadora se posiciona na zona de distribuição.',
      'A atacante inicia a aproximação sincronizada com a saída do levantamento.',
      'A bola sobe na frente do ombro de ataque.',
      'A atacante salta, ataca e faz retorno controlado ao solo.',
    ],
    tips: [
      'Use a chamada verbal antes da corrida.',
      'Mantenha o último passo mais explosivo.',
      'Ataque com o cotovelo alto e tronco alinhado.',
    ],
    commonErrors: [
      'Aproximação reta demais, sem ajuste para a bola.',
      'Salto atrasado em relação ao levantamento.',
      'Ataque com contato atrás da cabeça.',
    ],
    variations: [
      'Mudar a origem do levantamento para treinar ajuste lateral.',
      'Adicionar bloqueio passivo para leitura de direção.',
      'Alternar bolas rápidas e bolas altas.',
    ],
    animationFrames: [
      AnimationFrame(
        timestamp: 0,
        stepIndex: 0,
        highlightPlayerId: 'setter',
        instructionText: 'Organize o ponto de distribuição',
        ballPosition: BallPosition(x: 48, y: 55),
        playersPositions: [
          PlayerPosition(playerId: 'setter', x: 46, y: 54),
          PlayerPosition(playerId: 'hitter', x: 24, y: 60),
          PlayerPosition(playerId: 'block', x: 76, y: 38),
        ],
        movements: [
          MovementPath(playerId: 'hitter', fromX: 20, fromY: 68, toX: 24, toY: 60, label: 'prepara'),
        ],
      ),
      AnimationFrame(
        timestamp: 1500,
        stepIndex: 1,
        highlightPlayerId: 'hitter',
        instructionText: 'Entre na passada com ritmo',
        ballPosition: BallPosition(x: 50, y: 49),
        playersPositions: [
          PlayerPosition(playerId: 'setter', x: 48, y: 52),
          PlayerPosition(playerId: 'hitter', x: 30, y: 53),
          PlayerPosition(playerId: 'block', x: 76, y: 38),
        ],
        movements: [
          MovementPath(playerId: 'hitter', fromX: 24, fromY: 60, toX: 30, toY: 53, label: 'aproxima'),
          MovementPath(playerId: 'setter', fromX: 46, fromY: 54, toX: 48, toY: 52, label: 'ajusta'),
        ],
      ),
      AnimationFrame(
        timestamp: 3000,
        stepIndex: 2,
        highlightPlayerId: 'setter',
        instructionText: 'Levante na frente do ombro',
        ballPosition: BallPosition(x: 40, y: 40),
        highlightedZones: [
          CourtZoneHighlight(x: 34, y: 30, width: 16, height: 16, label: 'Ponto ideal'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'setter', x: 49, y: 51),
          PlayerPosition(playerId: 'hitter', x: 36, y: 46),
          PlayerPosition(playerId: 'block', x: 75, y: 37),
        ],
        movements: [
          MovementPath(playerId: 'setter', fromX: 48, fromY: 52, toX: 49, toY: 51, label: 'solta'),
          MovementPath(playerId: 'hitter', fromX: 30, fromY: 53, toX: 36, toY: 46, label: 'fecha passada'),
        ],
      ),
      AnimationFrame(
        timestamp: 4600,
        stepIndex: 3,
        highlightPlayerId: 'hitter',
        instructionText: 'Ataque com tronco firme',
        ballPosition: BallPosition(x: 82, y: 28),
        playersPositions: [
          PlayerPosition(playerId: 'setter', x: 50, y: 54),
          PlayerPosition(playerId: 'hitter', x: 42, y: 34),
          PlayerPosition(playerId: 'block', x: 74, y: 34),
        ],
        movements: [
          MovementPath(playerId: 'hitter', fromX: 36, fromY: 46, toX: 42, toY: 34, label: 'ataca'),
          MovementPath(playerId: 'block', fromX: 76, fromY: 38, toX: 74, toY: 34, label: 'fecha'),
        ],
      ),
    ],
  ),
  Drill(
    id: 'serve-targets',
    name: 'Saque com Alvos por Zona',
    category: 'Saque',
    objective: 'Melhorar precisão, repetição técnica e tomada de decisão no direcionamento do saque.',
    difficulty: 'Iniciante',
    duration: '10 min',
    isFavorite: true,
    players: [
      DrillPlayer(id: 'server', label: 'S', role: 'Sacadora', colorHex: _teamBlue),
      DrillPlayer(id: 'target1', label: '1', role: 'Alvo zona 1', colorHex: _teamOrange),
      DrillPlayer(id: 'target5', label: '5', role: 'Alvo zona 5', colorHex: _teamDark),
    ],
    steps: [
      'A sacadora alinha corpo e alvo antes do toss.',
      'O saque é direcionado para a zona 1.',
      'Na repetição seguinte, o alvo muda para a zona 5.',
      'A atleta reinicia a rotina mantendo o mesmo gesto técnico.',
    ],
    tips: [
      'Repita a mesma rotina de respiração antes do saque.',
      'Observe o contato da mão com a parte posterior da bola.',
      'Finalize o gesto apontando para a zona alvo.',
    ],
    commonErrors: [
      'Lançamento da bola muito à frente do corpo.',
      'Mudança no gesto técnico ao trocar o alvo.',
      'Contato na lateral da bola gerando saque sem controle.',
    ],
    variations: [
      'Reduzir a área do alvo com cones.',
      'Alternar saque curto e profundo.',
      'Somar pontuação por acerto consecutivo.',
    ],
    animationFrames: [
      AnimationFrame(
        timestamp: 0,
        stepIndex: 0,
        highlightPlayerId: 'server',
        instructionText: 'Defina o alvo antes do toss',
        ballPosition: BallPosition(x: 50, y: 88),
        highlightedZones: [
          CourtZoneHighlight(x: 72, y: 16, width: 16, height: 16, label: 'Zona 1'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'server', x: 50, y: 92),
          PlayerPosition(playerId: 'target1', x: 78, y: 24),
          PlayerPosition(playerId: 'target5', x: 22, y: 24),
        ],
        movements: [
          MovementPath(playerId: 'server', fromX: 50, fromY: 96, toX: 50, toY: 92, label: 'rotina'),
        ],
      ),
      AnimationFrame(
        timestamp: 1600,
        stepIndex: 1,
        highlightPlayerId: 'server',
        instructionText: 'Ataque a bola para a zona 1',
        ballPosition: BallPosition(x: 68, y: 42),
        playersPositions: [
          PlayerPosition(playerId: 'server', x: 50, y: 88),
          PlayerPosition(playerId: 'target1', x: 78, y: 24),
          PlayerPosition(playerId: 'target5', x: 22, y: 24),
        ],
        movements: [
          MovementPath(playerId: 'server', fromX: 50, fromY: 92, toX: 50, toY: 88, label: 'saque'),
        ],
      ),
      AnimationFrame(
        timestamp: 3200,
        stepIndex: 2,
        highlightPlayerId: 'server',
        instructionText: 'Troque o alvo sem mudar a técnica',
        ballPosition: BallPosition(x: 34, y: 40),
        highlightedZones: [
          CourtZoneHighlight(x: 14, y: 16, width: 16, height: 16, label: 'Zona 5'),
        ],
        playersPositions: [
          PlayerPosition(playerId: 'server', x: 50, y: 88),
          PlayerPosition(playerId: 'target1', x: 78, y: 24),
          PlayerPosition(playerId: 'target5', x: 22, y: 24),
        ],
        movements: [
          MovementPath(playerId: 'server', fromX: 50, fromY: 88, toX: 50, toY: 88, label: 'repete gesto'),
        ],
      ),
      AnimationFrame(
        timestamp: 4800,
        stepIndex: 3,
        highlightPlayerId: 'server',
        instructionText: 'Reinicie e mantenha consistência',
        ballPosition: BallPosition(x: 50, y: 88),
        playersPositions: [
          PlayerPosition(playerId: 'server', x: 50, y: 92),
          PlayerPosition(playerId: 'target1', x: 78, y: 24),
          PlayerPosition(playerId: 'target5', x: 22, y: 24),
        ],
        movements: [
          MovementPath(playerId: 'server', fromX: 50, fromY: 88, toX: 50, toY: 92, label: 'reset'),
        ],
      ),
    ],
  ),
];
