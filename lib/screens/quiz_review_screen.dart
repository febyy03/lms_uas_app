import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizReviewScreen extends StatelessWidget {
  const QuizReviewScreen({super.key});

  // Theme colors from HTML
  static const Color primaryColor = Color(0xFFBE4D4D);
  static const Color primaryDark = Color(0xFF993D3D);
  
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF111827);
  
  static const Color cardLight = Color(0xFFF3F4F6);
  static const Color cardDark = Color(0xFF1F2937);
  
  static const Color boxLight = Color(0xFFCFD4DA);
  static const Color boxDark = Color(0xFF374151);
  
  static const Color actionGreen = Color(0xFF3AE23A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header
          _buildHeader(),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  // Summary Card
                  _buildSummaryCard(isDark),
                  const SizedBox(height: 32),
                  // Questions List
                  _buildQuestionList(isDark),
                  const SizedBox(height: 48),
                  // Submit Button
                  _buildSubmitButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 96,
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        'Review Jawaban',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool isDark) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? cardDark : cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Di Mulai Pada', 'Kamis 25 Februari 2021 10:25', isDark),
          _buildSummaryRow('Status', 'Selesai', isDark),
          _buildSummaryRow('Selesai Pada', 'Kamis 25 Februari 2021 10:40', isDark),
          _buildSummaryRow('Waktu Penyelesaian', '13 Menit 22 Detik', isDark),
          _buildSummaryRow('Nilai', '0 / 100', isDark),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[200] : Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionList(bool isDark) {
    final questions = [
      {
        'id': 1,
        'question': 'Radio button dapat digunakan untuk menentukan ?',
        'answer': 'A. Jenis Kelamin',
      },
      {
        'id': 2,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'B. Konsistensi',
      },
      {
        'id': 3,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'C. Konsistensi',
      },
      {
        'id': 4,
        'question': 'Radio button dapat digunakan untuk menentukan ?',
        'answer': 'A. Jenis Kelamin',
      },
      {
        'id': 5,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'C. Konsistensi',
      },
      {
        'id': 6,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'C. Konsistensi',
      },
      {
        'id': 7,
        'question': 'Radio button dapat digunakan untuk menentukan ?',
        'answer': 'A. Jenis Kelamin',
      },
    ];

    return Container(
       constraints: const BoxConstraints(maxWidth: 450),
       child: Column(
        children: questions.map((q) => _buildQuestionItem(q, isDark)).toList(),
       ),
    );
  }

  Widget _buildQuestionItem(Map<String, Object> data, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Number
          SizedBox(
            width: 96,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Pertanyaan ${data['id']}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey[100] : Colors.grey[900],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Box
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isDark ? boxDark : boxLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data['question'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ),
                // Answer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jawaban Tersimpan',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey[100] : Colors.grey[900],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data['answer'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isDark ? Colors.grey[300] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Lihat Soal',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.blue[400] : Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: actionGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          'Kirim Jawaban',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
