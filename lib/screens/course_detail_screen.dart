import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseName;
  
  const CourseDetailScreen({
    super.key, 
    this.courseName = 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]',
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  int _selectedTab = 0; // 0: Materi, 1: Tugas

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFFB94646);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      body: Stack(
        children: [
          Column(
            children: [
              // Custom Header
              Container(
                color: primaryColor,
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(20),
                          child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.courseName,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Tab Bar
              Container(
                color: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1F2937) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildTabItem(
                        index: 0,
                        title: 'Materi',
                        isActive: _selectedTab == 0,
                        isDark: isDark,
                      ),
                      _buildTabItem(
                        index: 1,
                        title: 'Tugas Dan Kuis',
                        isActive: _selectedTab == 1,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
              // Main Content
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  children: [
                    _buildModuleCard(
                      meeting: 'Pertemuan 1',
                      title: '01 - Pengantar User Interface Design',
                      description: '3 URLs, 2 Files, 3 Interactive Content',
                      isDone: false,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildModuleCard(
                      meeting: 'Pertemuan 2',
                      title: '02 - Konsep User Interface Design',
                      description: '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
                      isDone: true,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildModuleCard(
                      meeting: 'Pertemuan 3',
                      title: '03 - Interaksi pada User Interface Design',
                      description: '3 URLs, 2 Files, 3 Interactive Content',
                      isDone: true,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildModuleCard(
                      meeting: 'Pertemuan 4',
                      title: '04 - Ethnographic Observation',
                      description: '3 URLs, 2 Files, 3 Interactive Content',
                      isDone: true,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                     _buildModuleCard(
                      meeting: 'Pertemuan 5',
                      title: '05 - UID Testing',
                      description: '3 URLs, 2 Files, 3 Interactive Content',
                      isDone: true,
                      isDark: isDark,
                    ),
                     const SizedBox(height: 16),
                     _buildModuleCard(
                      meeting: 'Pertemuan 6',
                      title: '06 - Assessment 1',
                      description: '3 URLs, 2 Files, 3 Interactive Content',
                      isDone: true,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Bottom Navigation
           Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFB94646),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   _BottomNavItem(icon: Icons.home, label: 'Home'),
                   _BottomNavItem(icon: Icons.school, label: 'Kelas Saya'),
                   _BottomNavItem(icon: Icons.notifications, label: 'Notifikasi'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String title,
    required bool isActive,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? (isDark ? Colors.white : const Color(0xFF111827))
                      : (isDark ? Colors.grey[400] : Colors.grey[500]),
                ),
              ),
              if (isActive)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : const Color(0xFF111827),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required String meeting,
    required String title,
    required String description,
    required bool isDone,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2937) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF5EA2D6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  meeting,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Icon(
                Icons.check_circle_rounded,
                color: isDone ? Colors.green : (isDark ? Colors.grey[600] : Colors.grey[300]),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
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

  const _BottomNavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
