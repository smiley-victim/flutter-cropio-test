import 'dart:math';
import 'package:flutter/material.dart';



class ShapeExample extends StatelessWidget {
  const ShapeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Shapes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shape 1
            CustomPaint(
              size: const Size(120, 120),
              painter: CustomShapePainter(pointCount: 3, innerRadius: 0.25, cornerRadius: 6),
            ),
            const SizedBox(height: 20),
            // Shape 2
            CustomPaint(
              size: const Size(120, 120),
              painter: CustomShapePainter(pointCount: 4, innerRadius: 0.35, cornerRadius: 16),
            ),
            const SizedBox(height: 20),
            // Shape 3
            CustomPaint(
              size: const Size(120, 120),
              painter: CustomShapePainter(pointCount: 5, innerRadius: 0.75, cornerRadius: 16),
            ),
            const SizedBox(height: 20),
            // Shape 4
            CustomPaint(
              size: const Size(120, 120),
              painter: CustomShapePainter(pointCount: 8, innerRadius: 0.75, cornerRadius: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  final int pointCount;
  final double innerRadius; // Percentage of the outer radius
  final double cornerRadius;

  CustomShapePainter({
    required this.pointCount,
    required this.innerRadius,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.blue;
    final Path path = Path();

    final double outerRadius = size.width / 2;
    final double innerRadiusValue = outerRadius * innerRadius;

    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < pointCount * 2; i++) {
      double radius = (i.isEven) ? outerRadius : innerRadiusValue;
      double angle = (pi * i) / pointCount;

      Offset point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();

    // Add rounded corners
    final Path roundedPath = Path();
    canvas.drawShadow(path, Colors.black, 4, false);
    roundedPath.addPath(
      Path.combine(
        PathOperation.intersect,
        path,
        Path()..addRRect(RRect.fromRectAndRadius(path.getBounds(), Radius.circular(cornerRadius))),
      ),
      Offset.zero,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}