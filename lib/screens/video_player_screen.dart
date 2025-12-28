import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoTitle;
  final String? thumbnailUrl;

  const VideoPlayerScreen({
    super.key,
    this.videoTitle = 'Video - User Interface Design For Beginner',
    this.thumbnailUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isPlaying = false;
  double progress = 0.33;

  // Theme colors
  static const Color primaryColor = Color(0xFFBD4B4B);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color surfaceLight = Color(0xFFF3F4F6);
  static const Color surfaceDark = Color(0xFF27272A);

  // Sample related videos
  final List<RelatedVideo> relatedVideos = [
    RelatedVideo(
      title: 'Interaction Design',
      duration: '3:42',
      thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCLbLFgy_nSiZRPsKKAIEfj_752Fuy57QrHRIN5fIh3ldnVRYDxtqPSz1wcG-jSURTuNt2lnT4imlmiu939zfcUtbLjP-gLZsx-51gNxvSuWoQQmCIgUPtxhr1NL2j80_iWIi4nbYcX8jhiO6nLk7iKpaIJXCnKAVNZXLD65DgwknVWCjluJrQkWGkyE-LxYE-J1RGA0bIN__NX5PChO7bzvZxntspLuiIjaIKu7VtFP_RFO0qO9DVk2t7-ErMgwImDuEaP_5Lr3fs',
    ),
    RelatedVideo(
      title: 'Pengantar Desain Antarmuka Pengguna',
      duration: '12:05',
      thumbnailType: ThumbnailType.telkom,
    ),
    RelatedVideo(
      title: '4 (empat) Teori Dasar Desain Antarmuka Pengguna',
      duration: '8:30',
      thumbnailType: ThumbnailType.teori,
    ),
    RelatedVideo(
      title: 'Tutorial Dasar Figma - UI/UX Design Software',
      duration: '15:10',
      thumbnailType: ThumbnailType.figma,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Player
                  _buildVideoPlayer(isDark),
                  // Other Videos Section
                  _buildOtherVideosHeader(isDark),
                  // Video List
                  _buildVideoList(isDark),
                  const SizedBox(height: 32),
                ],
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
      height: 64 + MediaQuery.of(context).padding.top,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Title
              Expanded(
                child: Text(
                  widget.videoTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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

  Widget _buildVideoPlayer(bool isDark) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          // Video Thumbnail/Background
          Container(
            color: Colors.black,
            child: widget.thumbnailUrl != null
                ? Image.network(
                    widget.thumbnailUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade900,
                        ],
                      ),
                    ),
                  ),
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Center Content (UI DESIGN text with play button)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'UI',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 8,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DES',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 8,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'IGN',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Video Controls at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(12, 32, 12, 8),
              child: Column(
                children: [
                  // Progress Bar
                  _buildProgressBar(),
                  const SizedBox(height: 8),
                  // Control Buttons Row
                  _buildControlButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final width = box.size.width - 24;
        setState(() {
          progress = (details.localPosition.dx / width).clamp(0.0, 1.0);
        });
      },
      child: Container(
        height: 16,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Background track
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Progress
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Thumb
            Positioned(
              left: (MediaQuery.of(context).size.width - 24) * progress - 6,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left controls
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 24,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_up,
                color: Colors.white,
                size: 24,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 12),
            Text(
              '0:00 / 5:51',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // Right controls
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.closed_caption,
                color: Colors.white70,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.white70,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.white70,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtherVideosHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: isDark ? backgroundDark : backgroundLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            width: 1,
          ),
        ),
      ),
      child: Text(
        'Video Lain Nya',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.grey.shade900,
        ),
      ),
    );
  }

  Widget _buildVideoList(bool isDark) {
    return Column(
      children: relatedVideos.asMap().entries.map((entry) {
        final index = entry.key;
        final video = entry.value;
        final isOdd = index % 2 == 0;
        return _buildVideoItem(video, isDark, isOdd);
      }).toList(),
    );
  }

  Widget _buildVideoItem(RelatedVideo video, bool isDark, bool isHighlighted) {
    return Material(
      color: isHighlighted
          ? (isDark ? surfaceDark : surfaceLight)
          : (isDark ? backgroundDark : backgroundLight),
      child: InkWell(
        onTap: () {
          // Navigate to video
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Thumbnail
              _buildVideoThumbnail(video, isDark),
              const SizedBox(width: 16),
              // Title
              Expanded(
                child: Text(
                  video.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade100 : Colors.grey.shade800,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail(RelatedVideo video, bool isDark) {
    return Container(
      width: 144,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail Content
          _buildThumbnailContent(video, isDark),
          // Play Icon Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white70,
                  size: 28,
                ),
              ),
            ),
          ),
          // Duration Badge
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                video.duration,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailContent(RelatedVideo video, bool isDark) {
    if (video.thumbnailUrl != null) {
      return Image.network(
        video.thumbnailUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.video_library, color: Colors.grey),
          );
        },
      );
    }

    switch (video.thumbnailType) {
      case ThumbnailType.telkom:
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red.shade500.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Universitas\nTelkom',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );

      case ThumbnailType.teori:
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red.shade500.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Text(
                  '4 Teori Dasar',
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    color: Colors.grey.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );

      case ThumbnailType.figma:
        return Container(
          color: Colors.green.shade900,
          child: Stack(
            children: [
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade500,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Figma Tutorial',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return Container(
          color: Colors.grey.shade300,
          child: const Icon(Icons.video_library, color: Colors.grey),
        );
    }
  }
}

enum ThumbnailType { image, telkom, teori, figma }

class RelatedVideo {
  final String title;
  final String duration;
  final String? thumbnailUrl;
  final ThumbnailType thumbnailType;

  RelatedVideo({
    required this.title,
    required this.duration,
    this.thumbnailUrl,
    this.thumbnailType = ThumbnailType.image,
  });
}
