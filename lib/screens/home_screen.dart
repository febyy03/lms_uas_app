import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
import 'announcement_screen.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Theme colors
  static const Color primaryColor = Color(0xFF991B1B);
  static const Color secondaryColor = Color(0xFFB91C1C);
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF27272A);
  static const Color textLight = Color(0xFF1F2937);
  static const Color textDark = Color(0xFFF3F4F6);
  static const Color textMutedLight = Color(0xFF6B7280);
  static const Color textMutedDark = Color(0xFF9CA3AF);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive values based on screen size
    final ResponsiveConfig config = ResponsiveConfig(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
    
    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header - Fixed at top
            _buildHeader(isDark, config),
            // Main content - Scrollable
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(bottom: config.bottomNavHeight + 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: config.sectionSpacing),
                      // Announcement Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
                        child: _buildAnnouncementCard(config, isDark),
                      ),
                      SizedBox(height: config.sectionSpacing),
                      // Quick Access
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
                        child: _buildQuickAccess(isDark, config),
                      ),
                      SizedBox(height: config.sectionSpacing),
                      // Today's Classes
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
                        child: _buildTodayClasses(isDark, config),
                      ),
                      SizedBox(height: config.sectionSpacing),
                      // Semester Progress
                      _buildSemesterProgress(isDark, config),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(config),
    );
  }

  Widget _buildHeader(bool isDark, ResponsiveConfig config) {
    return Container(
      color: isDark ? surfaceDark : surfaceLight,
      padding: EdgeInsets.fromLTRB(
        config.horizontalPadding,
        config.verticalPaddingSmall,
        config.horizontalPadding,
        config.verticalPadding,
      ),
      child: Column(
        children: [
          // Welcome + Profile Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome text - Flexible to prevent overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: GoogleFonts.poppins(
                        fontSize: config.fontSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: isDark ? textMutedDark : textMutedLight,
                      ),
                    ),
                    SizedBox(height: config.spacing4),
                    Text(
                      'Mahasiswa Teladan',
                      style: GoogleFonts.poppins(
                        fontSize: config.fontSizeXLarge,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFFEF4444) : primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: config.spacing12),
              // Profile Image
              _buildProfileImage(isDark, config),
            ],
          ),
          SizedBox(height: config.spacing16),
          // Search Bar
          _buildSearchBar(isDark, config),
        ],
      ),
    );
  }

  Widget _buildProfileImage(bool isDark, ResponsiveConfig config) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(config.profileImageSize / 2),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAojsXXKU07Qn0dA7jHwRb4Kmn8VhX3Akl_8cWyw47dTthzAFsejgXa94aQH5zKeCBfm18xW6yBpAFG4xQpxpvqMHgxAE18TPNVcg5PhNdi7fXH8Ri-bqK7LV79NFETGVBp22y9UyAf92U1N2l5d3uCFkkKiHtalkjhcfUch6m9OtZWHNrxe5OmcrC8nIk-mrj5yyInBZ12hS3EreMfsfFI-vCMRWKCNJAbEIfSMibX8hea8jOGBD-X0PLJoeLHw2_xLLNM1h2e44g',
                width: config.profileImageSize,
                height: config.profileImageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: config.profileImageSize,
                  height: config.profileImageSize,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: Colors.grey, size: config.profileImageSize * 0.6),
                ),
              ),
            ),
          ),
          // Online indicator
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: config.onlineIndicatorSize,
              height: config.onlineIndicatorSize,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? surfaceDark : Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark, ResponsiveConfig config) {
    return Container(
      height: config.searchBarHeight,
      decoration: BoxDecoration(
        color: isDark ? surfaceDark.withValues(alpha: 0.5) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(config.borderRadiusMedium),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : const Color(0xFFE5E7EB),
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(
          fontSize: config.fontSizeNormal,
          color: isDark ? textDark : textLight,
        ),
        decoration: InputDecoration(
          hintText: 'Cari mata kuliah atau tugas...',
          hintStyle: GoogleFonts.poppins(
            fontSize: config.fontSizeNormal,
            color: isDark ? textMutedDark : textMutedLight,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? textMutedDark : textMutedLight,
            size: config.iconSizeSmall,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: config.spacing16,
            vertical: config.spacing12,
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(ResponsiveConfig config, bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(config.cardPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, Color(0xFF7F1D1D)],
        ),
        borderRadius: BorderRadius.circular(config.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -16,
            right: -16,
            child: Container(
              width: config.decorCircleSize,
              height: config.decorCircleSize,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -16,
            left: -16,
            child: Container(
              width: config.decorCircleSize * 0.8,
              height: config.decorCircleSize * 0.8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pengumuman Penting',
                style: GoogleFonts.poppins(
                  fontSize: config.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: config.spacing4),
              Text(
                'Jadwal UAS semester ganjil telah dirilis. Silakan cek bagian akademik untuk detail lebih lanjut.',
                style: GoogleFonts.poppins(
                  fontSize: config.fontSizeNormal,
                  color: const Color(0xFFFECACA),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: config.spacing12),
              SizedBox(
                height: config.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AnnouncementScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(horizontal: config.spacing16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(config.borderRadiusSmall),
                    ),
                  ),
                  child: Text(
                    'Lihat Detail',
                    style: GoogleFonts.poppins(
                      fontSize: config.fontSizeSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess(bool isDark, ResponsiveConfig config) {
    final quickAccessItems = [
      {'icon': Icons.school, 'label': 'Akademik', 'color': Colors.blue},
      {'icon': Icons.assignment, 'label': 'Tugas', 'color': Colors.green},
      {'icon': Icons.menu_book, 'label': 'Pustaka', 'color': Colors.purple},
      {'icon': Icons.event, 'label': 'Jadwal', 'color': Colors.orange},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Akses Cepat',
          style: GoogleFonts.poppins(
            fontSize: config.fontSizeMedium,
            fontWeight: FontWeight.bold,
            color: isDark ? textDark : textLight,
          ),
        ),
        SizedBox(height: config.spacing12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: quickAccessItems.map((item) {
            final color = item['color'] as Color;
            return Flexible(
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: config.quickAccessIconSize,
                      height: config.quickAccessIconSize,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? color.withValues(alpha: 0.2) 
                            : color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(config.borderRadiusMedium),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isDark ? color.withValues(alpha: 0.8) : color,
                        size: config.quickAccessIconSize * 0.5,
                      ),
                    ),
                    SizedBox(height: config.spacing8),
                    Text(
                      item['label'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: config.fontSizeXSmall,
                        fontWeight: FontWeight.w500,
                        color: isDark ? textMutedDark : textMutedLight,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTodayClasses(bool isDark, ResponsiveConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Kelas Hari Ini',
                style: GoogleFonts.poppins(
                  fontSize: config.fontSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: isDark ? textDark : textLight,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Lihat Semua',
                style: GoogleFonts.poppins(
                  fontSize: config.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFF87171) : primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: config.spacing12),
        // Class Card 1 - Active
        _buildClassCard(
          isDark: isDark,
          config: config,
          time: '08:00',
          title: 'Desain Antarmuka (UI/UX)',
          subtitle: 'D4SM-42-03 • Ruang A204',
          status: 'Berlangsung',
          isActive: true,
          progress: 0.75,
          timeColor: Colors.indigo,
        ),
        SizedBox(height: config.spacing12),
        // Class Card 2 - Upcoming
        _buildClassCard(
          isDark: isDark,
          config: config,
          time: '13:00',
          title: 'Pendidikan Kewarganegaraan',
          subtitle: 'D4SM-41-GAB1 • Online Zoom',
          status: 'Akan Datang',
          isActive: false,
          timeColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildClassCard({
    required bool isDark,
    required ResponsiveConfig config,
    required String time,
    required String title,
    required String subtitle,
    required String status,
    required bool isActive,
    double? progress,
    required Color timeColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(config.cardPaddingSmall),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(config.borderRadiusMedium),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : const Color(0xFFF3F4F6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time box
            Container(
              width: config.timeBoxSize,
              height: config.timeBoxSize,
              decoration: BoxDecoration(
                color: isDark 
                    ? timeColor.withValues(alpha: 0.2)
                    : timeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(config.borderRadiusSmall),
              ),
              child: Center(
                child: Text(
                  '$time\nWIB',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: config.fontSizeXSmall,
                    fontWeight: FontWeight.bold,
                    color: isDark 
                        ? timeColor.withValues(alpha: 0.8)
                        : timeColor,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            SizedBox(width: config.spacing12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: config.fontSizeNormal,
                      fontWeight: FontWeight.bold,
                      color: isDark ? textDark : textLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: config.spacing4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: config.fontSizeSmall,
                      color: isDark ? textMutedDark : textMutedLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: config.spacing8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: config.spacing8,
                          vertical: config.spacing4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? (isDark 
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : const Color(0xFFDCFCE7))
                              : (isDark 
                                  ? Colors.grey.withValues(alpha: 0.2)
                                  : const Color(0xFFF3F4F6)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: config.fontSizeXSmall,
                            fontWeight: FontWeight.w500,
                            color: isActive
                                ? (isDark 
                                    ? const Color(0xFF86EFAC)
                                    : const Color(0xFF166534))
                                : (isDark 
                                    ? Colors.grey[400]
                                    : Colors.grey[700]),
                          ),
                        ),
                      ),
                      if (progress != null) ...[
                        SizedBox(width: config.spacing8),
                        Expanded(
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? Colors.grey[700]
                                  : const Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterProgress(bool isDark, ResponsiveConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
          child: Text(
            'Progres Semester',
            style: GoogleFonts.poppins(
              fontSize: config.fontSizeMedium,
              fontWeight: FontWeight.bold,
              color: isDark ? textDark : textLight,
            ),
          ),
        ),
        SizedBox(height: config.spacing12),
        SizedBox(
          height: config.progressCardHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
            children: [
              _buildProgressCard(
                isDark: isDark,
                config: config,
                title: 'Pemrograman Web',
                progress: 0.9,
                icon: Icons.code,
                iconColor: Colors.yellow,
              ),
              SizedBox(width: config.spacing12),
              _buildProgressCard(
                isDark: isDark,
                config: config,
                title: 'Bahasa Inggris',
                progress: 0.86,
                icon: Icons.language,
                iconColor: Colors.blue,
              ),
              SizedBox(width: config.spacing12),
              _buildProgressCard(
                isDark: isDark,
                config: config,
                title: 'Matematika',
                progress: 0.72,
                icon: Icons.calculate,
                iconColor: Colors.green,
              ),
              SizedBox(width: config.spacing12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard({
    required bool isDark,
    required ResponsiveConfig config,
    required String title,
    required double progress,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: config.progressCardWidth,
      padding: EdgeInsets.all(config.cardPaddingSmall),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(config.borderRadiusMedium),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : const Color(0xFFF3F4F6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: config.progressIconContainerSize,
                height: config.progressIconContainerSize,
                decoration: BoxDecoration(
                  color: isDark 
                      ? iconColor.withValues(alpha: 0.2)
                      : iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDark 
                      ? iconColor.withValues(alpha: 0.8)
                      : iconColor,
                  size: config.progressIconContainerSize * 0.5,
                ),
              ),
              SizedBox(height: config.spacing8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: config.fontSizeNormal,
                  fontWeight: FontWeight.w600,
                  color: isDark ? textDark : textLight,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.poppins(
                      fontSize: config.fontSizeSmall,
                      color: isDark ? textMutedDark : textMutedLight,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: GoogleFonts.poppins(
                      fontSize: config.fontSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: isDark 
                          ? const Color(0xFFF87171)
                          : primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: config.spacing4),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isDark 
                      ? Colors.grey[700]
                      : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(ResponsiveConfig config) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(config.borderRadiusLarge),
          topRight: Radius.circular(config.borderRadiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: config.bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                config: config,
              ),
              _buildNavItem(
                icon: Icons.school,
                label: 'Kelas Saya',
                index: 1,
                config: config,
              ),
              _buildNavItem(
                icon: Icons.notifications,
                label: 'Notifikasi',
                index: 2,
                config: config,
                hasNotification: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required ResponsiveConfig config,
    bool hasNotification = false,
  }) {
    final isSelected = _currentNavIndex == index;
    
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        } else if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CourseDetailScreen()),
          );
        } else {
          setState(() {
            _currentNavIndex = index;
          });
        }
      },
      child: Opacity(
        opacity: isSelected ? 1.0 : 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(config.spacing8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(config.borderRadiusMedium),
                    )
                  : null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: config.navIconSize,
                  ),
                  if (hasNotification)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: config.notificationDotSize,
                        height: config.notificationDotSize,
                        decoration: BoxDecoration(
                          color: Colors.yellow[400],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: config.spacing4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: config.fontSizeXSmall,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Responsive configuration class that calculates all dimensions based on screen size
class ResponsiveConfig {
  final double screenWidth;
  final double screenHeight;
  
  ResponsiveConfig({
    required this.screenWidth,
    required this.screenHeight,
  });
  
  // Screen size categories
  bool get isVerySmall => screenWidth < 320;
  bool get isSmall => screenWidth < 375;
  bool get isMedium => screenWidth >= 375 && screenWidth < 414;
  bool get isLarge => screenWidth >= 414;
  bool get isShortScreen => screenHeight < 700;
  
  // Padding & Spacing
  double get horizontalPadding => isVerySmall ? 12 : (isSmall ? 16 : 20);
  double get verticalPadding => isShortScreen ? 12 : 16;
  double get verticalPaddingSmall => isShortScreen ? 8 : 12;
  double get sectionSpacing => isShortScreen ? 16 : 24;
  double get cardPadding => isSmall ? 14 : 18;
  double get cardPaddingSmall => isSmall ? 10 : 14;
  
  // Common spacing values
  double get spacing4 => 4;
  double get spacing8 => isSmall ? 6 : 8;
  double get spacing12 => isSmall ? 10 : 12;
  double get spacing16 => isSmall ? 12 : 16;
  
  // Font sizes - fully responsive
  double get fontSizeXSmall => isVerySmall ? 9 : (isSmall ? 10 : 11);
  double get fontSizeSmall => isVerySmall ? 10 : (isSmall ? 11 : 12);
  double get fontSizeNormal => isVerySmall ? 12 : (isSmall ? 13 : 14);
  double get fontSizeMedium => isVerySmall ? 14 : (isSmall ? 15 : 16);
  double get fontSizeLarge => isVerySmall ? 15 : (isSmall ? 16 : 18);
  double get fontSizeXLarge => isVerySmall ? 18 : (isSmall ? 20 : 22);
  
  // Border radius
  double get borderRadiusSmall => 6;
  double get borderRadiusMedium => isSmall ? 10 : 12;
  double get borderRadiusLarge => isSmall ? 14 : 16;
  
  // Icon sizes
  double get iconSizeSmall => isSmall ? 18 : 20;
  double get iconSizeMedium => isSmall ? 22 : 24;
  double get iconSizeLarge => isSmall ? 26 : 28;
  double get navIconSize => isSmall ? 24 : 26;
  
  // Component sizes
  double get profileImageSize => isSmall ? 40 : 48;
  double get onlineIndicatorSize => isSmall ? 12 : 14;
  double get searchBarHeight => isShortScreen ? 44 : 48;
  double get buttonHeight => isSmall ? 32 : 36;
  double get decorCircleSize => isSmall ? 70 : 90;
  
  // Quick access
  double get quickAccessIconSize => isVerySmall ? 44 : (isSmall ? 48 : 54);
  
  // Class card
  double get timeBoxSize => isSmall ? 42 : 48;
  
  // Progress card
  double get progressCardWidth => isVerySmall ? 160 : (isSmall ? 180 : 200);
  double get progressCardHeight => isShortScreen ? 120 : 140;
  double get progressIconContainerSize => isSmall ? 32 : 36;
  
  // Bottom navigation
  double get bottomNavHeight => isShortScreen ? 64 : 72;
  double get notificationDotSize => isSmall ? 8 : 10;
}
