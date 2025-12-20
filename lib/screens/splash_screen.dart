import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();

    // Fade-in animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Bounce animation controller for loading dots
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    // Start fade animation
    _fadeController.forward();

    // Navigate to login screen after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB94B4B), // Primary reddish-brown color
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Main content - Logo and text
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Celoe Logo
                        const CeloeLogo(
                          width: 220,
                          height: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        // Subtitle
                        Text(
                          'Learning Management System',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Loading dots at the bottom
              Positioned(
                bottom: 64,
                left: 0,
                right: 0,
                child: Center(
                  child: _BouncingDots(controller: _bounceController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the Celoe logo
class CeloeLogo extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const CeloeLogo({
    super.key,
    this.width = 220,
    this.height = 80,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _CeloeLogoPainter(color: color),
    );
  }
}

class _CeloeLogoPainter extends CustomPainter {
  final Color color;

  _CeloeLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 220;
    final double scaleY = size.height / 80;

    final Paint strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8 * scaleX
      ..strokeCap = StrokeCap.round;

    final Paint thinStrokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * scaleX
      ..strokeCap = StrokeCap.round;

    final Paint accentPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * scaleX
      ..strokeCap = StrokeCap.round;

    // Letter "C" - Open circle
    _drawC(canvas, scaleX, scaleY, strokePaint);

    // Letter "e" (first) - Circle with horizontal line
    _drawE(canvas, 60 * scaleX, 40 * scaleY, scaleX, scaleY, strokePaint);

    // Letter "l" - Vertical line
    _drawL(canvas, 95 * scaleX, scaleX, scaleY, strokePaint);

    // Letter "o" - Circle with accent
    _drawO(canvas, 120 * scaleX, 40 * scaleY, scaleX, scaleY, strokePaint, thinStrokePaint);

    // Letter "e" (second) - Circle with horizontal line
    _drawE(canvas, 160 * scaleX, 40 * scaleY, scaleX, scaleY, strokePaint);

    // Decorative curved line under first 'e'
    _drawDecorativeCurve(canvas, scaleX, scaleY, thinStrokePaint);

    // Top accent line over 'o' and 'e'
    _drawTopAccent(canvas, scaleX, scaleY, accentPaint);
  }

  void _drawC(Canvas canvas, double scaleX, double scaleY, Paint paint) {
    final Path path = Path();
    // Start from upper right, draw arc counterclockwise (open on the right)
    final Rect rect = Rect.fromCircle(
      center: Offset(20 * scaleX, 40 * scaleY),
      radius: 25 * scaleX,
    );
    // Arc from about 50 degrees to 310 degrees (open on the right side)
    path.addArc(rect, -0.9, 4.5);
    canvas.drawPath(path, paint);
  }

  void _drawE(Canvas canvas, double centerX, double centerY, double scaleX,
      double scaleY, Paint paint) {
    // Circle
    final Rect rect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: 25 * scaleX,
    );
    canvas.drawArc(rect, 0, 6.28, false, paint);

    // Horizontal line through the middle
    canvas.drawLine(
      Offset(centerX - 25 * scaleX, centerY),
      Offset(centerX + 25 * scaleX, centerY),
      paint,
    );
  }

  void _drawL(Canvas canvas, double x, double scaleX, double scaleY, Paint paint) {
    canvas.drawLine(
      Offset(x, 15 * scaleY),
      Offset(x, 65 * scaleY),
      paint,
    );
  }

  void _drawO(Canvas canvas, double centerX, double centerY, double scaleX,
      double scaleY, Paint mainPaint, Paint accentPaint) {
    // Circle
    final Rect rect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: 25 * scaleX,
    );
    canvas.drawOval(rect, mainPaint);

    // Small accent on top
    final Path accentPath = Path();
    accentPath.moveTo(centerX - 10 * scaleX, 10 * scaleY);
    accentPath.quadraticBezierTo(
      centerX, 6 * scaleY,
      centerX + 10 * scaleX, 10 * scaleY,
    );
    canvas.drawPath(accentPath, accentPaint);
  }

  void _drawDecorativeCurve(Canvas canvas, double scaleX, double scaleY, Paint paint) {
    final Path path = Path();
    path.moveTo(45 * scaleX, 55 * scaleY);
    path.quadraticBezierTo(
      55 * scaleX, 50 * scaleY,
      65 * scaleX, 45 * scaleY,
    );
    path.lineTo(75 * scaleX, 45 * scaleY);
    
    Paint curvePaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * scaleX
      ..strokeCap = StrokeCap.round;
    
    canvas.drawPath(path, curvePaint);
  }

  void _drawTopAccent(Canvas canvas, double scaleX, double scaleY, Paint paint) {
    final Path path = Path();
    path.moveTo(115 * scaleX, 12 * scaleY);
    path.quadraticBezierTo(
      145 * scaleX, 4 * scaleY,
      175 * scaleX, 12 * scaleY,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Bouncing dots loading indicator
class _BouncingDots extends StatelessWidget {
  final AnimationController controller;

  const _BouncingDots({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _BouncingDot(
            controller: controller,
            delay: index * 0.2,
          ),
        );
      }),
    );
  }
}

class _BouncingDot extends StatelessWidget {
  final AnimationController controller;
  final double delay;

  const _BouncingDot({
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Calculate the bounce offset with delay
        double value = (controller.value + delay) % 1.0;
        // Create a smooth bounce effect
        double bounce = -8 * (1 - (2 * value - 1).abs());
        
        return Transform.translate(
          offset: Offset(0, bounce),
          child: child,
        );
      },
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
