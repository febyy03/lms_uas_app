import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final Map<String, String> _users = {
    'admin@365.com': '123456',
    'user@365.com': 'password',
  };

  static const Color primaryColor = Color(0xFFB91C1C);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color inputUnderline = Color(0xFFD1D5DB);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textDark = Color(0xFF111827);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // HEADER IMAGE
              _buildHeader(isDark, screenHeight),

              // LOGO BULAT
              _buildCircularLogo(isDark, screenHeight),

              // CONTENT
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.55 + 32),
                  _buildContent(isDark),
                  _buildWaveDecoration(isDark),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(bool isDark, double screenHeight) {
    final double headerHeight =
        screenHeight < 700 ? screenHeight * 0.52 : screenHeight * 0.58;

    return ClipPath(
      clipper: _HeaderClipper(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: headerHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/uim.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter, // 🔥 bikin gambar lebih terlihat
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: headerHeight,
            color: isDark
                ? Colors.black.withOpacity(0.30)
                : Colors.black.withOpacity(0.18),
          ),
        ],
      ),
    );
  }

  // ================= LOGO =================
  Widget _buildCircularLogo(bool isDark, double screenHeight) {
    final double headerHeight =
        screenHeight < 700 ? screenHeight * 0.52 : screenHeight * 0.58;

    final logoSize = screenHeight < 700 ? 80.0 : 96.0;
    final iconSize = screenHeight < 700 ? 40.0 : 48.0;

    return Positioned(
      top: headerHeight - (logoSize / 2),
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(
            size: Size(iconSize, iconSize),
            painter: _ULogoPainter(),
          ),
        ),
      ),
    );
  }

  // ================= CONTENT =================
  Widget _buildContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : textDark,
            ),
          ),
          const SizedBox(height: 40),
          _buildField(_nameController, 'Nama Lengkap', isDark),
          const SizedBox(height: 28),
          _buildField(_emailController, 'Email Address', isDark),
          const SizedBox(height: 28),
          _buildField(_passwordController, 'Password', isDark,
              isPassword: true),
          const SizedBox(height: 40),
          _buildLoginButton(),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Bantuan?',
              style: GoogleFonts.poppins(
                color: isDark ? const Color(0xFFF87171) : primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    bool isDark, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && _obscurePassword,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: isDark ? Colors.white : textDark,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: textGray),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: inputUnderline, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              )
            : null,
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          final email = _emailController.text.trim();
          final password = _passwordController.text.trim();
          final name = _nameController.text.trim();

          if (_users.containsKey(email) && password == '123456') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  userName: name.isNotEmpty ? name : _users[email]!,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email atau password salah')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: const Text('Log In'),
      ),
    );
  }

  Widget _buildWaveDecoration(bool isDark) {
    return CustomPaint(
      size: const Size(double.infinity, 120),
      painter: _WavePainter(isDark: isDark),
    );
  }
}

// ================= CLIPPER =================
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ================= LOGO PAINTER =================
class _ULogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.3);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.9,
      size.width * 0.8,
      size.height * 0.6,
    );
    path.lineTo(size.width * 0.8, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ================= WAVE =================
class _WavePainter extends CustomPainter {
  final bool isDark;
  _WavePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? const Color(0xFF7F1D1D).withOpacity(0.6)
          : const Color(0xFFB91C1C).withOpacity(0.8);

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
