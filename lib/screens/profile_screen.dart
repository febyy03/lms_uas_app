import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTabIndex = 0;
  int _currentNavIndex = 0;

  // Edit Profile Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _countryController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Theme colors matching the HTML design
  static const Color primaryColor = Color(0xFFB94141);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1F2937);
  static const Color textLight = Color(0xFF1F2937);
  static const Color textDark = Color(0xFFF9FAFB);
  static const Color textMutedLight = Color(0xFF6B7280);
  static const Color textMutedDark = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final config = _ProfileResponsiveConfig(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header with profile info
          _buildHeader(isDark, config),
          // Tab bar
          _buildTabBar(isDark, config),
          // Main content
          Expanded(
            child: _buildContent(isDark, config),
          ),
        ],
      ),
      // Logout button
      floatingActionButton: _buildLogoutButton(config),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigation(config, isDark),
    );
  }

  Widget _buildHeader(bool isDark, _ProfileResponsiveConfig config) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Back button and content
            Padding(
              padding: EdgeInsets.fromLTRB(
                config.horizontalPadding,
                config.spacing12,
                config.horizontalPadding,
                config.spacing24,
              ),
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: config.iconSizeLarge,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  SizedBox(height: config.spacing8),
                  // Profile image
                  Container(
                    width: config.profileImageSize,
                    height: config.profileImageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(config.profileImageSize / 2),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuABfcxk0FZNX-rXSjQlKdHITUcye_0DRxRffkaa1XaUGzpz_6uVACSPDpdQ7aKBBCyYD_OQEB10IufgpUHo6LRsyUDrF0Yn2gPCcw1oVAaBL4HCkLAVuMaIsBNPsQUXvRRBiTBxiDMcrUMVr4BBbbDfQVn0vZg2WzBdDcxQ-MvpNkzTA9loCSYSR_Ka7Hdds7aNb_jFiK9F3WkF23R1gMMvta4f1UZ3DpSOvCBUif8XUtwCGy0ySUd2A8Nymq63Pe82EQ_ZqoEcEn4',
                        width: config.profileImageSize,
                        height: config.profileImageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: config.profileImageSize * 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: config.spacing16),
                  // Name
                  Text(
                    'DANDY CANDRA PRATAMA',
                    style: GoogleFonts.inter(
                      fontSize: config.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(bool isDark, _ProfileResponsiveConfig config) {
    final tabs = ['About Me', 'Kelas', 'Edit Profile'];

    return Transform.translate(
      offset: Offset(0, -config.spacing12),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? cardDark : cardLight,
            borderRadius: BorderRadius.circular(config.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: EdgeInsets.all(config.spacing8),
          child: Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: config.spacing12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tabs[index],
                          style: GoogleFonts.inter(
                            fontSize: config.fontSizeNormal,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? (isDark ? textDark : textLight)
                                : (isDark ? textMutedDark : textMutedLight),
                          ),
                        ),
                        SizedBox(height: config.spacing8),
                        if (isSelected)
                          Container(
                            height: 4,
                            width: 32,
                            decoration: BoxDecoration(
                              color: textMutedLight,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark, _ProfileResponsiveConfig config) {
    // Switch content based on selected tab
    switch (_selectedTabIndex) {
      case 0:
        return _buildAboutMeContent(isDark, config);
      case 1:
        return _buildKelasContent(isDark, config);
      case 2:
        return _buildEditProfileContent(isDark, config);
      default:
        return _buildAboutMeContent(isDark, config);
    }
  }

  Widget _buildAboutMeContent(bool isDark, _ProfileResponsiveConfig config) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        config.horizontalPadding + config.spacing8,
        config.spacing8,
        config.horizontalPadding + config.spacing8,
        config.bottomNavHeight + 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Information Section
          _buildSectionTitle('Informasi User', isDark, config),
          SizedBox(height: config.spacing16),
          _buildInfoItem(
            label: 'Email address',
            value: 'dandycandra@365.telkomuniversity.ac.id',
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildInfoItem(
            label: 'Program Studi',
            value: 'D4 Teknologi Rekayasa Multimedia',
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildInfoItem(
            label: 'Fakultas',
            value: 'FIT',
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing32),
          // Login Activity Section
          _buildSectionTitle('Aktivitas Login', isDark, config),
          SizedBox(height: config.spacing16),
          _buildInfoItem(
            label: 'First access to site',
            value: 'Monday, 7 September 2020, 9:27 AM',
            subtitle: '(288 days 12 hours)',
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildInfoItem(
            label: 'Last access to site',
            value: 'Tuesday, 22 June 2021, 9:44 PM',
            subtitle: '(now)',
            isDark: isDark,
            config: config,
          ),
        ],
      ),
    );
  }

  Widget _buildKelasContent(bool isDark, _ProfileResponsiveConfig config) {
    // List of classes from the HTML design
    final kelasList = [
      {
        'title': 'Bahasa Inggris: Business and Scientific D4SM-41-GAB1 [ARS]',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Desain Antarmuka & Pengalaman Pengguna D4SM-42-03 [ADY]',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Kewarganegaraan D4SM-41-GAB1 [BBO]. JUMAT 2',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Olah Raga D3TT-44-02 [EYR]',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Pemrograman Multimedia Interaktif D4SM-43-04 [TPR]',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Pemrograman Perangkat Bergerak Multimedia D4SM-41-GAB1 [APJ]',
        'startDate': 'Monday, 8 February 2021',
      },
      {
        'title': 'Sistem Operasi D4SM-44-02 [DDS]',
        'startDate': 'Monday, 8 February 2021',
      },
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        config.horizontalPadding,
        config.spacing16,
        config.horizontalPadding,
        config.bottomNavHeight + 80,
      ),
      child: Column(
        children: kelasList.map((kelas) {
          return _buildKelasItem(
            title: kelas['title']!,
            startDate: kelas['startDate']!,
            isDark: isDark,
            config: config,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKelasItem({
    required String title,
    required String startDate,
    required bool isDark,
    required _ProfileResponsiveConfig config,
  }) {
    const Color iconBlue = Color(0xFF7FB5D9);

    return Padding(
      padding: EdgeInsets.only(bottom: config.spacing24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course icon (blue oval)
          Container(
            width: 64,
            height: 40,
            decoration: BoxDecoration(
              color: iconBlue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: iconBlue.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          SizedBox(width: config.spacing16),
          // Course info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: config.fontSizeSmall,
                    fontWeight: FontWeight.w600,
                    color: isDark ? textDark : const Color(0xFF1F2937),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: config.spacing4),
                Text(
                  'Tanggal Mulai $startDate',
                  style: GoogleFonts.poppins(
                    fontSize: config.fontSizeXSmall,
                    color: isDark ? textMutedDark : textMutedLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileContent(bool isDark, _ProfileResponsiveConfig config) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        config.horizontalPadding,
        config.spacing24,
        config.horizontalPadding,
        config.bottomNavHeight + 80,
      ),
      child: Column(
        children: [
          _buildTextField(
            label: 'Nama Pertama',
            controller: _firstNameController,
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildTextField(
            label: 'Nama Terakhir',
            controller: _lastNameController,
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildTextField(
            label: 'E-mail Address',
            controller: _emailController,
            isDark: isDark,
            config: config,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: config.spacing20),
          _buildTextField(
            label: 'Negara',
            controller: _countryController,
            isDark: isDark,
            config: config,
          ),
          SizedBox(height: config.spacing20),
          _buildTextField(
            label: 'Deskripsi',
            controller: _descriptionController,
            isDark: isDark,
            config: config,
            maxLines: 5,
          ),
          SizedBox(height: config.spacing32),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Save functionality placeholder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile saved successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6),
                foregroundColor: isDark ? Colors.white : const Color(0xFF111827),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: config.spacing12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(config.borderRadiusMedium),
                ),
                elevation: 1,
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.inter(
                  fontSize: config.fontSizeSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
    required _ProfileResponsiveConfig config,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: config.fontSizeSmall,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF1F2937),
            ),
          ),
        ),
        SizedBox(height: config.spacing8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(
            fontSize: config.fontSizeSmall,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? cardDark : Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: config.spacing16,
              vertical: config.spacing12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(config.borderRadiusMedium),
              borderSide: BorderSide(
                color: isDark ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(config.borderRadiusMedium),
              borderSide: BorderSide(
                color: isDark ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(config.borderRadiusMedium),
              borderSide: const BorderSide(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, bool isDark, _ProfileResponsiveConfig config) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: config.fontSizeMedium,
        fontWeight: FontWeight.bold,
        color: isDark ? textDark : textLight,
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    String? subtitle,
    required bool isDark,
    required _ProfileResponsiveConfig config,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: config.fontSizeNormal,
            fontWeight: FontWeight.w500,
            color: isDark ? textMutedDark : textMutedLight,
          ),
        ),
        SizedBox(height: config.spacing4),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: config.fontSizeMedium,
              color: isDark ? textDark : textLight,
              height: 1.4,
            ),
            children: [
              TextSpan(text: value),
              if (subtitle != null)
                TextSpan(
                  text: ' $subtitle',
                  style: GoogleFonts.inter(
                    fontSize: config.fontSizeNormal,
                    color: isDark ? textMutedDark : textMutedLight,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(_ProfileResponsiveConfig config) {
    return Padding(
      padding: EdgeInsets.only(bottom: config.bottomNavHeight + 20),
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle logout
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Apakah Anda yakin ingin keluar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to login
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: config.spacing20,
            vertical: config.spacing12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(config.borderRadiusMedium),
          ),
          elevation: 8,
          shadowColor: primaryColor.withValues(alpha: 0.4),
        ),
        icon: Icon(Icons.logout_rounded, size: config.iconSizeMedium),
        label: Text(
          'Log Out',
          style: GoogleFonts.inter(
            fontSize: config.fontSizeNormal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(_ProfileResponsiveConfig config, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(config.borderRadiusXLarge),
          topRight: Radius.circular(config.borderRadiusXLarge),
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
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
                config: config,
              ),
              _buildNavItem(
                icon: Icons.school_rounded,
                label: 'Kelas Saya',
                index: 1,
                config: config,
              ),
              _buildNavItem(
                icon: Icons.notifications_rounded,
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
    required _ProfileResponsiveConfig config,
    bool hasNotification = false,
  }) {
    final isSelected = _currentNavIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).pop();
        } else if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
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
                            width: 2,
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
              style: GoogleFonts.inter(
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

/// Responsive configuration for profile screen
class _ProfileResponsiveConfig {
  final double screenWidth;
  final double screenHeight;

  _ProfileResponsiveConfig({
    required this.screenWidth,
    required this.screenHeight,
  });

  // Screen categories
  bool get isSmall => screenWidth < 375;
  bool get isShortScreen => screenHeight < 700;

  // Padding & Spacing
  double get horizontalPadding => isSmall ? 16 : 24;
  double get spacing4 => 4;
  double get spacing8 => isSmall ? 6 : 8;
  double get spacing12 => isSmall ? 10 : 12;
  double get spacing16 => isSmall ? 12 : 16;
  double get spacing20 => isSmall ? 16 : 20;
  double get spacing24 => isSmall ? 20 : 24;
  double get spacing32 => isSmall ? 24 : 32;

  // Font sizes
  double get fontSizeXSmall => isSmall ? 10 : 12;
  double get fontSizeSmall => isSmall ? 12 : 14;
  double get fontSizeNormal => isSmall ? 14 : 16;
  double get fontSizeMedium => isSmall ? 16 : 18;
  double get fontSizeLarge => isSmall ? 18 : 20;

  // Border radius
  double get borderRadiusMedium => isSmall ? 8 : 12;
  double get borderRadiusLarge => isSmall ? 14 : 16;
  double get borderRadiusXLarge => isSmall ? 28 : 35;

  // Icon sizes
  double get iconSizeMedium => isSmall ? 20 : 24;
  double get iconSizeLarge => isSmall ? 28 : 30;
  double get navIconSize => isSmall ? 24 : 28;

  // Component sizes
  double get profileImageSize => isSmall ? 96 : 112;
  double get bottomNavHeight => isShortScreen ? 64 : 80;
  double get notificationDotSize => isSmall ? 10 : 12;
}
