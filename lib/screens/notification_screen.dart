import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'course_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Theme colors from design
  static const Color primaryColor = Color(0xFF111827);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF09090B);
  static const Color surfaceLight = Color(0xFFF3F4F6);
  static const Color surfaceDark = Color(0xFF27272A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? backgroundDark : backgroundLight,
      appBar: AppBar(
        backgroundColor: (isDark ? backgroundDark : backgroundLight).withValues(alpha: 0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF111827),
            letterSpacing: -0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: isDark ? Colors.grey[800] : Colors.transparent,
            height: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: const [
          _NotificationItem(
            icon: Icons.assignment_outlined,
            message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
            time: '3 Hari 9 Jam Yang Lalu',
            delay: 0,
          ),
           SizedBox(height: 36),
          _NotificationItem(
            icon: Icons.chat_bubble_outline,
            message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
            time: '3 Hari 9 Jam Yang Lalu',
            delay: 100,
          ),
           SizedBox(height: 36),
          _NotificationItem(
            icon: Icons.assignment_outlined,
            message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
            time: '3 Hari 9 Jam Yang Lalu',
            delay: 200,
          ),
           SizedBox(height: 36),
          _NotificationItem(
            icon: Icons.chat_bubble_outline,
            message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
            time: '3 Hari 9 Jam Yang Lalu',
            delay: 300,
          ),
           SizedBox(height: 36),
          _NotificationItem(
            icon: Icons.assignment_outlined,
            message: 'Anda telah mengirimkan pengajuan tugas untuk Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
            time: '3 Hari 9 Jam Yang Lalu',
            delay: 400,
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatefulWidget {
  final IconData icon;
  final String message;
  final String time;
  final int delay;

  const _NotificationItem({
    required this.icon,
    required this.message,
    required this.time,
    required this.delay,
  });

  @override
  State<_NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<_NotificationItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.delay == 0) {
      _controller.forward();
    } else {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(
                widget.icon,
                size: 28,
                color: isDark ? Colors.grey[200] : const Color(0xFF111827),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[100] : const Color(0xFF111827),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.time,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
