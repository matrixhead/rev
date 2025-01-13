import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rev/src/utils/theme/theme_builder.dart';

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
    super.initState();
  }

  setUpAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    final params = GooglyEyesParameters.fromSeed(widget.seed,context);
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
  void didChangeDependencies() {
    setUpAnimation();
    super.didChangeDependencies();
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
    final params = GooglyEyesParameters.fromSeed(seed,context);
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

  factory GooglyEyesParameters.fromSeed(int seed,BuildContext context) {
    Random random = Random(seed);
   final faceColors =  Theme.of(context).extension<FaceColors>()!.colors;
    return GooglyEyesParameters(
        leftEyeDistance: random.nextDouble(),
        rightEyeDistance: random.nextDouble(),
        leftEyeDirection: -3.14 + random.nextDouble() * (3.14),
        rightEyeDirection: -3.14 + random.nextDouble() * (3.14),
        faceColor: faceColors[random.nextInt(faceColors.length - 1)]);
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
