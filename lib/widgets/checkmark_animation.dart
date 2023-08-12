import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CheckMarkAnimation extends ImplicitlyAnimatedWidget {
  const CheckMarkAnimation({
    Key? key,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.decelerate,
    VoidCallback? onEnd,
    this.active = false,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
        );

  final bool active;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _CheckMarkState();
}

class _CheckMarkState extends AnimatedWidgetBaseState<CheckMarkAnimation> {
  Tween<double>? progress;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final int checkState = widget.active ? 1 : 0;
    progress = visitor(
      progress,
      checkState.toDouble(),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CheckMarkPainter(
        progress: progress!.evaluate(animation),
      ),
    );
  }
}

class _CheckMarkPainter extends CustomPainter {
  _CheckMarkPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final double side = math.min(size.width, size.height);
    final double radius = side / 2;
    const double angle1 = 290;
    const double angle2 = 45;

    final math.Point<double> origin = math.Point<double>(
      radius + radius * math.sin(angle1),
      radius - radius * math.cos(angle1),
    );
    final math.Point<double> vertex = math.Point<double>(
      side * 0.3,
      side * 0.7,
    );
    final math.Point<double> terminus = math.Point<double>(
      radius + radius * math.sin(angle2),
      radius - radius * math.cos(angle2),
    );

    final ColorTween colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.green,
    );

    final Paint paint = Paint()
      ..color = colorTween.lerp(progress)!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final Path path = Path()
      ..moveTo(
        origin.x,
        origin.y,
      )
      ..addArc(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        ),
        (angle1 - 90) / 180 * math.pi,
        2 * math.pi,
      )
      ..lineTo(
        vertex.x,
        vertex.y,
      )
      ..lineTo(
        terminus.x,
        terminus.y,
      );

    final double circumference = 2 * math.pi * radius;
    final double checkLength =
        origin.distanceTo(vertex) + vertex.distanceTo(terminus);

    PathMetrics metrics = path.computeMetrics();

    for (PathMetric metric in metrics) {
      Path extract = metric.extractPath(
        circumference * progress,
        circumference + checkLength * progress,
      );
      canvas.drawPath(extract, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckMarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
