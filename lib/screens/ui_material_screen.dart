import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIMaterialScreen extends StatefulWidget {
  final String title;
  final int currentPage;
  final int totalPages;

  const UIMaterialScreen({
    super.key,
    this.title = 'Pengantar User Interface Design',
    this.currentPage = 1,
    this.totalPages = 26,
  });

  @override
  State<UIMaterialScreen> createState() => _UIMaterialScreenState();
}

class _UIMaterialScreenState extends State<UIMaterialScreen> {
  late int _currentPage;
  late PageController _pageController;

  // Theme colors
  static const Color primaryColor = Color(0xFFC0392B);
  static const Color universityRed = Color(0xFFA71930);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
    _pageController = PageController(initialPage: _currentPage - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : Colors.white,
      body: Column(
        children: [
          // Header
          _buildHeader(isDark),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Hero Section
                  _buildHeroSection(isDark),
                  // Introduction Section
                  _buildIntroductionSection(isDark),
                  // User Interface Section
                  _buildUserInterfaceSection(isDark),
                  // Importance Section
                  _buildImportanceSection(isDark),
                ],
              ),
            ),
          ),
          // Bottom Navigation
          _buildBottomNavigation(isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Title
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              // Page Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Halaman',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$_currentPage/${widget.totalPages}',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? cardDark : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern (subtle)
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // University Icon
                Icon(
                  Icons.school,
                  size: 96,
                  color: universityRed,
                ),
                const SizedBox(height: 16),
                // University Name
                Text(
                  'Universitas Telkom',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 24),
                // Course Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(
                        color: primaryColor,
                        width: 4,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Title
                      Expanded(
                        child: Text(
                          'Pengantar Desain\nAntarmuka Pengguna',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                      ),
                      // Course Code
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'VEI214',
                            style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'UI / UX Design',
                            style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroductionSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? backgroundDark : backgroundLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Dot Pattern Background
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.05 : 0.03,
              child: CustomPaint(
                painter: DotPatternPainter(),
              ),
            ),
          ),
          // Content
          Column(
            children: [
              Text(
                'Perkenalan',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 24),
              // Profile Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? Colors.grey.shade700 : Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCHXf0PR5EXiAhpReZvRZ5vcv96OE1boEVUvLUqaRhWM2JBZcvIvU_7-ZmGnBlXbks16_S3z7AiXDduczYtQBYGLGy8k1824cF43on12GE8inbHFaxUlmZCIfBKHH_I0qCyRx7nbP7uVUQkTSr9dLJKgu_MsfMla95_K2TiX4Cv0P3O8HJHpmRFma4gqKLyIHOhmSgtDYyTKNWkrBt9_KBjZZQycmvp_s-XaAXdUZBMf9TW5k2n40TrbiDY0gIzDHZqchZB11OkBk0',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: Icon(
                              Icons.person,
                              size: 48,
                              color: Colors.grey.shade500,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          icon: Icons.person,
                          content: RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Ady Purna Kurniawan',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : Colors.grey.shade900,
                                  ),
                                ),
                                const TextSpan(text: ' → ADY'),
                              ],
                            ),
                          ),
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.email,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E-mail:',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                'adypurnakurniawan@telkomuniversity.ac.id',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.school,
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bidang Keahlian:',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.grey.shade900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _buildBulletPoint('Information System', isDark),
                              _buildBulletPoint('Web Programming and Design', isDark),
                              _buildBulletPoint('Game Development', isDark),
                            ],
                          ),
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          icon: Icons.smartphone,
                          content: Text(
                            'No.HP: 085727930642 →\nSMS/Telp/Whatsapp',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                            ),
                          ),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Widget content,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildBulletPoint(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInterfaceSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? cardDark : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Title with Italic Style
          Text(
            'User Interface',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 24),
          // Content Points
          _buildContentPoint(
            isDark: isDark,
            content: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.6,
                ),
                children: [
                  const TextSpan(text: 'Antarmuka/ '),
                  TextSpan(
                    text: 'user interface',
                    style: GoogleFonts.inter(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(text: ' (UI) merupakan bagian dari komputer dan perangkat lunaknya yang dapat '),
                  TextSpan(
                    text: 'dilihat, didengar, disentuh,',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const TextSpan(text: ' dan '),
                  TextSpan(
                    text: 'diajak bicara',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const TextSpan(text: ', baik secara langsung maupun dengan proses pemahaman tertentu.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContentPoint(
            isDark: isDark,
            content: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.6,
                ),
                children: [
                  const TextSpan(text: 'UI yang baik adalah UI yang '),
                  TextSpan(
                    text: 'tidak disadari',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const TextSpan(text: ', dan UI yang memungkinkan pengguna fokus pada informasi dan task tanpa perlu mengetahui mekanisme untuk menampilkan informasi dan melakukan '),
                  TextSpan(
                    text: 'task',
                    style: GoogleFonts.inter(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(text: ' tersebut.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContentPoint(
            isDark: isDark,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Komponen utamanya:',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          '– Input',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          '– Output',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentPoint({
    required bool isDark,
    required Widget content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 8, right: 12),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildImportanceSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF7F1D1D).withOpacity(0.1) : const Color(0xFFFEF2F2),
      ),
      child: Column(
        children: [
          Text(
            'Pentingnya Desain UI yang Baik',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Warning Points
          _buildWarningPoint(
            icon: Icons.error_outline,
            isDark: isDark,
            content: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.6,
                ),
                children: [
                  const TextSpan(text: 'Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien, membingungkan, dan tidak berguna karena '),
                  TextSpan(
                    text: 'desain UI yang buruk',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildWarningPoint(
            icon: Icons.check_circle_outline,
            isDark: isDark,
            content: Text(
              'Antarmuka yang baik merupakan jendela untuk melihat kemampuan sistem serta jembatan bagi kemampuan perangkat lunak.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildWarningPoint(
            icon: Icons.warning,
            isDark: isDark,
            content: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.6,
                ),
                children: [
                  const TextSpan(text: 'Desain yang buruk akan '),
                  TextSpan(
                    text: 'membingungkan, tidak efisien,',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const TextSpan(text: ' bahkan menyebabkan '),
                  TextSpan(
                    text: 'frustasi',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFF87171) : const Color(0xFFDC2626),
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Frustration Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                width: 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Image
                SizedBox(
                  height: 192,
                  width: double.infinity,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.saturation,
                    ),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDhdoBDRGiOxEml4i0ILKtrSNxGdcsX_CoQTZGn8mACmgxHWN3sqmZVpxmSBhmtYGTVO8xjnlT0-VmM9wlXg1aotDXS0Iocx77Koj0kOGa2X27Rdzjg9fmvkZKiUtenAtsLZ0rZTjAziPyiYHFriSauRR9hxQKHp9aVLWXrc9_u0i6U_-6aTDNGJaIVdjyUWNA_MSWrGflaUoEYJ22RbPdhH_K40ZV7LeL0N4HOoAin4v6HUMKcYBS7CYq6qmCzFJ2DwryAbijn_cA',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Caption
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: isDark ? cardDark : Colors.white,
                  child: Text(
                    'Ilustrasi pengguna yang mengalami frustasi akibat UI yang buruk',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningPoint({
    required IconData icon,
    required bool isDark,
    required Widget content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        const SizedBox(width: 12),
        Expanded(child: content),
      ],
    );
  }

  Widget _buildBottomNavigation(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? cardDark : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prev Button
          GestureDetector(
            onTap: () {
              if (_currentPage > 1) {
                setState(() {
                  _currentPage--;
                });
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: _currentPage > 1 
                      ? (isDark ? Colors.grey.shade400 : Colors.grey.shade400)
                      : Colors.grey.shade300,
                ),
                const SizedBox(height: 4),
                Text(
                  'Prev',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _currentPage > 1 
                        ? (isDark ? Colors.grey.shade400 : Colors.grey.shade400)
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          // Page Indicators
          Row(
            children: List.generate(4, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0 
                      ? primaryColor 
                      : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
              );
            }),
          ),
          // Next Button
          GestureDetector(
            onTap: () {
              if (_currentPage < widget.totalPages) {
                setState(() {
                  _currentPage++;
                });
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: primaryColor,
                ),
                const SizedBox(height: 4),
                Text(
                  'Next',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Dot Pattern Background
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const radius = 1.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
