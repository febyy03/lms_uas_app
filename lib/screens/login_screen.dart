import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Theme colors
  static const Color primaryColor = Color(0xFFB91C1C); // Dark Red
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color inputUnderline = Color(0xFFD1D5DB);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textDark = Color(0xFF111827);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: SingleChildScrollView(
        child: SizedBox(
          height: math.max(screenHeight, 884),
          child: Stack(
            children: [
              // Header with image
              _buildHeader(context, isDark),
              
              // Circular logo overlay
              _buildCircularLogo(context, isDark),
              
              // Main content
              Positioned(
                top: screenHeight * 0.35 + 40,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildContent(isDark),
              ),
              
              // Wave decoration at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildWaveDecoration(isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return ClipPath(
      clipper: _HeaderClipper(),
      child: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: screenHeight * 0.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAsHYoKJOmtG0XiV3VaF9kN6I11tA5N9VJbl9BvCmf-tm1_Ousned5sTNrf5HOp6uqo_LZ9Vd9KwTW5cdvTzcwldnCCgFN9BZf5t0B0zrQhTJet4Wyc76xqzajkF8OiWYI3fP5DH4DaKJYTSpEYFKkSHSPBcHBsIBxkbD8rf2KvI5Issp2IfufwwTWZohM4drj-c-qCs01c2vGfcnjSh7NP7HK4CE39w5k69lnMoq99oUHAXcEyLAIMs3s8J3-MGOSqtPsuZNO-tHw',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(
            width: double.infinity,
            height: screenHeight * 0.35,
            color: isDark 
                ? Colors.black.withOpacity(0.4) 
                : Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularLogo(BuildContext context, bool isDark) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Positioned(
      top: screenHeight * 0.35 - 48 - 10, // Position at bottom of header, slightly overlapping
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? backgroundDark : Colors.white,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: CustomPaint(
              size: const Size(48, 48),
              painter: _ULogoPainter(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          // Login Title
          Text(
            'Login',
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : textDark,
            ),
          ),
          const SizedBox(height: 40),
          // Email Field
          _buildUnderlineTextField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            label: 'Email 365',
            isDark: isDark,
          ),
          const SizedBox(height: 32),
          // Password Field
          _buildUnderlineTextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            label: 'Password',
            isDark: isDark,
            isPassword: true,
          ),
          const SizedBox(height: 48),
          // Login Button
          _buildLoginButton(),
          const SizedBox(height: 16),
          // Help Link
          Center(
            child: GestureDetector(
              onTap: () {
                // TODO: Handle help
              },
              child: Text(
                'Bantuan ?',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFFF87171) : primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnderlineTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required bool isDark,
    bool isPassword = false,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {});
      },
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword && _obscurePassword,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: isDark ? Colors.white : textDark,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: focusNode.hasFocus 
                ? primaryColor 
                : (isDark ? Colors.grey[400] : textGray),
          ),
          floatingLabelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.grey[600]! : inputUnderline,
              width: 2,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.only(bottom: 8),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                    color: isDark ? Colors.grey[400] : textGray,
                    size: 20,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Handle login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Text(
          'Log In',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildWaveDecoration(bool isDark) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 120),
      painter: _WavePainter(isDark: isDark),
    );
  }
}

/// Custom clipper for the header image with angled bottom
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Custom painter for the U-shaped logo
class _ULogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    // Draw the U shape
    final path = Path();
    
    // Starting point (top left)
    path.moveTo(size.width * 0.17, size.height * 0.25);
    
    // Line down to curve start
    path.lineTo(size.width * 0.17, size.height * 0.54);
    
    // Curve at bottom
    path.quadraticBezierTo(
      size.width * 0.17, size.height * 0.875,
      size.width * 0.5, size.height * 0.875,
    );
    path.quadraticBezierTo(
      size.width * 0.83, size.height * 0.875,
      size.width * 0.83, size.height * 0.54,
    );
    
    // Line up to top right
    path.lineTo(size.width * 0.83, size.height * 0.25);
    
    canvas.drawPath(path, paint);
    
    // Draw the horizontal line at the top
    canvas.drawLine(
      Offset(size.width * 0.17, size.height * 0.25),
      Offset(size.width * 0.83, size.height * 0.25),
      paint,
    );
    
    // Draw the dashed vertical line in the middle
    final dashedPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    // Draw dashes
    double startY = size.height * 0.25;
    double endY = size.height * 0.5;
    double dashHeight = 4;
    double gapHeight = 4;
    double currentY = startY;
    
    while (currentY < endY) {
      canvas.drawLine(
        Offset(size.width * 0.5, currentY),
        Offset(size.width * 0.5, math.min(currentY + dashHeight, endY)),
        dashedPaint,
      );
      currentY += dashHeight + gapHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for the wave decoration at the bottom
class _WavePainter extends CustomPainter {
  final bool isDark;
  
  _WavePainter({required this.isDark});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark 
          ? const Color(0xFF7F1D1D).withOpacity(0.6) // dark:fill-red-900 opacity-60
          : const Color(0xFFB91C1C).withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Wave path based on SVG
    path.moveTo(0, size.height * 0.5);
    
    // First curve
    path.quadraticBezierTo(
      size.width * 0.1, size.height * 0.55,
      size.width * 0.33, size.height * 0.33,
    );
    
    // Second curve
    path.quadraticBezierTo(
      size.width * 0.55, size.height * 0.1,
      size.width * 0.67, size.height * 0.45,
    );
    
    // Third curve
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.65,
      size.width, size.height * 0.3,
    );
    
    // Close the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
