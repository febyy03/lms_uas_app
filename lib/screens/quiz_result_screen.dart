import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizResultScreen extends StatelessWidget {
  final String startedAt;
  final String finishedAt;
  final String duration;
  final int score;
  final int maxScore;
  final List<QuizAnswerItem> answers;

  const QuizResultScreen({
    super.key,
    this.startedAt = 'Kamis 25 Februari 2021 10:25',
    this.finishedAt = 'Kamis 25 Februari 2021 10:40',
    this.duration = '13 Menit 22 Detik',
    this.score = 85,
    this.maxScore = 100,
    this.answers = const [],
  });

  // Theme colors
  static const Color primaryColor = Color(0xFFBE4D4D);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color cardLight = Color(0xFFF3F4F6);
  static const Color cardDark = Color(0xFF1F2937);
  static const Color boxLight = Color(0xFFCFD4DA);
  static const Color boxDark = Color(0xFF374151);
  static const Color actionGreen = Color(0xFF3AE23A);

  // Sample answers
  List<QuizAnswerItem> get _answers => answers.isNotEmpty
      ? answers
      : [
          QuizAnswerItem(
            questionNumber: 1,
            questionText: 'Radio button dapat digunakan untuk menentukan ?',
            answer: 'A. Jenis Kelamin',
          ),
          QuizAnswerItem(
            questionNumber: 2,
            questionText: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
            answer: 'B. Konsistensi',
          ),
          QuizAnswerItem(
            questionNumber: 3,
            questionText: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
            answer: 'C. Konsistensi',
          ),
          QuizAnswerItem(
            questionNumber: 4,
            questionText: 'Radio button dapat digunakan untuk menentukan ?',
            answer: 'A. Jenis Kelamin',
          ),
          QuizAnswerItem(
            questionNumber: 5,
            questionText: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
            answer: 'C. Konsistensi',
          ),
          QuizAnswerItem(
            questionNumber: 6,
            questionText: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
            answer: 'C. Konsistensi',
          ),
          QuizAnswerItem(
            questionNumber: 7,
            questionText: 'Radio button dapat digunakan untuk menentukan ?',
            answer: 'A. Jenis Kelamin',
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
          _buildHeader(isDark),
          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
              child: Column(
                children: [
                  // Summary Card
                  _buildSummaryCard(isDark),
                  const SizedBox(height: 32),
                  // Answers List
                  ..._answers.map((answer) => _buildAnswerItem(answer, isDark)),
                  const SizedBox(height: 48),
                  // Submit Button
                  _buildSubmitButton(context, isDark),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Review Jawaban',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? cardDark : cardLight,
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
          _buildSummaryRow('Di Mulai Pada', startedAt, isDark),
          const SizedBox(height: 8),
          _buildSummaryRow('Status', 'Selesai', isDark),
          const SizedBox(height: 8),
          _buildSummaryRow('Selesai Pada', finishedAt, isDark),
          const SizedBox(height: 8),
          _buildSummaryRow('Waktu Penyelesaian', duration, isDark),
          const SizedBox(height: 8),
          _buildSummaryRow('Nilai', '$score / $maxScore', isDark),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerItem(QuizAnswerItem answer, bool isDark) {
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
                'Pertanyaan ${answer.questionNumber}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Question Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Text Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? boxDark : boxLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    answer.questionText,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Answer and View Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Answer Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jawaban Tersimpan',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            answer.answer,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // View Link
                    GestureDetector(
                      onTap: () {
                        // Handle view question
                      },
                      child: Text(
                        'Lihat Soal',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1D4ED8),
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

  Widget _buildSubmitButton(BuildContext context, bool isDark) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Submit and go back to QuizReviewScreen
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: actionGreen,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: actionGreen.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Kirim Jawaban',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class QuizAnswerItem {
  final int questionNumber;
  final String questionText;
  final String answer;

  const QuizAnswerItem({
    required this.questionNumber,
    required this.questionText,
    required this.answer,
  });
}
