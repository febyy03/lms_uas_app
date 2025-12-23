import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;

  const ProfileScreen({super.key, required this.userName});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTabIndex = 0; // 0: About Me, 1: Kelas
  late String _currentUserName;

  @override
  void initState() {
    super.initState();
    _currentUserName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // background-light
      body: Stack(
        children: [
          // Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280, // Approximate height for header
            child: Container(
              color: const Color(0xFFB94141), // primary red
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Header Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Profile Image
                      Container(
                        width: 112, // 28 * 4
                        height: 112,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuABfcxk0FZNX-rXSjQlKdHITUcye_0DRxRffkaa1XaUGzpz_6uVACSPDpdQ7aKBBCyYD_OQEB10IufgpUHo6LRsyUDrF0Yn2gPCcw1oVAaBL4HCkLAVuMaIsBNPsQUXvRRBiTBxiDMcrUMVr4BBbbDfQVn0vZg2WzBdDcxQ-MvpNkzTA9loCSYSR_Ka7Hdds7aNb_jFiK9F3WkF23R1gMMvta4f1UZ3DpSOvCBUif8XUtwCGy0ySUd2A8Nymq63Pe82EQ_ZqoEcEn4',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, color: Colors.white, size: 60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _currentUserName.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Floating Menu Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10),
                          blurRadius: 30,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMenuButton("About Me", _selectedTabIndex == 0, () {
                            setState(() {
                              _selectedTabIndex = 0;
                            });
                          }),
                        ),
                         Expanded(
                          child: _buildMenuButton("Kelas", _selectedTabIndex == 1, () {
                            setState(() {
                              _selectedTabIndex = 1;
                            });
                          }),
                        ),
                         Expanded(
                          child: _buildMenuButton("Edit Profile", false, () async {
                             final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                    userName: _currentUserName,
                                  ),
                                ),
                              );
                              
                              if (result != null && result is String) {
                                setState(() {
                                  _currentUserName = result;
                                });
                              }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(32, 20, 32, 120), // Bottom padding for fixed buttons
                    children: _selectedTabIndex == 0 
                      ? _buildAboutMeContent() 
                      : _buildKelasContent(),
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Elements
           if (_selectedTabIndex == 0) // Only show logout on About Me? Design is ambiguous but usually logout is accessible or specific to profile. Let's keep it.
           Positioned(
            bottom: 110,
            right: 24,
            child: ElevatedButton.icon(
              onPressed: () {
                 // Logout logic here
              },
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              label: Text(
                'Log Out', 
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB94141),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
            ),
          ),
          
          // Bottom Nav Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFB94141),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, "Home", false),
                  _buildNavItem(Icons.school_rounded, "Kelas Saya", _selectedTabIndex == 1), // Highlight if tab is Kelas
                  _buildNavItem(Icons.notifications_rounded, "Notifikasi", true),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildAboutMeContent() {
    return [
      _buildSectionHeader("Informasi User"),
      const SizedBox(height: 20),
      _buildInfoItem("Email address", "dandycandra@365.telkomuniversity.ac.id"),
      const SizedBox(height: 20),
      _buildInfoItem("Program Studi", "D4 Teknologi Rekayasa Multimedia"),
      const SizedBox(height: 20),
      _buildInfoItem("Fakultas", "FIT"),

      const SizedBox(height: 32),

      _buildSectionHeader("Aktivitas Login"),
      const SizedBox(height: 20),
      _buildInfoItem("First access to site", "Monday, 7 September 2020, 9:27 AM", suffix: "(288 days 12 hours)"),
      const SizedBox(height: 20),
      _buildInfoItem("Last access to site", "Tuesday, 22 June 2021, 9:44 PM", suffix: "(now)"),
    ];
  }

  List<Widget> _buildKelasContent() {
    final classes = [
      {"name": "Mobile App Development: Business and Scientific D4SM-41-GAB1 [ARS]", "date": "Monday, 8 February 2021"},
      {"name": "Desain Antarmuka & Pengalaman Pengguna D4SM-42-03 [ADY]", "date": "Monday, 8 February 2021"},
      {"name": "Kewarganegaraan D4SM-41-GAB1 [BBO]. JUMAT 2", "date": "Monday, 8 February 2021"},
      {"name": "Olah Raga D3TT-44-02 [EYR]", "date": "Monday, 8 February 2021"},
      {"name": "Pemrograman Multimedia Interaktif D4SM-43-04 [TPR]", "date": "Monday, 8 February 2021"},
      {"name": "Pemrograman Perangkat Bergerak Multimedia D4SM-41-GAB1 [APJ]", "date": "Monday, 8 February 2021"},
      {"name": "Sistem Operasi D4SM-44-02 [DDS]", "date": "Monday, 8 February 2021"},
    ];

    return classes.map((c) => _buildClassItem(c["name"]!, c["date"]!)).toList();
  }

  Widget _buildClassItem(String name, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF7FB5D9), // icon-blue
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[900], // text-gray-800
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tanggal Mulai $date",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[500], // text-muted-light
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Colors.transparent, // Hit test
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isActive ? Colors.grey[900] : Colors.grey[500],
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 8),
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            ] else 
              const SizedBox(height: 12), // Placeholder height
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[900],
            ),
            children: [
              TextSpan(text: value),
              if (suffix != null) ...[
                const TextSpan(text: " "),
                TextSpan(
                  text: suffix,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool hasBadge) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            if (hasBadge)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.amber[400],
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFB94141), width: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
          ),
        ),
      ],
    );
  }
}
