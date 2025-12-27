import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MateriScreen extends StatefulWidget {
  final String title;

  const MateriScreen({
    super.key, 
    this.title = 'Konsep User Interface Design', // Default title from the design
  });

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  int _selectedTabIndex = 0; // 0: Lampiran Materi, 1: Tugas dan Kuis

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Custom Colors from Tailwind config
    final colorPrimary = const Color(0xFF10B981);
    final colorBgLight = const Color(0xFFF9FAFB);
    final colorBgDark = const Color(0xFF111827);
    final colorSurfaceLight = const Color(0xFFFFFFFF);
    final colorSurfaceDark = const Color(0xFF1F2937);
    final colorTextPrimaryLight = const Color(0xFF111827);
    final colorTextPrimaryDark = const Color(0xFFF9FAFB);


    return Scaffold(
      backgroundColor: isDark ? colorBgDark : colorBgLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Modal Handle (matches the design div w-16 h-1.5)
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 64,
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB), // gray-700 : gray-200
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? colorTextPrimaryDark : colorTextPrimaryLight,
                  height: 1.25, // leading-tight
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Description Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual dan perceptual design interaction akan memberikan gambaran bagaimana bentuk dari Interaction.',
                          style: GoogleFonts.inter(
                            fontSize: 14, 
                            height: 1.625, // leading-relaxed
                            color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563), // gray-300 : gray-600
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tab Bar
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1F2937).withValues(alpha: 0.5) : const Color(0xFFF9FAFB),
                      border: Border(
                        bottom: BorderSide(
                          color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB), // gray-700 : gray-200
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedTabIndex = 0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedTabIndex == 0 
                                      ? (isDark ? Colors.white : Colors.black)
                                      : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Lampiran Materi',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedTabIndex == 0
                                    ? (isDark ? Colors.white : const Color(0xFF111827))
                                    : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedTabIndex = 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _selectedTabIndex == 1
                                      ? (isDark ? Colors.white : Colors.black)
                                      : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Tugas dan Kuis',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedTabIndex == 1
                                    ? (isDark ? Colors.white : const Color(0xFF111827))
                                    : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _selectedTabIndex == 0 
                      ? _buildMateriContent(isDark, colorSurfaceLight, colorSurfaceDark, colorPrimary) 
                      : _buildTugasContent(isDark),
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriContent(bool isDark, Color surfLight, Color surfDark, Color primary) {
    return Column(
      children: [
        _buildMediaItem(
          title: "Zoom Meeting Syncronous",
          icon: Icons.attach_file,
          isCompleted: true, 
          isDark: isDark,
          isRotated: true,
          surfaceColor: isDark ? surfDark : surfLight,
          primaryColor: primary,
        ),
        _buildMediaItem(
          title: "Elemen-elemen Antarmuka Pengguna",
          icon: Icons.description_outlined,
          isCompleted: true, 
          isDark: isDark,
          surfaceColor: isDark ? surfDark : surfLight,
          primaryColor: primary,
        ),
        _buildMediaItem(
          title: "UID Guidelines and Principles",
          icon: Icons.description_outlined,
          isCompleted: true, 
          isDark: isDark,
          surfaceColor: isDark ? surfDark : surfLight,
          primaryColor: primary,
        ),
        _buildMediaItem(
          title: "User Profile",
          icon: Icons.description_outlined,
          isCompleted: true,
          isDark: isDark,
          surfaceColor: isDark ? surfDark : surfLight,
          primaryColor: primary,
        ),
        _buildMediaItem(
          title: "Principles of User Interface DesignURL",
          icon: Icons.attach_file,
          isCompleted: true,
          isDark: isDark,
          isRotated: true,
          surfaceColor: isDark ? surfDark : surfLight,
          primaryColor: primary,
        ),
      ],
    );
  }

  Widget _buildTugasContent(bool isDark) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      children: [
        _buildTaskItem(
          isDark: isDark,
          icon: Icons.quiz_outlined,
          title: "Quiz Review 01",
          isCompleted: true,
          description: "Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.",
          deadline: "Kerjakan sebelum hari Jum'at, 26 Februari 2021 jam 23:59 WIB.",
        ),
        const SizedBox(height: 20),
        _buildTaskItem(
          isDark: isDark,
          icon: Icons.assignment_outlined,
          title: "Tugas 01 - UID Android Mobile Game",
          isCompleted: false,
          description: "1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi ............",
        ),
      ],
    );
  }

  Widget _buildTaskItem({
    required bool isDark,
    required IconData icon,
    required String title,
    required bool isCompleted,
    required String description,
    String? deadline,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : Colors.white,
        borderRadius: BorderRadius.circular(24), // rounded-3xl approx 24
        border: Border.all(
          color: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6), // gray-700 : gray-100
        ),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Icon Area
            Container(
              width: 64,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF27272A) : Colors.white,
                border: Border(
                  right: BorderSide(
                    color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB), // gray-200
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 30, // text-3xl approx 30
                  color: isDark ? Colors.white : const Color(0xFF111827),
                ),
              ),
            ),
            
            // Content Area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                           color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB), // gray-200
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : const Color(0xFF111827),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.check_circle_rounded,
                          size: 20, // text-xl approx 20
                          color: isCompleted 
                            ? const Color(0xFF22C55E) // green-500
                            : (isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB)), // gray-600 : gray-300
                        ),
                      ],
                    ),
                  ),
                  
                  // Description & Deadline
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: GoogleFonts.inter(
                            fontSize: 12, // text-xs
                            height: 1.625, // leading-relaxed
                            color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563), // gray-300 : gray-600
                          ),
                        ),
                        if (deadline != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            deadline,
                            style: GoogleFonts.inter(
                              fontSize: 12, // text-xs
                              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280), // gray-400 : gray-500
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaItem({
    required String title,
    required IconData icon,
    required bool isCompleted,
    required bool isDark,
    required Color surfaceColor,
    required Color primaryColor,
    bool isRotated = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16), // 'rounded-2xl'
        border: Border.all(
          color: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6), // gray-700 : gray-100
        ),
        boxShadow: [
          // shadow-card
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF374151) : const Color(0xFFF9FAFB), // gray-700 : gray-50
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isRotated
                          ? Transform.rotate(
                              angle: 0.785398, // 45 degrees in radians
                              child: Icon(icon, color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151), size: 24),
                            )
                          : Icon(icon, color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151), size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
