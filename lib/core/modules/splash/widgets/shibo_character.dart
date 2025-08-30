import 'package:flutter/material.dart';
import 'dart:math' as math;

enum ShiboExpression {
  happy,
  excited,
  sleepy,
  focused,
  curious,
}

class ShiboCharacter extends StatefulWidget {
  final double size;
  final ShiboExpression expression;
  final bool withNote;
  final bool animate;

  const ShiboCharacter({
    Key? key,
    this.size = 100,
    this.expression = ShiboExpression.happy,
    this.withNote = false,
    this.animate = true,
  }) : super(key: key);

  @override
  State<ShiboCharacter> createState() => _ShiboCharacterState();
}

class _ShiboCharacterState extends State<ShiboCharacter>
    with TickerProviderStateMixin {
  late AnimationController _tailController;
  late AnimationController _blinkController;
  late Animation<double> _tailAnimation;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    
    if (widget.animate) {
      _initAnimations();
    }
  }

  void _initAnimations() {
    // Tail wag animation
    _tailController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _tailAnimation = Tween<double>(
      begin: -0.2,
      end: 0.2,
    ).animate(CurvedAnimation(
      parent: _tailController,
      curve: Curves.easeInOut,
    ));

    // Blink animation
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _blinkAnimation = Tween<double>(
      begin: 1.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    ));

    // Random blinks
    _scheduleBlink();
  }

  void _scheduleBlink() {
    Future.delayed(Duration(seconds: 2 + math.Random().nextInt(3)), () {
      if (mounted) {
        _blinkController.forward().then((_) {
          _blinkController.reverse();
          _scheduleBlink();
        });
      }
    });
  }

  @override
  void dispose() {
    if (widget.animate) {
      _tailController.dispose();
      _blinkController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: ShiboPainter(
          expression: widget.expression,
          withNote: widget.withNote,
          tailRotation: widget.animate ? _tailAnimation : null,
          eyeScale: widget.animate ? _blinkAnimation : null,
        ),
      ),
    );
  }
}

class ShiboPainter extends CustomPainter {
  final ShiboExpression expression;
  final bool withNote;
  final Animation<double>? tailRotation;
  final Animation<double>? eyeScale;

  ShiboPainter({
    required this.expression,
    required this.withNote,
    this.tailRotation,
    this.eyeScale,
  }) : super(repaint: tailRotation ?? eyeScale);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width / 100;

    // Shiba body (sitting position)
    _drawBody(canvas, paint, center, scale);
    
    // Tail (animated if provided)
    _drawTail(canvas, paint, center, scale);
    
    // Head
    _drawHead(canvas, paint, center, scale);
    
    // Ears
    _drawEars(canvas, paint, center, scale);
    
    // Face features
    _drawFace(canvas, paint, center, scale);
    
    // Note in mouth (if withNote is true)
    if (withNote) {
      _drawNote(canvas, paint, center, scale);
    }
  }

  void _drawBody(Canvas canvas, Paint paint, Offset center, double scale) {
    // Main body (cream color)
    paint.color = const Color(0xFFF4D2A3);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, 15 * scale),
        width: 35 * scale,
        height: 40 * scale,
      ),
      paint,
    );

    // Chest (white)
    paint.color = const Color(0xFFFFF8F0);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, 18 * scale),
        width: 25 * scale,
        height: 28 * scale,
      ),
      paint,
    );

    // Paws
    paint.color = const Color(0xFFF4D2A3);
    // Left paw
    canvas.drawCircle(
      center + Offset(-12 * scale, 32 * scale),
      6 * scale,
      paint,
    );
    // Right paw
    canvas.drawCircle(
      center + Offset(12 * scale, 32 * scale),
      6 * scale,
      paint,
    );
  }

  void _drawTail(Canvas canvas, Paint paint, Offset center, double scale) {
    canvas.save();
    
    // Tail rotation point
    final tailBase = center + Offset(18 * scale, 5 * scale);
    canvas.translate(tailBase.dx, tailBase.dy);
    
    // Apply tail wag rotation if animated
    if (tailRotation != null) {
      canvas.rotate(tailRotation!.value);
    }
    
    // Tail (curved)
    paint.color = const Color(0xFFF4D2A3);
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(8 * scale, -8 * scale, 15 * scale, -5 * scale);
    path.quadraticBezierTo(20 * scale, -2 * scale, 18 * scale, 5 * scale);
    path.quadraticBezierTo(12 * scale, 8 * scale, 5 * scale, 5 * scale);
    path.close();
    
    canvas.drawPath(path, paint);
    
    canvas.restore();
  }

  void _drawHead(Canvas canvas, Paint paint, Offset center, double scale) {
    // Main head (cream)
    paint.color = const Color(0xFFF4D2A3);
    canvas.drawCircle(
      center + Offset(0, -10 * scale),
      22 * scale,
      paint,
    );

    // Snout area (white)
    paint.color = const Color(0xFFFFF8F0);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, -5 * scale),
        width: 25 * scale,
        height: 18 * scale,
      ),
      paint,
    );
  }

  void _drawEars(Canvas canvas, Paint paint, Offset center, double scale) {
    paint.color = const Color(0xFFF4D2A3);
    
    // Left ear
    final leftEarPath = Path();
    leftEarPath.moveTo(center.dx - 15 * scale, center.dy - 25 * scale);
    leftEarPath.quadraticBezierTo(
      center.dx - 25 * scale, center.dy - 35 * scale,
      center.dx - 20 * scale, center.dy - 15 * scale,
    );
    leftEarPath.close();
    canvas.drawPath(leftEarPath, paint);

    // Right ear
    final rightEarPath = Path();
    rightEarPath.moveTo(center.dx + 15 * scale, center.dy - 25 * scale);
    rightEarPath.quadraticBezierTo(
      center.dx + 25 * scale, center.dy - 35 * scale,
      center.dx + 20 * scale, center.dy - 15 * scale,
    );
    rightEarPath.close();
    canvas.drawPath(rightEarPath, paint);

    // Ear interior (pink)
    paint.color = const Color(0xFFFFB3BA);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(-18 * scale, -22 * scale),
        width: 6 * scale,
        height: 8 * scale,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(18 * scale, -22 * scale),
        width: 6 * scale,
        height: 8 * scale,
      ),
      paint,
    );
  }

  void _drawFace(Canvas canvas, Paint paint, Offset center, double scale) {
    // Eyes
    paint.color = const Color(0xFF2D3748);
    
    double eyeScaleValue = 1.0;
    if (eyeScale != null) {
      eyeScaleValue = eyeScale!.value;
    }

    // Left eye
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(-8 * scale, -15 * scale),
        width: 4 * scale,
        height: 6 * scale * eyeScaleValue,
      ),
      paint,
    );
    
    // Right eye
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(8 * scale, -15 * scale),
        width: 4 * scale,
        height: 6 * scale * eyeScaleValue,
      ),
      paint,
    );

    // Eye highlights (white)
    paint.color = const Color(0xFFFFFFFF);
    canvas.drawCircle(
      center + Offset(-7 * scale, -16 * scale),
      1 * scale * eyeScaleValue,
      paint,
    );
    canvas.drawCircle(
      center + Offset(9 * scale, -16 * scale),
      1 * scale * eyeScaleValue,
      paint,
    );

    // Nose
    paint.color = const Color(0xFF2D3748);
    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(0, -8 * scale),
        width: 3 * scale,
        height: 2 * scale,
      ),
      paint,
    );

    // Mouth based on expression
    _drawMouth(canvas, paint, center, scale);
  }

  void _drawMouth(Canvas canvas, Paint paint, Offset center, double scale) {
    paint.color = const Color(0xFF2D3748);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.5 * scale;
    paint.strokeCap = StrokeCap.round;

    final path = Path();
    
    switch (expression) {
      case ShiboExpression.happy:
        // Happy smile
        path.moveTo(center.dx - 6 * scale, center.dy - 3 * scale);
        path.quadraticBezierTo(
          center.dx, center.dy + 2 * scale,
          center.dx + 6 * scale, center.dy - 3 * scale,
        );
        break;
      case ShiboExpression.excited:
        // Big excited smile with tongue
        path.moveTo(center.dx - 8 * scale, center.dy - 2 * scale);
        path.quadraticBezierTo(
          center.dx, center.dy + 4 * scale,
          center.dx + 8 * scale, center.dy - 2 * scale,
        );
        canvas.drawPath(path, paint);
        
        // Tongue
        paint.style = PaintingStyle.fill;
        paint.color = const Color(0xFFFF8A95);
        canvas.drawOval(
          Rect.fromCenter(
            center: center + Offset(2 * scale, 1 * scale),
            width: 4 * scale,
            height: 6 * scale,
          ),
          paint,
        );
        return;
      case ShiboExpression.sleepy:
        // Small content smile
        path.moveTo(center.dx - 4 * scale, center.dy - 2 * scale);
        path.quadraticBezierTo(
          center.dx, center.dy + 1 * scale,
          center.dx + 4 * scale, center.dy - 2 * scale,
        );
        break;
      case ShiboExpression.focused:
        // Neutral focused expression
        path.moveTo(center.dx - 3 * scale, center.dy - 1 * scale);
        path.lineTo(center.dx + 3 * scale, center.dy - 1 * scale);
        break;
      case ShiboExpression.curious:
        // Slightly open mouth
        path.moveTo(center.dx - 2 * scale, center.dy - 1 * scale);
        path.quadraticBezierTo(
          center.dx, center.dy + 1 * scale,
          center.dx + 2 * scale, center.dy - 1 * scale,
        );
        break;
    }
    
    canvas.drawPath(path, paint);
  }

  void _drawNote(Canvas canvas, Paint paint, Offset center, double scale) {
    // Note paper in mouth
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFFFFFFF8);
    
    final noteRect = Rect.fromCenter(
      center: center + Offset(15 * scale, -8 * scale),
      width: 12 * scale,
      height: 8 * scale,
    );
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(noteRect, Radius.circular(1 * scale)),
      paint,
    );
    
    // Note lines
    paint.color = const Color(0xFFE2E8F0);
    paint.strokeWidth = 0.5 * scale;
    paint.style = PaintingStyle.stroke;
    
    for (int i = 0; i < 3; i++) {
      final y = noteRect.top + (2 + i * 2) * scale;
      canvas.drawLine(
        Offset(noteRect.left + 1 * scale, y),
        Offset(noteRect.right - 1 * scale, y),
        paint,
      );
    }
    
    // Note border
    paint.color = const Color(0xFFD1D5DB);
    paint.strokeWidth = 0.5 * scale;
    canvas.drawRRect(
      RRect.fromRectAndRadius(noteRect, Radius.circular(1 * scale)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
