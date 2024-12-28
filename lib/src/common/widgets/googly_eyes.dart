import 'dart:math';

import 'package:flutter/material.dart';

class GooglyEyesAnimated extends StatefulWidget {
  final int seed;
  final double size;

  const GooglyEyesAnimated({super.key, required this.seed, required this.size});

  @override
  GooglyEyesAnimatedState createState() => GooglyEyesAnimatedState();
}

class GooglyEyesAnimatedState extends State<GooglyEyesAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _leftEyeDistanceAnimation;
  Animation<double>? _leftEyeDirectionAnimation;
  Animation<double>? _rightEyeDistanceAnimation;
  Animation<double>? _rightEyeDirectionAnimation;
  Animation<Color?>? _faceColorAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    setUpAnimation();
    super.initState();
  }

  setUpAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    final params = GooglyEyesParameters.fromSeed(widget.seed);
    // Not entirely sure if old tickers will leak
    _leftEyeDistanceAnimation = Tween<double>(
            begin: _leftEyeDistanceAnimation?.value ?? 0,
            end: params.leftEyeDistance)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _leftEyeDirectionAnimation = Tween<double>(
            begin: _leftEyeDirectionAnimation?.value ?? 0,
            end: params.leftEyeDirection)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _rightEyeDistanceAnimation = Tween<double>(
            begin: _rightEyeDistanceAnimation?.value ?? 0,
            end: params.rightEyeDistance)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _rightEyeDirectionAnimation = Tween<double>(
            begin: _rightEyeDirectionAnimation?.value ?? 0,
            end: params.rightEyeDirection)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _faceColorAnimation = ColorTween(
            begin: _faceColorAnimation?.value ?? Colors.black,
            end: params.faceColor)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.reset();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant GooglyEyesAnimated oldWidget) {
    setUpAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GooglyEyesWidget(
            leftEyeDirection: _leftEyeDirectionAnimation!.value,
            leftEyeDistance: _leftEyeDistanceAnimation!.value,
            rightEyeDirection: _rightEyeDirectionAnimation!.value,
            rightEyeDistance: _rightEyeDistanceAnimation!.value,
            faceColor: _faceColorAnimation!.value!,
            size: widget.size,
          );
        });
  }
}

class GooglyEyes extends StatelessWidget {
  final int seed;
  final double size;
  const GooglyEyes({super.key, required this.seed, required this.size});

  @override
  Widget build(BuildContext context) {
    final params = GooglyEyesParameters.fromSeed(seed);
    return GooglyEyesWidget(
      leftEyeDirection: params.leftEyeDirection,
      leftEyeDistance: params.leftEyeDistance,
      rightEyeDirection: params.rightEyeDirection,
      rightEyeDistance: params.rightEyeDistance,
      faceColor: params.faceColor,
      size: size,
    );
  }
}

class GooglyEyesParameters {
  final double leftEyeDirection;
  final double leftEyeDistance;
  final double rightEyeDirection;
  final double rightEyeDistance;
  final Color faceColor;

  const GooglyEyesParameters({
    required this.leftEyeDirection,
    required this.leftEyeDistance,
    required this.rightEyeDirection,
    required this.rightEyeDistance,
    required this.faceColor,
  });

  static final List<Color> _faceColors = [
    const Color(0xFFE63946), // Rose Red
    const Color(0xFFF4A261), // Coral
    const Color(0xFF2A9D8F), // Teal
    const Color(0xFFE76F51), // Burnt Orange
    const Color(0xFFF94144), // Red Salsa
    const Color(0xFF264653), // Deep Teal
    const Color(0xFFB5838D), // Dusty Rose
    const Color(0xFF2B2D42), // Charcoal
    const Color(0xFFFF6F61), // Living Coral
    const Color(0xFFFFC300), // Bright Yellow
    const Color(0xFFFF5733), // Fiery Red
    const Color(0xFFC70039), // Crimson
    const Color(0xFF900C3F), // Deep Magenta
    const Color(0xFF581845), // Plum
    const Color(0xFF4CC9F0), // Sky Blue
    const Color(0xFF4361EE), // Cobalt Blue
    const Color(0xFF3A0CA3), // Indigo
    const Color(0xFF7209B7), // Purple
    const Color(0xFFB5179E), // Fuchsia
    const Color(0xFFD4AF37), // Gold
    const Color(0xFFCD7F32), // Bronze
    const Color(0xFF6A5ACD), // Slate Blue
  ];

  factory GooglyEyesParameters.fromSeed(int seed) {
    Random random = Random(seed);
    return GooglyEyesParameters(
        leftEyeDistance: random.nextDouble(),
        rightEyeDistance: random.nextDouble(),
        leftEyeDirection: -3.14 + random.nextDouble() * (3.14),
        rightEyeDirection: -3.14 + random.nextDouble() * (3.14),
        faceColor: _faceColors[random.nextInt(_faceColors.length - 1)]);
  }
}

class GooglyEyesWidget extends StatelessWidget {
  const GooglyEyesWidget({
    super.key,
    required this.leftEyeDirection,
    required this.leftEyeDistance,
    required this.rightEyeDirection,
    required this.rightEyeDistance,
    required this.faceColor,
    required this.size,
  });
  final double leftEyeDirection;
  final double leftEyeDistance;
  final double rightEyeDirection;
  final double rightEyeDistance;
  final Color faceColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: GooglyEyesPainter(
          leftEyeDirection: leftEyeDirection,
          leftEyeDistance: leftEyeDistance,
          rightEyeDirection: rightEyeDirection,
          rightEyeDistance: rightEyeDistance,
          faceColor: faceColor),
    );
  }
}

class GooglyEyesPainter extends CustomPainter {
  /// value between 0 and 1
  final double leftEyeDistance;
  final double rightEyeDistance;

  /// value between -pi and pi
  final double leftEyeDirection;
  final double rightEyeDirection;

  final Color faceColor;
  GooglyEyesPainter({
    required this.leftEyeDistance,
    required this.rightEyeDistance,
    required this.leftEyeDirection,
    required this.rightEyeDirection,
    required this.faceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Face parameters
    final paint = Paint()..style = PaintingStyle.fill;

    final faceRadius = size.width / 2;

    final faceCenter = Offset(size.width * 0.5, size.height * 0.5);

    paint.color = faceColor;

    // Draw face
    canvas.drawCircle(faceCenter, faceRadius, paint);

    final eyeRadius = size.height * 0.25;

    // Left eye parameters
    final leftEyeCenter = Offset(size.width * 0.3, size.height * 0.3);

    // Right eye parameters
    final rightEyeCenter = Offset(size.width * 0.7, size.height * 0.3);

    // Draw the white part of the eyes
    paint.color = Colors.white;
    canvas.drawCircle(leftEyeCenter, eyeRadius, paint);
    canvas.drawCircle(rightEyeCenter, eyeRadius, paint);

    final maxDistance = eyeRadius * 0.5;

    // Left pupil parameters
    final leftPupil = leftEyeCenter +
        Offset(cos(leftEyeDirection), sin(leftEyeDirection)) *
            (maxDistance * leftEyeDistance);
    // Right pupil parameters
    final rightPupil = rightEyeCenter +
        Offset(cos(rightEyeDirection), sin(rightEyeDirection)) *
            (maxDistance * rightEyeDistance);

    // Draw pupils
    paint.color = Colors.black;
    canvas.drawCircle(leftPupil, eyeRadius * 0.5, paint);
    canvas.drawCircle(rightPupil, eyeRadius * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant GooglyEyesPainter oldDelegate) =>
      oldDelegate.leftEyeDirection != leftEyeDirection ||
      oldDelegate.rightEyeDirection != rightEyeDirection ||
      oldDelegate.leftEyeDistance != leftEyeDistance ||
      oldDelegate.rightEyeDistance != rightEyeDistance ||
      oldDelegate.faceColor != faceColor;
}
