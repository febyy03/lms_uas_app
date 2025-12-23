import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_detail_screen.dart';

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
                                size: 28,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 44), // Balance back button
                              child: Text(
                                'Kelas Saya',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 2,
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                      ),
                    ],
                  ),
                ),

                // Course List
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    children: [
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFFEF3C7), // yellow-100
                        darkColor: const Color(0xFF422006), // yellow-900/20ish
                        iconContent: Stack(
                          children: [
                             Positioned.fill(
                               child: Opacity(
                                 opacity: 0.9,
                                 child: Container(color: Colors.orange.withOpacity(0.1)), // Placeholder for image
                               ),
                             ),
                             Center(
                               child: Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                 color: const Color(0xFFFACC15).withOpacity(0.3),
                                 child: Text(
                                   'UI/UX',
                                   style: GoogleFonts.poppins(
                                     fontWeight: FontWeight.bold,
                                     color: const Color(0xFF854D0E),
                                   ),
                                 ),
                               ),
                             )
                          ],
                        ),
                        semester: '2021/2',
                        title: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]',
                        progress: 0.89,
                      ),
                      const SizedBox(height: 16),
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFFEE2E2), // red-100
                        darkColor: const Color(0xFF450A0A),
                        iconContent: const Center(
                          child: Icon(Icons.security, color: Colors.grey, size: 40), // Placeholder for Garuda
                        ),
                        semester: '2021/2',
                        title: 'KEWARGANEGARAAN D4SM-41-GAB1 [BBO]. JUMAT 2',
                        progress: 0.86,
                      ),
                      const SizedBox(height: 16),
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFF9FAFB), // gray-50
                        darkColor: const Color(0xFF1F2937),
                        iconContent: Container(
                           color: Colors.grey[300], // Placeholder image
                           child: const Center(child: Icon(Icons.code, color: Colors.grey)),
                        ),
                        semester: '2021/2',
                        title: 'SISTEM OPERASI D4SM-44-02 [DDS]',
                        progress: 0.90,
                      ),
                      const SizedBox(height: 16),
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFCFFAFE), // cyan-100
                        darkColor: const Color(0xFF155E75),
                        iconContent: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF67E8F9), Color(0xFFBFDBFE)],
                            ),
                          ),
                        ),
                        semester: '2021/2',
                        title: 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA D4SM-41-GAB1 [APJ]',
                        progress: 0.90,
                      ),
                      const SizedBox(height: 16),
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFF3F4F6), // gray-100
                        darkColor: const Color(0xFF1F2937),
                        iconContent: Container(
                          color: Colors.grey[200], // Placeholder texture
                          child: const Center(child: Icon(Icons.business, color: Colors.grey)),
                        ),
                        semester: '2021/2',
                        title: 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC D4SM-41-GAB1 [ARS]',
                        progress: 0.90,
                      ),
                      const SizedBox(height: 16),
                      _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFF3B82F6), // blue-500
                        darkColor: const Color(0xFF1D4ED8),
                        iconContent: Container(
                           color: Colors.blue,
                           child: const Center(child: Icon(Icons.computer, color: Colors.white)),
                        ),
                        semester: '2021/2',
                        title: 'PEMROGRAMAN MULTIMEDIA INTERAKTIF D4SM-43-04 [TPR]',
                        progress: 0.90,
                      ),
                      const SizedBox(height: 16),
                       _buildCourseCard(
                        context,
                        isDark,
                        color: const Color(0xFFE9D5FF), // purple-200
                        darkColor: const Color(0xFF581C87),
                        iconContent: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Color(0xFFC084FC), Color(0xFFA5B4FC)],
                            ),
                          ),
                        ),
                        semester: '2021/2',
                        title: 'OLAH RAGA D3TT-44-02 [EYR]',
                        progress: 0.90,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Bottom Navbar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFFA91D23), // Primary Red
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     _BottomNavItem(icon: Icons.home, label: 'Home', isActive: false, onTap: (){
                       Navigator.of(context).popUntil((route) => route.isFirst);
                     }),
                     const _BottomNavItem(icon: Icons.school, label: 'Kelas Saya', isActive: true),
                     const _BottomNavItem(icon: Icons.notifications, label: 'Notifikasi', isActive: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    bool isDark, {
    required Color color,
    required Color darkColor,
    required Widget iconContent,
    required String semester,
    required String title,
    required double progress,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetailScreen(courseName: title)),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: isDark ? darkColor : color,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: iconContent,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  semester,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[700] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Container(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.5 * progress, // responsive width approximation
                      decoration: BoxDecoration(
                        color: const Color(0xFFA91D23),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${(progress * 100).toInt()} % Selesai',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
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

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon, 
    required this.label, 
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            color: Colors.white.withOpacity(isActive ? 1.0 : 0.7), 
            size: isActive ? 34 : 28, // Slightly larger if active
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
