import 'package:flutter/material.dart';
import 'dart:math' as math;

class PawPrintsPainter extends CustomPainter {
  final double animationValue;
  
  PawPrintsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF5E6D3).withOpacity(0.3) // Cream with transparency
      ..style = PaintingStyle.fill;

    // Define paw print positions (path across screen)
    final pawPositions = [
      Offset(size.width * 0.15, size.height * 0.25),
      Offset(size.width * 0.35, size.height * 0.35),
      Offset(size.width * 0.55, size.height * 0.20),
      Offset(size.width * 0.75, size.height * 0.30),
      Offset(size.width * 0.25, size.height * 0.65),
      Offset(size.width * 0.65, size.height * 0.70),
      Offset(size.width * 0.85, size.height * 0.75),
    ];

    // Calculate how many paws to draw based on animation progress
    final totalPaws = pawPositions.length;
    final currentPawIndex = (animationValue * totalPaws).floor();
    
    for (int i = 0; i <= currentPawIndex && i < totalPaws; i++) {
      // Calculate individual paw animation progress
      double pawProgress = 1.0;
      if (i == currentPawIndex) {
        pawProgress = (animationValue * totalPaws) - i;
      }
      
      _drawPawPrint(canvas, pawPositions[i], paint, pawProgress, i);
    }
  }

  void _drawPawPrint(Canvas canvas, Offset position, Paint paint, double progress, int index) {
    canvas.save();
    canvas.translate(position.dx, position.dy);
    
    // Rotate each paw slightly for natural variation
    final rotation = (index * 0.3) + math.sin(index * 0.5) * 0.2;
    canvas.rotate(rotation);
    
    // Scale based on progress for tracing effect
    final scale = 8.0 * progress; // Base size 8
    canvas.scale(scale);
    
    // Adjust opacity based on progress
    paint.color = Color(0xFFF5E6D3).withOpacity(0.2 + (0.3 * progress));
    
    // Draw paw pad (main part)
    canvas.drawOval(
      const Rect.fromLTRB(-2, -1.5, 2, 1.5),
      paint,
    );
    
    // Draw four toe pads
    _drawToePad(canvas, paint, const Offset(-1.2, -2.2), progress);
    _drawToePad(canvas, paint, const Offset(-0.4, -2.5), progress);
    _drawToePad(canvas, paint, const Offset(0.4, -2.5), progress);
    _drawToePad(canvas, paint, const Offset(1.2, -2.2), progress);
    
    canvas.restore();
  }

  void _drawToePad(Canvas canvas, Paint paint, Offset offset, double progress) {
    // Slightly delay toe pad appearance for more natural tracing
    final toeProgress = math.max(0.0, (progress - 0.3) * 1.43);
    if (toeProgress <= 0) return;
    
    paint.color = Color(0xFFF5E6D3).withOpacity(0.15 + (0.25 * toeProgress));
    
    canvas.drawOval(
      Rect.fromCenter(
        center: offset,
        width: 0.8 * toeProgress,
        height: 1.0 * toeProgress,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant PawPrintsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
