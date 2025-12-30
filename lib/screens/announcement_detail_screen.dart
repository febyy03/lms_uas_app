import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFFB93C3C);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF111827) : const Color(0xFFF3F4F6),
      extendBody: true, // For bottom nav transparency if needed
      appBar: AppBar(
        backgroundColor: (isDark ? const Color(0xFF111827) : Colors.white).withValues(alpha: 0.95),
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
                    color: isDark ? Colors.white : const Color(0xFF1F2937),
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
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: isDark ? Colors.grey[800] : Colors.grey[100],
            height: 1,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maintenance Pra UAS Semester Genap 2024/2025',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[700] : Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: isDark ? Colors.grey[500] : Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'By Admin - Rabu, 2 Juni 2025, 10:45',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCMsaEuzZualaPDC5HNkrwf4ZHLw0sW4ZCtgR1wz8z4sod8GymJdetMHiAlKsYELh8DhNv5w7FCc89e8ynAswfWhmJwFKuEDz3UGtXywIhZbcPoRXuItbJhHGfCdQ5-RXC0qhoQwK4Jk9nLhu_-wGrrV4zIv9VtUBvSz7QEQRMn6jkd9plWBZQc-bCbQG7aMdwyI1dnqGaHQb9ZwyhQvhmxqlBSV_mstaFxbQaKk8gd5cN9oX0h1GlkoH5rEEYknMmHaIVr9rYZwR4',
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Maintenance LMS',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Diinformasikan kepada seluruh mahasiswa universitas islam madura, kami dari admin universitas islam madura akan melakukan UAS pada tanggal 12 Juni 2025, di himbau untuk seluruh mahasiswa untuk mengikuti ujian akhir semester (UAS).',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.6,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.6,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                    children: [
                      const TextSpan(
                        text: 'Dengan adanya ujian akhir semester (UAS) maka situs LMS tidak dapat diakses mulai pukul 00.00 s/d 06.00 WIB.',
                      ),
                      TextSpan(
                        text: 'universitas.islam.madura.ac.id',
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' tidak dapat diakses mulai pukul 00.00 s/d 06.00 WIB.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Demikian informasi ini kami sampaikan, mohon maaf atas ketidaknyamanannya.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.6,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                   textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 32),
                Text(
                  'Hormat Kami,',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                Text(
                  'universitas islam madura',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
              ],
            ),
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
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     _BottomNavItem(
              //       icon: Icons.home_rounded,
              //       label: 'Home',
              //       onTap: () {}, // Navigate if needed
              //     ),
              //     _BottomNavItem(
              //       icon: Icons.school_rounded,
              //       label: 'Kelas Saya',
              //       onTap: () {},
              //     ),
              //      _BottomNavItem(
              //       icon: Icons.notifications_rounded,
              //       label: 'Notifikasi',
              //       hasNotification: true,
              //       onTap: () {},
              //     ),
              //   ],
              // ),
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
  final bool hasNotification;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.hasNotification = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.9),
                size: 28,
              ),
              if (hasNotification)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.yellow[400],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFB93C3C), // Primary color border
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
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
