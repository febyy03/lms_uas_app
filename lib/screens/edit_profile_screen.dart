import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;

  const EditProfileScreen({super.key, required this.userName});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Split name for demo purposes, robust apps might handle this differently
    final nameParts = widget.userName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    
    // Default values for other fields as they aren't passed in
    _emailController = TextEditingController(text: "");
    _countryController = TextEditingController(text: "");
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

  void _saveProfile() {
    final String fullName = "${_firstNameController.text} ${_lastNameController.text}".trim();
    Navigator.pop(context, fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // background-light
      body: Stack(
        children: [
           // Header Background (Similar to ProfileScreen but simpler/shorter?)
          // Design shows a similar header.
           Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280, 
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
                        width: 112,
                        height: 112,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB94141), // Matches background
                          border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                          boxShadow: [
                             BoxShadow(color: Colors.black26, blurRadius: 10)
                          ]
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 60,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                       Text(
                        "${_firstNameController.text} ${_lastNameController.text}".toUpperCase(),
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

                 // Tab Area (Visual only as per design)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _buildTabItem("About Me", false)),
                        Expanded(child: _buildTabItem("Kelas", false)),
                        Expanded(child: _buildTabItem("Edit Profile", true)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Form
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                    children: [
                       _buildInputField("Nama", _firstNameController),
                       const SizedBox(height: 16),
                       _buildInputField("NPM", _emailController, inputType: TextInputType.emailAddress),
                       const SizedBox(height: 16),
                       _buildInputField("Fakultas", _countryController),
                       const SizedBox(height: 16),
                       _buildInputField("Deskripsi", _descriptionController, maxLines: 5),  
                       const SizedBox(height: 32),
                       
                       Align(
                         alignment: Alignment.centerRight,
                         child: ElevatedButton(
                           onPressed: _saveProfile,
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.grey[100], // bg-gray-100
                             foregroundColor: Colors.grey[900], // text-gray-900
                             elevation: 0,
                             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                           ),
                           child: Text(
                             'Simpan',
                             style: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                         ),
                       ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Nav (Visual mock only)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
             child: Container(
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFFB94141),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home_rounded, "Home"),
                  _buildNavItem(Icons.school_rounded, "Kelas Saya"),
                  _buildNavItem(Icons.notifications_rounded, "Notifikasi"),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildTabItem(String label, bool isActive) {
     return Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Text(
           label,
           style: GoogleFonts.poppins(
             fontSize: 13,
             fontWeight: FontWeight.w500,
             color: isActive ? Colors.grey[900] : Colors.grey[500], // dark:text-white vs gray-400
           ),
         ),
         if (isActive)
           Container(
             margin: const EdgeInsets.only(top: 6),
             width: 32,
             height: 4,
             decoration: BoxDecoration(
               color: Colors.grey[500], // gray-500/50
               borderRadius: BorderRadius.circular(2),
             ),
           )
       ],
     );
  }

  Widget _buildInputField(String label, TextEditingController controller, {int maxLines = 1, TextInputType? inputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: inputType,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[900]),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB94141), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 10, // text-[10px]
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
