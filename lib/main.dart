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


class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;


    path.moveTo(centerX, centerY + 40);
    path.cubicTo(
      centerX - 60 , centerY - 20  ,
      centerX - 40 , centerY - 80,
      centerX, centerY - 40,
    );
    path.cubicTo(
      centerX + 40 , centerY - 80 ,
      centerX + 60 , centerY - 20 ,
      centerX, centerY + 40 ,
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