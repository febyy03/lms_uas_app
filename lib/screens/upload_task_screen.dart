import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadTaskScreen extends StatefulWidget {
  const UploadTaskScreen({super.key});

  @override
  State<UploadTaskScreen> createState() => _UploadTaskScreenState();
}

class _UploadTaskScreenState extends State<UploadTaskScreen> {
  // Theme colors
  static const Color primaryColor = Color(0xFFEE2B2B);
  static const Color primaryDark = Color(0xFFC91E1E);
  static const Color backgroundLight = Color(0xFFF8F6F6);
  static const Color backgroundDark = Color(0xFF221010);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2D1B1B);
  static const Color borderLight = Color(0xFFE6DBDB);
  static const Color borderDark = Color(0xFF4A3535);
  static const Color textMainLight = Color(0xFF181111);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textSecLight = Color(0xFF896161);
  static const Color textSecDark = Color(0xFFBCA3A3);

  // Sample file data
  final List<UploadFile> _selectedFiles = [
    UploadFile(
      name: 'Tugas_Akhir_Semester.pdf',
      size: '2.4 MB',
      type: FileType.pdf,
      status: UploadStatus.ready,
    ),
    UploadFile(
      name: 'Lampiran_Referensi_Jurnal.docx',
      size: '1.2 MB',
      type: FileType.docx,
      status: UploadStatus.uploading,
      progress: 0.45,
    ),
  ];

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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload Drop Zone
                  _buildUploadZone(isDark),
                  const SizedBox(height: 8),
                  // Helper Text
                  Center(
                    child: Text(
                      'Format yang didukung: PDF, DOCX, PPTX (Maks 10MB)',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: isDark ? textSecDark : textSecLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Selected Files Section
                  _buildSelectedFilesSection(isDark),
                ],
              ),
            ),
          ),
          // Footer
          _buildFooter(isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      color: isDark ? surfaceDark : surfaceLight,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surfaceLight,
            border: Border(
              bottom: BorderSide(
                color: isDark ? borderDark : borderLight,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: isDark ? textMainDark : textMainLight,
                    size: 24,
                  ),
                ),
              ),
              // Title
              Expanded(
                child: Text(
                  'Tambahkan Tugas',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? textMainDark : textMainLight,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Spacer for symmetry
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadZone(bool isDark) {
    return GestureDetector(
      onTap: () {
        // Handle file picker
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          color: isDark ? surfaceDark : surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? borderDark : borderLight,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            // Icon Circle
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              'Upload File Anda',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? textMainDark : textMainLight,
              ),
            ),
            const SizedBox(height: 4),
            // Subtitle
            Text(
              'Tap untuk mencari file atau drag & drop file ke sini',
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: isDark ? textSecDark : textSecLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Browse Button
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isDark ? borderDark : backgroundLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.grey.shade600 : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Browse Files',
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? textMainDark : textMainLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFilesSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'FILE TERPILIH',
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? textSecDark : textSecLight,
              letterSpacing: 1,
            ),
          ),
        ),
        // File Items
        ..._selectedFiles.map((file) => _buildFileItem(file, isDark)),
      ],
    );
  }

  Widget _buildFileItem(UploadFile file, bool isDark) {
    final isUploading = file.status == UploadStatus.uploading;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // File Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getFileIconColor(file.type, isDark),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getFileIcon(file.type),
                  color: _getFileIconForeground(file.type),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // File Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? textMainDark : textMainLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    if (isUploading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mengupload... ${(file.progress! * 100).toInt()}%',
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            file.size,
                            style: GoogleFonts.lexend(
                              fontSize: 12,
                              color: isDark ? textSecDark : textSecLight,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        '${file.size} • Siap diupload',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          color: isDark ? textSecDark : textSecLight,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Remove Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFiles.remove(file);
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: isDark ? textSecDark : textSecLight,
                  ),
                ),
              ),
            ],
          ),
          // Progress Bar
          if (isUploading) ...[
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: isDark ? borderDark : backgroundLight,
                borderRadius: BorderRadius.circular(3),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        width: constraints.maxWidth * file.progress!,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getFileIconColor(FileType type, bool isDark) {
    switch (type) {
      case FileType.pdf:
        return isDark ? const Color(0xFF7F1D1D).withOpacity(0.2) : const Color(0xFFFEF2F2);
      case FileType.docx:
        return isDark ? const Color(0xFF1E3A5F).withOpacity(0.2) : const Color(0xFFEFF6FF);
      case FileType.pptx:
        return isDark ? const Color(0xFF7C2D12).withOpacity(0.2) : const Color(0xFFFFF7ED);
    }
  }

  Color _getFileIconForeground(FileType type) {
    switch (type) {
      case FileType.pdf:
        return primaryColor;
      case FileType.docx:
        return const Color(0xFF2563EB);
      case FileType.pptx:
        return const Color(0xFFEA580C);
    }
  }

  IconData _getFileIcon(FileType type) {
    switch (type) {
      case FileType.pdf:
        return Icons.picture_as_pdf;
      case FileType.docx:
        return Icons.description_outlined;
      case FileType.pptx:
        return Icons.slideshow_outlined;
    }
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? borderDark : borderLight,
            width: 1,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle submit
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primaryColor.withOpacity(0.3),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send, size: 20),
            const SizedBox(width: 8),
            Text(
              'Kirim Tugas',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FileType { pdf, docx, pptx }

enum UploadStatus { ready, uploading, completed, error }

class UploadFile {
  final String name;
  final String size;
  final FileType type;
  final UploadStatus status;
  final double? progress;

  UploadFile({
    required this.name,
    required this.size,
    required this.type,
    required this.status,
    this.progress,
  });
}
