import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});

  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  String selectedEmoji = 'heart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shapes Drawing App')),
      // Gradient background for screen
      body: Container(
        decoration: const BoxDecoration(
          
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 0, 0), // red
              Color.fromARGB(255, 0, 0, 0), // black
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Emoji Selector',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => selectedEmoji = 'heart'),
                    child: const Text('Heart Emoji'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => setState(() => selectedEmoji = 'party'),
                    child: const Text('Party Face Emoji'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: CustomPaint(
                  painter:
                      selectedEmoji == 'heart' ? HeartPainter() : PartyFacePainter(),
                  size: const Size(double.infinity, 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX + 160, centerY);

    final squarePaint = Paint()..color = Colors.blue;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );

    final circlePaint = Paint()..color = Colors.red;
    canvas.drawCircle(circleOffset, 30, circlePaint);

    final arcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      0,
      2.1,
      false,
      arcPaint,
    );

    final rectPaint = Paint()..color = Colors.orange;
    canvas.drawRect(
      Rect.fromCenter(center: rectOffset, width: 80, height: 40),
      rectPaint,
    );

    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);

    final ovalPaint = Paint()..color = Colors.teal;
    canvas.drawOval(
      Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [const Color.fromARGB(255, 0, 0, 0), Colors.white],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = backgroundGradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    final sunPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(Offset(centerX, centerY - 40), 40, sunPaint);

    final rayPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4);
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(
        Offset(centerX, centerY - 40),
        Offset(centerX + dx, centerY - 40 + dy),
        rayPaint,
      );
    }

    final housePaint = Paint()..color = Colors.brown;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 40), width: 80, height: 80),
      housePaint,
    );

    final roofPaint = Paint()..color = Colors.red;
    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, roofPaint);

    final doorPaint = Paint()..color = Colors.blueGrey;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 60), width: 30, height: 50),
      doorPaint,
    );

    final windowPaint = Paint()..color = Colors.blue.shade200;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX - 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX + 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final rectGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, Colors.blue],
    );
    final rect =
        Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 200, height: 60);
    canvas.drawRect(
      rect,
      Paint()..shader = rectGradient.createShader(rect),
    );

    final circlePaint = Paint()..color = Colors.green;
    final circleBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circlePaint);
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circleBorderPaint);

    final ovalPaint = Paint()..color = Colors.purple.withOpacity(0.5);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 100, height: 60),
      ovalPaint,
    );

    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);

    final arcGradient = const SweepGradient(
      center: Alignment.centerRight,
      startAngle: 0,
      endAngle: pi,
      colors: [Colors.red, Colors.yellow, Colors.green],
    );
    final arcRect =
        Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 120, height: 120);
    final arcPaint = Paint()
      ..shader = arcGradient.createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 100, height: 100),
      0,
      2.5,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    path.moveTo(centerX, centerY + 40);
    path.cubicTo(
      centerX - 60, centerY - 20,
      centerX - 40, centerY - 80,
      centerX,       centerY - 40,
    );
    path.cubicTo(
      centerX + 40, centerY - 80,
      centerX + 60, centerY - 20,
      centerX,       centerY + 40,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PartyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const faceRadius = 80.0;

    // Face
    final facePaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, faceRadius, facePaint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(center.translate(-26, -20), 9, eyePaint);
    canvas.drawCircle(center.translate(26, -20), 9, eyePaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: center.translate(0, 10), width: 90, height: 60),
      0,
      pi,
      false,
      smilePaint,
    );

    // Party Hat (triangle)
    final hatPaint = Paint()..color = Colors.blue;
    final hatPath = Path()
      ..moveTo(center.dx - 36, center.dy - 70)
      ..lineTo(center.dx + 36, center.dy - 70)
      ..lineTo(center.dx,       center.dy - 130)
      ..close();
    canvas.drawPath(hatPath, hatPaint);

    // confetti
    final colors = <Color>[
      const Color(0xFFEF5350), // red
      const Color(0xFFAB47BC), // purple
      const Color(0xFF5C6BC0), // indigo
      const Color(0xFF29B6F6), // light blue
      const Color(0xFF26A69A), // teal
      const Color(0xFFFFCA28), // amber
      const Color(0xFF66BB6A), // green
      const Color(0xFFFF8A65), // orange
    ];

    // helpers
    void dot(Offset p, double r, Color c) {
      canvas.drawCircle(p, r, Paint()..color = c);
    }

    void square(Offset p, double s, Color c) {
      final rect = Rect.fromCenter(center: p, width: s, height: s);
      canvas.save();
      canvas.translate(p.dx, p.dy);
      canvas.rotate(pi / 6); // slight tilt
      canvas.translate(-p.dx, -p.dy);
      canvas.drawRect(rect, Paint()..color = c);
      canvas.restore();
    }

    void triangle(Offset p, double s, Color c) {
      final t = Path()
        ..moveTo(p.dx, p.dy - s)
        ..lineTo(p.dx - s, p.dy + s)
        ..lineTo(p.dx + s, p.dy + s)
        ..close();
      canvas.save();
      canvas.translate(p.dx, p.dy);
      canvas.rotate(-pi / 8);
      canvas.translate(-p.dx, -p.dy);
      canvas.drawPath(t, Paint()..color = c);
      canvas.restore();
    }

    void strip(Offset p, double w, double len, Color c) {
      final paint = Paint()
        ..color = c
        ..strokeWidth = w
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(p, p.translate(len, 0), paint);
    }

    // Positions around the face
    final points = <Offset>[
      center.translate(-60, -60),
      center.translate(58, -44),
      center.translate(0, -100),
      center.translate(30, -85),
      center.translate(-25, -95),
      center.translate(-80, -10),
      center.translate(85, -10),
      center.translate(-70, 20),
      center.translate(70, 30),
      center.translate(-40, -20),
      center.translate(45, -65),
      center.translate(10, -75),
    ];

    // Draw a mix of shapes
    for (int i = 0; i < points.length; i++) {
      final c = colors[i % colors.length];
      switch (i % 4) {
        case 0:
          dot(points[i], 5, c);
          break;
        case 1:
          square(points[i], 8, c);
          break;
        case 2:
          triangle(points[i], 5, c);
          break;
        case 3:
          strip(points[i], 3, 12, c);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}