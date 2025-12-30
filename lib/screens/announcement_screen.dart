import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'announcement_detail_screen.dart';
import 'course_detail_screen.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFFB93C3C);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Pengumuman',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            children: const [
              _AnnouncementItem(
                title: 'Maintenance Pra UAS Semester Genap 2025/2026',
                subtitle: 'By Admin universitas islam madura - Rabu, 2 Juni 2025, 10:45',
              ),
              SizedBox(height: 32),
              _AnnouncementItem(
                title: 'Pengumuman UAS',
                subtitle: 'By Admin universitas islam madura - Senin, 11 Januari 2025, 7:52',
              ),
              SizedBox(height: 32),
              _AnnouncementItem(
                title: 'Maintenance Pra UAS Semeter Ganjil 2025/2026',
                subtitle: 'By Admin universitas islam madura - Minggu, 10 Januari 2025, 9:30',
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _BottomNavItem(
                    icon: Icons.home_rounded, 
                    label: 'Home',
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.school_rounded, 
                    label: 'Kelas Saya',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CourseDetailScreen()),
                      );
                    },
                  ),
                  _BottomNavItem(
                    icon: Icons.notifications_rounded,
                    label: 'Notifikasi',
                    showBadge: true,
                    onTap: () {}, // Already here or similar
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _AnnouncementItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AnnouncementDetailScreen()),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.rotate(
              angle: -0.2, // Approx -12 degrees
              child: Icon(
                Icons.campaign_rounded,
                size: 40,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
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
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showBadge;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.showBadge = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            if (showBadge)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFB93C3C),
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        ],
      ),
    );
  }
}
