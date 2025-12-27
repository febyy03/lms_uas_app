import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
import 'my_classes_screen.dart';

class HomeScreenNew extends StatefulWidget {
  final String userName;

  const HomeScreenNew({
    super.key,
    this.userName = 'DANDY CANDRA PRATAMA',
  });

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  int _currentNavIndex = 0;

  // Theme colors
  static const Color primaryColor = Color(0xFFB91C1C);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: _buildHeader(isDark),
              ),
              // Body Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Upcoming Task Section
                    _buildUpcomingTaskSection(isDark),
                    const SizedBox(height: 40),
                    // Announcement Section
                    _buildAnnouncementSection(isDark),
                    const SizedBox(height: 40),
                    // Class Progress Section
                    _buildClassProgressSection(isDark),
                  ]),
                ),
              ),
            ],
          ),
          // Floating Bottom Navigation
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: _buildBottomNavigation(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo,',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFECACA),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.userName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Role Badge
              _buildRoleBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleBadge() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(userName: widget.userName),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MAHASISWA',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: primaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTaskSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Tugas Yang Akan Datang',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildUpcomingTaskCard(isDark),
      ],
    );
  }

  Widget _buildUpcomingTaskCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tugas 01 - UID Android Mobile Game',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFFECACA),
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFFF87171).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WAKTU PENGUMPULAN',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFECACA),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Jumat 26 Februari, 23:59 WIB',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  'Pengumuman Terakhir',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to all announcements
                },
                child: Text(
                  'Lihat Semua',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildAnnouncementCard(isDark),
      ],
    );
  }

  Widget _buildAnnouncementCard(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? cardDark : cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Maintenance Pra UAS Semester Genap 2020/2021',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
            ),
          ),
          // Image
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : const Color(0xFFEFF6FF),
            ),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAPxVy-VV3kgnZhspgDIjw6TWkXKKxb4qmDK_hAeatjs9CQIpFmfwjQEMms0Lxiy3jySJMgjJBLAjYBvBeOrYBdzlQ3eKdnjJquJCOm56s-Aub5lrMUvjh5uJYf-nJHM2Qxr8YoK46rdbmqxIvBE4Fv6laHuhUbCLJzUPd3QIEcqn1UyWJsMtLdz2aQe2LgzVj3uzNCCQaMJDpTJdyNHf0Z802rftqf7vrGC7ZsCsR6vqwS4fkMmYajT0MC9yk2n6-pkhTK4Ymv_c8',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.9),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: isDark ? Colors.grey.shade800 : const Color(0xFFEFF6FF),
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Diinformasikan kepada seluruh pengguna LMS, kami dari tim CeLOE akan melakukan maintenance pada tanggal 12 Juni 2021 untuk meningkatkan layanan server dalam menghadapi ujian akhir semester (UAS).',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                height: 1.6,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassProgressSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Progres Kelas',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Course Cards
        _buildCourseCard(
          isDark: isDark,
          title: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA D4SM-42-03 [ADY]',
          semester: '2021/2',
          progress: 89,
          thumbnailType: CourseThumbType.uiux,
        ),
        const SizedBox(height: 24),
        _buildCourseCard(
          isDark: isDark,
          title: 'KEWARGANEGARAAN D4SM-41-GAB1 [BBO]. JUMAT 2',
          semester: '2021/2',
          progress: 86,
          thumbnailType: CourseThumbType.garuda,
        ),
        const SizedBox(height: 24),
        _buildCourseCard(
          isDark: isDark,
          title: 'SISTEM OPERASI D4SM-44-02 [DDS]',
          semester: '2021/2',
          progress: 90,
          thumbnailType: CourseThumbType.os,
        ),
        const SizedBox(height: 24),
        _buildCourseCard(
          isDark: isDark,
          title: 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA D4SM-41-GAB1 [APJ]',
          semester: '2021/2',
          progress: 90,
          thumbnailType: CourseThumbType.mobile,
        ),
        const SizedBox(height: 24),
        _buildCourseCard(
          isDark: isDark,
          title: 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC D4SM-41-GAB1 [ARS]',
          semester: '2021/2',
          progress: 90,
          thumbnailType: CourseThumbType.english,
        ),
        const SizedBox(height: 24),
        _buildCourseCard(
          isDark: isDark,
          title: 'PEMROGRAMAN MULTIMEDIA INTERAKTIF D4SM-43-04 [TPR]',
          semester: '2021/2',
          progress: 90,
          thumbnailType: CourseThumbType.multimedia,
        ),
      ],
    );
  }

  Widget _buildCourseCard({
    required bool isDark,
    required String title,
    required String semester,
    required int progress,
    required CourseThumbType thumbnailType,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? cardDark : cardLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          _buildCourseThumbnail(thumbnailType, isDark),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Semester Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      semester,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Container(
                              width: constraints.maxWidth * (progress / 100),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Progress Text
                  Text(
                    '$progress % Selesai',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseThumbnail(CourseThumbType type, bool isDark) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildThumbnailContent(type, isDark),
    );
  }

  Widget _buildThumbnailContent(CourseThumbType type, bool isDark) {
    switch (type) {
      case CourseThumbType.uiux:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFDE047), Color(0xFFF97316)],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'u',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'i',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    'UX',
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case CourseThumbType.garuda:
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF7F1D1D).withOpacity(0.2) : const Color(0xFFFEF2F2),
            border: Border.all(
              color: isDark ? const Color(0xFF7F1D1D).withOpacity(0.3) : const Color(0xFFFEE2E2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDOFbPuxARN9G1BYeYraizHBvTdwo5jtg3MJXQIolSxT6cK1o2W_-2ls5XfNfrWNv4OwwppwT1ccMPn-JBrJTHmGPsf-7nREWTCvHpODAfgNdQZ6NYgHyDU5oIUQnHIou704BUXhTP68TBnUdv7QyKB-IJ2z-8ujzTtVL65DqS7dRiZX7EPhn-2tquiY6QUuZ_itb-OamIzeQSvc5RJXfl0E-m0_uOlddtVfLjNq4P2kV-b8t9tWN6bYkd7MbYzIoXaRfXKcgOyhEg',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.flag_outlined,
                size: 40,
                color: primaryColor.withOpacity(0.5),
              );
            },
          ),
        );

      case CourseThumbType.os:
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Operation',
                style: GoogleFonts.poppins(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'SYSTEM',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'user',
                      style: GoogleFonts.poppins(
                        fontSize: 5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'kernel',
                      style: GoogleFonts.poppins(
                        fontSize: 5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      case CourseThumbType.mobile:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF67E8F9), Color(0xFF14B8A6)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case CourseThumbType.english:
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topRight,
                        radius: 1.5,
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade300,
                          Colors.grey.shade500,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: 0.785398, // 45 degrees in radians
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 0.5,
                          ),
                          color: index == 1 ? Colors.white.withOpacity(0.1) : Colors.transparent,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );

      case CourseThumbType.multimedia:
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF60A5FA), Color(0xFF1D4ED8)],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.overlay,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        );
    }
  }

  Widget _buildBottomNavigation(bool isDark) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: _currentNavIndex == 0,
            onTap: () => setState(() => _currentNavIndex = 0),
          ),
          _buildNavItem(
            icon: Icons.school_rounded,
            label: 'Kelas Saya',
            isSelected: _currentNavIndex == 1,
            onTap: () {
              setState(() => _currentNavIndex = 1);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyClassesScreen(),
                ),
              );
            },
          ),
          _buildNavItem(
            icon: Icons.notifications_rounded,
            label: 'Notifikasi',
            isSelected: _currentNavIndex == 2,
            onTap: () {
              setState(() => _currentNavIndex = 2);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: isSelected
                    ? [
                        const BoxShadow(
                          color: Colors.white38,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : const Color(0xFFFECACA),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFFFECACA),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CourseThumbType {
  uiux,
  garuda,
  os,
  mobile,
  english,
  multimedia,
}
