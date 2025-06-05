import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';


class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    // Draw wave pattern
    final path1 = Path();
    path1.moveTo(0, size.height * 0.6 - 40);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65 - 40,
      size.width * 0.5,
      size.height * 0.6 - 40,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.55 - 40,
      size.width,
      size.height * 0.6 - 40,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.65 - 40);
    path2.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7 - 40,
      size.width * 0.5,
      size.height * 0.65 - 40,
    );
    path2.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6 - 40,
      size.width,
      size.height * 0.65 - 40,
    );

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint);

    // Draw circles
    final circlePaint = Paint()
      ..color = Colors.white.withAlpha((0.1 * 255).toInt())
      ..style = PaintingStyle.fill;

    // Draw various sized circles for the bubble effect
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.2),
      size.width * 0.08,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.3),
      size.width * 0.05,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.15),
      size.width * 0.1,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      size.width * 0.06,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.5),
      size.width * 0.04,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background wave pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WavePatternPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 8.0),
                    child: Text(
                      'PhysioConnect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'خوش آمدید',
                      style: PersianFonts.Yekan.copyWith(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: Text('ورود', style: PersianFonts.Yekan.copyWith(color: Colors.white),),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text('ثبت نام', style: PersianFonts.Yekan.copyWith(color: Colors.black),),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}