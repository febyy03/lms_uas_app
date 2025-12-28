import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'quiz_result_screen.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String quizTitle;
  final int totalQuestions;
  final int timeLimitMinutes;

  const QuizQuestionScreen({
    super.key,
    this.quizTitle = 'Quiz Review 1',
    this.totalQuestions = 15,
    this.timeLimitMinutes = 15,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  // Theme colors from HTML
  static const Color primaryColor = Color(0xFFBA4A4A);
  static const Color secondaryColor = Color(0xFFF26D6D);
  
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B); // Zinc 900
  
  static const Color cardLight = Color(0xFFF3F4F6); // Gray 100
  static const Color cardDark = Color(0xFF27272A); // Zinc 800
  
  static const Color questionNavGreen = Color(0xFF22C55E); // Green 500

  int _currentQuestion = 2; // Default to 2 to match HTML screenshot example initially, but logic allows 1
  Map<int, int> _answers = {}; // questionIndex -> selectedAnswerIndex
  int _remainingSeconds = 15 * 60;
  Timer? _timer;

  // Sample data to match HTML
  final List<QuizQuestion> _questions = List.generate(15, (index) {
    if (index == 1) {
      // Question 2 from HTML
      return QuizQuestion(
        text: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        options: ['Intergrasi', 'Standarisasi', 'Konsistensi', 'Koefensi', 'Koreksi'],
        correctAnswer: 2,
      );
    }
    return QuizQuestion(
      text: 'Pertanyaan sample nomor ${index + 1} untuk testing visual layout.',
      options: ['Pilihan A', 'Pilihan B', 'Pilihan C', 'Pilihan D', 'Pilihan E'],
      correctAnswer: 0,
    );
  });

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timeLimitMinutes * 60;
    _currentQuestion = 1; // Start at 1 normally
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _submitQuiz();
      }
    });
  }

  void _submitQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const QuizResultScreen(),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentQuestionData = _questions[_currentQuestion - 1];
    final selectedAnswer = _answers[_currentQuestion];

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      body: Column(
        children: [
          // Header
          _buildHeader(),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Navigation Grid
                    _buildNavGrid(isDark),
                    const SizedBox(height: 32),
                    
                    // Question Header
                    _buildQuestionHeader(isDark),
                    const SizedBox(height: 32),
                    
                    // Question Text
                    Text(
                      currentQuestionData.text,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                        color: isDark ? Colors.grey[200] : Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Options
                    _buildOptionsList(currentQuestionData, selectedAnswer, isDark),
                    const SizedBox(height: 40),
                    
                    // Footer Buttons
                    _buildFooterButtons(isDark),
                    const SizedBox(height: 20),
                  ],
                ),
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
      padding: const EdgeInsets.only(top: 48, bottom: 16, left: 24, right: 24),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 64), // Balancing spacer
          Text(
            widget.quizTitle,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.schedule_outlined, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text(
                  _formatTime(_remainingSeconds),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavGrid(bool isDark) {
    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: List.generate(widget.totalQuestions, (index) {
          final qNum = index + 1;
          // Example logic: qNum 1 is "done" (green), others white/dark
          bool isDone = qNum == 1; // Just mimicking HTML example
          if (_answers.containsKey(qNum)) isDone = true;

          return Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDone 
                  ? questionNavGreen 
                  : (isDark ? cardDark : Colors.white),
              border: Border.all(
                color: isDone
                   ? Colors.green[600]!
                   : (isDark ? Colors.grey[600]! : Colors.grey[800]!),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              '$qNum',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDone 
                    ? Colors.black 
                    : (isDark ? Colors.grey[100] : Colors.grey[900]),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuestionHeader(bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Soal Nomor $_currentQuestion ',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          '/ ${widget.totalQuestions}',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[400] : Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsList(QuizQuestion question, int? selectedAnswer, bool isDark) {
    final letters = ['A', 'B', 'C', 'D', 'E'];
    
    return Column(
      children: question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = selectedAnswer == index;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              setState(() {
                _answers[_currentQuestion] = index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected 
                    ? secondaryColor 
                    : (isDark ? cardDark : cardLight),
                borderRadius: BorderRadius.circular(12),
                border: isSelected 
                   ? Border.all(color: secondaryColor, width: 2)
                   : null,
                boxShadow: isSelected 
                   ? [
                       const BoxShadow(
                         color: Colors.black12,
                         blurRadius: 15,
                         offset: Offset(0, 4),
                       )
                     ]
                   : [
                       const BoxShadow(
                         color: Colors.black12,
                         blurRadius: 2,
                         offset: Offset(0, 1),
                       )
                   ],
              ),
              child: Row(
                children: [
                  Text(
                    '${letters[index]}.  ',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooterButtons(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _currentQuestion > 1 
                ? () => setState(() => _currentQuestion--)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? cardDark : cardLight,
              foregroundColor: isDark ? Colors.grey[200] : Colors.grey[800],
              elevation: 1,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Soal Sebelum nya.',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_currentQuestion < widget.totalQuestions) {
                setState(() => _currentQuestion++);
              } else {
                _submitQuiz();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? cardDark : cardLight,
              foregroundColor: isDark ? Colors.grey[200] : Colors.grey[800],
              elevation: 1,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _currentQuestion < widget.totalQuestions 
                  ? 'Soal Selanjutnya.' 
                  : 'Submit Quiz',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class QuizQuestion {
  final String text;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}
