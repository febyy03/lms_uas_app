import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'materi_screen.dart';

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
                child: _selectedTab == 0
                    ? _buildMateriList(isDark)
                    : _buildTugasList(isDark, primaryColor),
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
    required BuildContext context, // Added context for navigation
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MateriScreen(title: title.split('-').last.trim()),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
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
      ),
    );
  }

  Widget _buildMateriList(bool isDark) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        _buildModuleCard(
          meeting: 'Pertemuan 1',
          title: '01 - Pengantar User Interface Design',
          description: '3 URLs, 2 Files, 3 Interactive Content',
          isDone: false,
          isDark: isDark,
          context: context,
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          meeting: 'Pertemuan 2',
          title: '02 - Konsep User Interface Design',
          description: '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
          isDone: true,
          isDark: isDark,
          context: context,
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          meeting: 'Pertemuan 3',
          title: '03 - Interaksi pada User Interface Design',
          description: '3 URLs, 2 Files, 3 Interactive Content',
          isDone: true,
          isDark: isDark,
          context: context,
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          meeting: 'Pertemuan 4',
          title: '04 - Ethnographic Observation',
          description: '3 URLs, 2 Files, 3 Interactive Content',
          isDone: true,
          isDark: isDark,
          context: context,
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          meeting: 'Pertemuan 5',
          title: '05 - UID Testing',
          description: '3 URLs, 2 Files, 3 Interactive Content',
          isDone: true,
          isDark: isDark,
          context: context,
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          meeting: 'Pertemuan 6',
          title: '06 - Assessment 1',
          description: '3 URLs, 2 Files, 3 Interactive Content',
          isDone: true,
          isDark: isDark,
          context: context,
        ),
      ],
    );
  }

  Widget _buildTugasList(bool isDark, Color primaryColor) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daftar Tugas',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1F2937),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF7F1D1D).withValues(alpha: 0.3) : const Color(0xFFEC1313).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '3 Pending',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFFF87171) : const Color(0xFFEC1313),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildTaskCard(
          isDark: isDark,
          type: 'quiz',
          status: 'Selesai',
          title: 'Quiz 1: Prinsip Desain',
          subtitle: 'Ditutup: 12 Okt, 23:59',
          grade: '85/100',
          onTap: () => Navigator.pushNamed(context, '/quiz_review'),
        ),
        const SizedBox(height: 16),
        _buildTaskCard(
          isDark: isDark,
          type: 'assignment',
          status: 'Pending',
          title: 'Tugas Besar: Wireframing & Prototyping',
          subtitle: 'Due: 20 Okt, 23:59',
          attachmentCount: 2,
          isPending: true,
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 16),
        _buildTaskCard(
          isDark: isDark,
          type: 'quiz_locked',
          status: 'Belum Dimulai',
          title: 'Kuis Harian 2',
          subtitle: 'Due: 25 Okt, 10:00',
          duration: '30 menit',
          isPending: true,
          primaryColor: primaryColor,
          isLocked: true,
        ),
        const SizedBox(height: 16),
        _buildTaskCard(
          isDark: isDark,
          type: 'graded',
          status: 'Dinilai',
          title: 'Tugas Kelompok: User Persona',
          subtitle: 'Ditutup: 05 Okt, 23:59',
          isDone: true,
          statusColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required bool isDark,
    required String type,
    required String status,
    required String title,
    required String subtitle,
    String? grade,
    int? attachmentCount,
    String? duration,
    bool isPending = false,
    bool isLocked = false,
    bool isDone = false,
    Color? primaryColor,
    Color? statusColor,
    VoidCallback? onTap,
  }) {
    Color getIconBgColor() {
      if (isDark) {
        if (type.contains('quiz')) return const Color(0xFF7C2D12).withValues(alpha: 0.2); // Orange dark
        if (type == 'assignment') return const Color(0xFF1E3A8A).withValues(alpha: 0.2); // Blue dark
        return const Color(0xFF374151); // Gray dark
      }
      if (type.contains('quiz')) return const Color(0xFFFFF7ED); // Orange light
      if (type == 'assignment') return const Color(0xFFEFF6FF); // Blue light
      return const Color(0xFFF3F4F6); // Gray light
    }

    Color getIconColor() {
      if (isDark) {
        if (type.contains('quiz')) return const Color(0xFFFB923C);
        if (type == 'assignment') return const Color(0xFF60A5FA);
        return const Color(0xFF9CA3AF);
      }
      if (type.contains('quiz')) return const Color(0xFFEA580C);
      if (type == 'assignment') return const Color(0xFF2563EB);
      return const Color(0xFF4B5563);
    }

    IconData getIconData() {
      if (type.contains('quiz')) return (type == 'quiz_locked') ? Icons.timer_outlined : Icons.quiz_outlined;
      if (type == 'assignment') return Icons.assignment_outlined;
      return Icons.assignment_turned_in_outlined;
    }

    Color getStatusBgColor() {
      if (status == 'Selesai') return isDark ? const Color(0xFF14532D).withValues(alpha: 0.3) : const Color(0xFFF0FDF4); // Green
      if (status == 'Pending' || status == 'Belum Dimulai') return isDark ? const Color(0xFF713F12).withValues(alpha: 0.3) : const Color(0xFFFEFCE8); // Yellow
      return isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6); // Gray
    }

    Color getStatusTextColor() {
      if (status == 'Selesai') return isDark ? const Color(0xFF4ADE80) : const Color(0xFF15803D); // Green
      if (status == 'Pending' || status == 'Belum Dimulai') return isDark ? const Color(0xFFFACC15) : const Color(0xFFA16207); // Yellow
      return isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151); // Gray
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isPending && primaryColor != null)
                Container(width: 4, color: primaryColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: getIconBgColor(),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              getIconData(),
                              color: getIconColor(),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : const Color(0xFF111827),
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  subtitle,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: (isPending && primaryColor != null) 
                                        ? primaryColor 
                                        : (isDark ? Colors.grey[400] : Colors.grey[500]),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusBgColor(),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: getStatusTextColor().withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: getStatusTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 1,
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isLocked ? Icons.timer_outlined : (attachmentCount != null ? Icons.attach_file : (grade != null ? Icons.grade_outlined : Icons.check_circle_outline)),
                                size: 16,
                                color: isDark ? Colors.grey[400] : Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isLocked ? 'Durasi: $duration' : (attachmentCount != null ? 'Attachments: $attachmentCount' : (grade != null ? 'Nilai: $grade' : 'Completed')),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                          if (isLocked)
                             Text(
                              'Locked',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.grey[500] : Colors.grey[400],
                              ),
                            )
                          else
                            InkWell(
                              onTap: onTap ?? () {},
                              child: Row(
                                children: [
                                  Text(
                                    isPending ? 'Submit' : 'Review',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isPending ? primaryColor : (isDark ? Colors.grey[400] : Colors.grey[400]),
                                    ),
                                  ),
                                  Icon(
                                    isPending ? Icons.upload_rounded : Icons.chevron_right_rounded,
                                    size: 16,
                                    color: isPending ? primaryColor : (isDark ? Colors.grey[400] : Colors.grey[400]),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
