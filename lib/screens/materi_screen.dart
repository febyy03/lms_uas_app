import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MateriScreen extends StatefulWidget {
  final String title;

  const MateriScreen({super.key, required this.title});

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  int _selectedTabIndex = 0; // 0: Lampiran Materi, 1: Tugas dan Kuis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                   InkWell(
                     onTap: () => Navigator.pop(context),
                     child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 16),
                  
                  // Description Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik. Pelajaran mengenai prinsip UID ini sudah pernah diajarkan dalam mata kuliah Implementasi Desain Antarmuka Pengguna tetap pada matakuliah ini akan direview kembali sehingga dapat menjadi bekal saat memasukki materi mengenai User Experience',
                          style: GoogleFonts.poppins(
                            fontSize: 14, 
                            height: 1.6,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedTabIndex = 0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Lampiran Materi',
                                    style: GoogleFonts.poppins(
                                      fontWeight: _selectedTabIndex == 0 ? FontWeight.w600 : FontWeight.w500,
                                      color: _selectedTabIndex == 0 ? Colors.black : Colors.grey[500],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 4,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: _selectedTabIndex == 0 ? Colors.black : Colors.transparent,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedTabIndex = 1),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Tugas dan Kuis',
                                    style: GoogleFonts.poppins(
                                      fontWeight: _selectedTabIndex == 1 ? FontWeight.w600 : FontWeight.w500,
                                      color: _selectedTabIndex == 1 ? Colors.black : Colors.grey[500],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 4,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: _selectedTabIndex == 1 ? Colors.black : Colors.transparent,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: _selectedTabIndex == 0 ? _buildMateriContent() : _buildTugasContent(),
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriContent() {
    return Column(
      children: [
        _buildAttachmentItem(Icons.link, "Zoom Meeting Syncronous", true, isLink: true),
        _buildAttachmentItem(Icons.description_outlined, "Pengantar User Interface Design", false),
        _buildAttachmentItem(Icons.description_outlined, "Empat Teori Dasar Antarmuka Pengguna", false),
        _buildAttachmentItem(Icons.description_outlined, "Empat Teori Dasar Antarmuka Pengguna", true),
        _buildAttachmentItem(Icons.video_file_outlined, "User Interface Design for Beginner", true),
        _buildAttachmentItem(Icons.link, "20 Prinsip Desain", true, isLink: true),
        _buildAttachmentItem(Icons.link, "Best Practice UI Design", true, isLink: true),
      ],
    );
  }

  Widget _buildTugasContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Container(
          width: 256,
          height: 256,
          decoration: const BoxDecoration(
            // Since we can't depend on external assets easily without network, 
            // relying on the network image provided in the prompt.
            // If offline, this might need a local asset fallback, but for now using the URL.
          ),
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuANd6k-quSjX93k7w5giGjJtSR__h_Alygumg-lZoeQ7Lv8GcINYurBGKEClE6VH4TT7R0YRNSpm7XNH8wM9IYVr6TLW29DK4stAT9OLhQNZYbXQvJ0NhdUQ1Z_T5WsihGWIcmcR7Nb6NKD6cc8vN17H0EZCBpSyQEkt6FFLx1nbTcKsOC1Z20M9XXbr6g6LqVDKx1IlX_0yCJHXO3SnCh8GsEr4QC7RRcZIMETYpKzc1VnHG78ZSKQXWPsdhXwPL4sMy5wBqCD3gk',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => 
               const Icon(Icons.task_alt, size: 100, color: Colors.grey),
          ),
        ),
         const SizedBox(height: 16),
        Text(
          'Tidak Ada Tugas Dan Kuis Hari Ini',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAttachmentItem(IconData icon, String title, bool isCompleted, {bool isLink = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.grey[800],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.check_circle,
            color: isCompleted ? const Color(0xFF22C55E) : Colors.grey[300],
            size: 24,
          ),
        ],
      ),
    );
  }
}
