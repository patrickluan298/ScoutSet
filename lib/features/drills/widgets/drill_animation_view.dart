import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/app_card.dart';
import '../models/drill.dart';

class DrillAnimationController {
  VoidCallback? restart;
  VoidCallback? togglePlayPause;
  void Function(int stepIndex)? jumpToStep;
}

class DrillAnimationView extends StatefulWidget {
  const DrillAnimationView({
    required this.drill,
    super.key,
    this.onStepChanged,
    this.controller,
  });

  final Drill drill;
  final ValueChanged<int>? onStepChanged;
  final DrillAnimationController? controller;

  @override
  State<DrillAnimationView> createState() => _DrillAnimationViewState();
}

class _DrillAnimationViewState extends State<DrillAnimationView> {
  static const List<double> _speedOptions = [0.75, 1.0, 1.5];
  static const Duration _tick = Duration(milliseconds: 40);
  static const Duration _overlayDuration = Duration(milliseconds: 1200);
  static const int _teamOrange = 0xFFF5BE00;

  Timer? _timer;
  Timer? _overlayTimer;
  int _elapsedMs = 0;
  bool _isPlaying = true;
  bool _showInstruction = false;
  double _speed = 1.0;
  int _activeStepIndex = 0;
  int _lastFrameTimestamp = -1;

  List<AnimationFrame> get _frames => widget.drill.animationFrames;

  bool get _hasFrames => _frames.isNotEmpty;

  int get _totalDuration => _hasFrames ? _frames.last.timestamp : 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.jumpToStep = _jumpToExactStep;
    widget.controller?.restart = _restart;
    widget.controller?.togglePlayPause = _togglePlayPause;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStepChanged?.call(_activeStepIndex);
    });

    if (_hasFrames) {
      _syncActiveStep();
      _refreshInstructionVisibility();
      _startTimer();
    } else {
      _isPlaying = false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _overlayTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (!_hasFrames || !_isPlaying || _totalDuration == 0) {
      return;
    }

    _timer = Timer.periodic(_tick, (_) {
      final increment = (_tick.inMilliseconds * _speed).round();
      final nextElapsed = math.min(_elapsedMs + increment, _totalDuration);

      if (!mounted) {
        return;
      }

      setState(() {
        _elapsedMs = nextElapsed;
        _syncActiveStep();
        _refreshInstructionVisibility();
        if (_elapsedMs >= _totalDuration) {
          _isPlaying = false;
          _timer?.cancel();
        }
      });
    });
  }

  void _syncActiveStep() {
    if (!_hasFrames) {
      return;
    }

    final stepIndex = _currentFrame.stepIndex;
    if (stepIndex != _activeStepIndex) {
      _activeStepIndex = stepIndex;
      widget.onStepChanged?.call(stepIndex);
    }
  }

  void _refreshInstructionVisibility() {
    if (!_hasFrames) {
      return;
    }

    final currentTimestamp = _currentFrame.timestamp;
    if (currentTimestamp == _lastFrameTimestamp) {
      return;
    }

    _lastFrameTimestamp = currentTimestamp;
    _overlayTimer?.cancel();
    final hasInstruction = (_currentFrame.instructionText ?? '').isNotEmpty;
    _showInstruction = hasInstruction;

    if (hasInstruction) {
      _overlayTimer = Timer(_overlayDuration, () {
        if (!mounted) {
          return;
        }
        setState(() {
          _showInstruction = false;
        });
      });
    }
  }

  AnimationFrame get _currentFrame {
    if (!_hasFrames) {
      return const AnimationFrame(
        timestamp: 0,
        playersPositions: [],
        movements: [],
        stepIndex: 0,
      );
    }

    for (var index = _frames.length - 1; index >= 0; index--) {
      if (_frames[index].timestamp <= _elapsedMs) {
        return _frames[index];
      }
    }

    return _frames.first;
  }

  AnimationFrame get _nextFrame {
    if (!_hasFrames) {
      return _currentFrame;
    }

    final currentIndex = _frames.indexOf(_currentFrame);
    if (currentIndex < 0 || currentIndex == _frames.length - 1) {
      return _currentFrame;
    }

    return _frames[currentIndex + 1];
  }

  double get _segmentProgress {
    if (!_hasFrames) {
      return 0;
    }

    final current = _currentFrame;
    final next = _nextFrame;
    final delta = next.timestamp - current.timestamp;
    if (delta <= 0) {
      return 0;
    }

    return ((_elapsedMs - current.timestamp) / delta).clamp(0.0, 1.0);
  }

  List<PlayerPosition> get _interpolatedPositions {
    if (!_hasFrames) {
      return const [];
    }

    final currentPositions = {
      for (final item in _currentFrame.playersPositions) item.playerId: item,
    };
    final nextPositions = {
      for (final item in _nextFrame.playersPositions) item.playerId: item,
    };

    return widget.drill.players.map((player) {
      final current = currentPositions[player.id];
      final next = nextPositions[player.id] ?? current;
      if (current == null) {
        return next!;
      }

      if (next == null) {
        return current;
      }

      return PlayerPosition(
        playerId: player.id,
        x: _lerpDouble(current.x, next.x, _segmentProgress),
        y: _lerpDouble(current.y, next.y, _segmentProgress),
      );
    }).toList();
  }

  BallPosition? get _interpolatedBallPosition {
    if (!_hasFrames) {
      return null;
    }

    final current = _currentFrame.ballPosition;
    final next = _nextFrame.ballPosition ?? current;
    if (current == null || next == null) {
      return current;
    }

    return BallPosition(
      x: _lerpDouble(current.x, next.x, _segmentProgress),
      y: _lerpDouble(current.y, next.y, _segmentProgress),
    );
  }

  void _togglePlayPause() {
    if (!_hasFrames) {
      return;
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
    _startTimer();
  }

  void _restart() {
    if (!_hasFrames) {
      return;
    }

    setState(() {
      _elapsedMs = 0;
      _activeStepIndex = 0;
      _isPlaying = true;
      _lastFrameTimestamp = -1;
    });
    widget.onStepChanged?.call(0);
    _refreshInstructionVisibility();
    _startTimer();
  }

  void _jumpToStep(int direction) {
    _jumpToExactStep(_activeStepIndex + direction);
  }

  void _jumpToExactStep(int stepIndex) {
    if (!_hasFrames) {
      return;
    }

    final targetStep = stepIndex.clamp(0, widget.drill.steps.length - 1);
    final targetFrame = _frames.firstWhere(
      (frame) => frame.stepIndex == targetStep,
      orElse: () => _frames.first,
    );

    setState(() {
      _elapsedMs = targetFrame.timestamp;
      _activeStepIndex = targetStep;
      _lastFrameTimestamp = -1;
    });
    widget.onStepChanged?.call(targetStep);
    _refreshInstructionVisibility();
  }

  void _setSpeed(double value) {
    setState(() {
      _speed = value;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasFrames) {
      return AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Execucao animada do drill',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.lightGrayColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Este drill ainda não possui frames de animação suficientes para exibição visual.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      );
    }

    final currentFrame = _currentFrame;
    final progress = _totalDuration == 0 ? 0.0 : _elapsedMs / _totalDuration;

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Execucao animada do drill',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 10 / 18,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                return Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _CourtPainter(
                          movements: currentFrame.movements,
                          highlightedZones: currentFrame.highlightedZones,
                          playerLookup: {
                            for (final player in widget.drill.players) player.id: player,
                          },
                        ),
                      ),
                    ),
                    for (final position in _interpolatedPositions)
                      _AnimatedPlayerMarker(
                        player: widget.drill.players.firstWhere(
                          (item) => item.id == position.playerId,
                        ),
                        position: position,
                        isHighlighted: currentFrame.highlightPlayerId == position.playerId,
                        width: width,
                        height: height,
                        teamOrange: _teamOrange,
                      ),
                    if (_interpolatedBallPosition != null)
                      Positioned(
                        left: (_interpolatedBallPosition!.x / 100) * width - 7,
                        top: (_interpolatedBallPosition!.y / 100) * height - 7,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22081426),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_showInstruction && (currentFrame.instructionText ?? '').isNotEmpty)
                      Positioned(
                        top: 12,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            currentFrame.instructionText!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
            backgroundColor: AppTheme.lightGrayColor,
            color: AppTheme.secondaryBlueColor,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton.filled(
                onPressed: () => _jumpToStep(-1),
                icon: const Icon(Icons.skip_previous_rounded),
                tooltip: 'Etapa anterior',
              ),
              IconButton.filled(
                onPressed: _togglePlayPause,
                icon: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
                tooltip: _isPlaying ? 'Pausar' : 'Reproduzir',
              ),
              IconButton.filledTonal(
                onPressed: _restart,
                icon: const Icon(Icons.replay_rounded),
                tooltip: 'Reiniciar',
              ),
              IconButton.filled(
                onPressed: () => _jumpToStep(1),
                icon: const Icon(Icons.skip_next_rounded),
                tooltip: 'Proxima etapa',
              ),
              for (final speed in _speedOptions)
                ChoiceChip(
                  label: Text(
                    '${speed.toStringAsFixed(speed == 1.0 ? 0 : 2).replaceAll('.00', '')}x',
                  ),
                  selected: _speed == speed,
                  onSelected: (_) => _setSpeed(speed),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedPlayerMarker extends StatelessWidget {
  const _AnimatedPlayerMarker({
    required this.player,
    required this.position,
    required this.isHighlighted,
    required this.width,
    required this.height,
    required this.teamOrange,
  });

  final DrillPlayer player;
  final PlayerPosition position;
  final bool isHighlighted;
  final double width;
  final double height;
  final int teamOrange;

  @override
  Widget build(BuildContext context) {
    final left = (position.x / 100) * width - 18;
    final top = (position.y / 100) * height - 18;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 120),
      curve: Curves.linear,
      left: left,
      top: top,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isHighlighted ? 40 : 36,
            height: isHighlighted ? 40 : 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(player.colorHex),
              shape: BoxShape.circle,
              border: Border.all(
                color: isHighlighted ? Colors.white : const Color(0xB3FFFFFF),
                width: isHighlighted ? 3 : 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26081426),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              player.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: player.colorHex == teamOrange
                        ? AppTheme.primaryColor
                        : Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              player.role,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourtPainter extends CustomPainter {
  const _CourtPainter({
    required this.movements,
    required this.highlightedZones,
    required this.playerLookup,
  });

  final List<MovementPath> movements;
  final List<CourtZoneHighlight> highlightedZones;
  final Map<String, DrillPlayer> playerLookup;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF1C8F5F), Color(0xFF15734D)],
      ).createShader(Offset.zero & size);

    final court = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(24),
    );
    canvas.drawRRect(court, background);

    for (final zone in highlightedZones) {
      final zoneRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (zone.x / 100) * size.width,
          (zone.y / 100) * size.height,
          (zone.width / 100) * size.width,
          (zone.height / 100) * size.height,
        ),
        const Radius.circular(12),
      );
      final zonePaint = Paint()..color = const Color(0x33F5BE00);
      canvas.drawRRect(zoneRect, zonePaint);
    }

    final linePaint = Paint()
      ..color = const Color(0xE6FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(court.deflate(8), linePaint);
    canvas.drawLine(
      Offset(8, size.height / 2),
      Offset(size.width - 8, size.height / 2),
      linePaint,
    );
    canvas.drawLine(
      Offset(8, size.height * 0.33),
      Offset(size.width - 8, size.height * 0.33),
      linePaint,
    );
    canvas.drawLine(
      Offset(8, size.height * 0.66),
      Offset(size.width - 8, size.height * 0.66),
      linePaint,
    );

    final netPaint = Paint()
      ..color = const Color(0xFFF5BE00)
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      netPaint,
    );

    for (final movement in movements) {
      final color = Color(playerLookup[movement.playerId]?.colorHex ?? 0xFF0F58B5);
      final start = Offset(
        (movement.fromX / 100) * size.width,
        (movement.fromY / 100) * size.height,
      );
      final end = Offset(
        (movement.toX / 100) * size.width,
        (movement.toY / 100) * size.height,
      );
      _drawArrow(canvas, start, end, color);
    }

    for (final zone in highlightedZones) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: zone.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: (zone.width / 100) * size.width);

      textPainter.paint(
        canvas,
        Offset(
          (zone.x / 100) * size.width + 6,
          (zone.y / 100) * size.height + 6,
        ),
      );
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Color color) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);

    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
    const arrowSize = 10.0;
    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - arrowSize * math.cos(angle - math.pi / 6),
        end.dy - arrowSize * math.sin(angle - math.pi / 6),
      )
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - arrowSize * math.cos(angle + math.pi / 6),
        end.dy - arrowSize * math.sin(angle + math.pi / 6),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CourtPainter oldDelegate) {
    return oldDelegate.movements != movements ||
        oldDelegate.highlightedZones != highlightedZones;
  }
}

double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
