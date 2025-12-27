import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'upload_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskTitle;
  final String? fileName;
  final bool isSubmitted;

  const TaskDetailScreen({
    super.key,
    this.taskTitle = 'Tugas 01 - UID Android Mobile Game',
    this.fileName,
    this.isSubmitted = true,
  });

  // Theme colors
  static const Color primaryColor = Color(0xFFBE4B4B);
  static const Color primaryDark = Color(0xFF9E3C3C);
  static const Color statusHeaderLight = Color(0xFFF07878);
  static const Color statusHeaderDark = Color(0xFF8A3636);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFF8F9FA);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFF333333);
  static const Color textDark = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header
          _buildHeader(context, isDark),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 512),
                child: Column(
                  children: [
                    // Task Instructions
                    _buildTaskInstructions(isDark),
                    // Status Section
                    _buildStatusSection(isDark),
                    // Add Task Button
                    _buildAddTaskButton(isDark),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Title
              Expanded(
                child: Text(
                  taskTitle,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskInstructions(bool isDark) {
    final instructions = [
      'Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.',
      'Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi dibuka sampai ditutup kembali, serta desain untuk tampilan-tampilan fungsi yang mendukung permainan seperti pop-up, alert, chat, dan lain-lain.',
      'Desain bisa dibuat menggunakan aplikasi khusus desain atau secara manual dengan tetap menjunjung kerapihan dan kejelasan setiap elemen dalam desain.',
      'Berikan identitas aplikasi game yang dibuat, seperti Nama Game, Genre, dan Platform. Serta berikan penjelasan pada setiap elemen pada desain, seperti gambar, teks, tombol, icon, dan lain-lain.',
      'File dikumpulkan dalam format .PDF dengan size maksimal 5MB.',
      'Tugas dikumpulkan paling lambat hari\nJum\'at, 26 Februari 2021 jam 23:59 WIB\n(akan tertutup otomatis) dan akan dipresentasikan pada pertemuan selanjutnya via Zoom Meeting.',
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: instructions.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final text = entry.value;
          return _buildInstructionItem(index, text, isDark);
        }).toList(),
      ),
    );
  }

  Widget _buildInstructionItem(int number, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$number.',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Status Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? statusHeaderDark : statusHeaderLight,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Status Tugas',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          // Status Rows
          Container(
            decoration: BoxDecoration(
              color: isDark ? surfaceDark : surfaceLight,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _buildStatusRow(
                  label: 'Status',
                  value: 'Sudah Mengirim untuk di nilai',
                  isDark: isDark,
                  isOdd: false,
                ),
                _buildStatusRow(
                  label: 'Status Nilai',
                  value: 'Belum Di nilai',
                  isDark: isDark,
                  isOdd: true,
                ),
                _buildStatusRow(
                  label: 'Batas tanggal',
                  value: 'Jumat, 26 Februari 2021, 23:59 WIB',
                  isDark: isDark,
                  isOdd: false,
                ),
                _buildStatusRow(
                  label: 'Sisa Waktu',
                  value: 'Tugas sudah di kirim 4 Hari 6 Jam Sebelum nya',
                  valueColor: isDark ? const Color(0xFF4ADE80) : const Color(0xFF16A34A),
                  isDark: isDark,
                  isOdd: true,
                ),
                _buildFileRow(
                  label: 'File Tugas',
                  fileName: fileName ?? 'Dandy Candra Pratama_7708170114.pdf',
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow({
    required String label,
    required String value,
    Color? valueColor,
    required bool isDark,
    required bool isOdd,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOdd
            ? (isDark ? Colors.black.withOpacity(0.2) : Colors.grey.shade50)
            : (isDark ? surfaceDark : Colors.white),
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: valueColor != null ? FontWeight.w500 : FontWeight.w400,
                color: valueColor ?? (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileRow({
    required String label,
    required String fileName,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.description_outlined,
            size: 20,
            color: isDark ? const Color(0xFFF87171) : primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Handle file tap - open/download file
              },
              child: Text(
                fileName,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDark ? const Color(0xFFF87171) : primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Center(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UploadTaskScreen(),
                ),
              );
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Tambahkan Tugas',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ),
      ),
    );
  }
}
