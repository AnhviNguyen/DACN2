import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../learning_sidebar.dart' show LessonItem;

class LearningContentVideo extends StatefulWidget {
  const LearningContentVideo({
    super.key,
    required this.lesson,
  });

  final LessonItem lesson;

  @override
  State<LearningContentVideo> createState() => _LearningContentVideoState();
}

class _LearningContentVideoState extends State<LearningContentVideo> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    // TODO: Thay thế bằng video URL từ API
    // _initializeVideo('https://example.com/video.mp4');
  }

  void _initializeVideo(String videoUrl) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller?.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video Player
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _controller != null && _controller!.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller!),
                      // Play/Pause overlay
                      if (!_isPlaying)
                        IconButton(
                          icon: Icon(
                            Icons.play_circle_filled,
                            size: 64,
                            color: colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPlaying = true;
                              _controller?.play();
                            });
                          },
                        ),
                      // Video controls overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _isMuted ? Icons.volume_off : Icons.volume_up,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isMuted = !_isMuted;
                                        _controller?.setVolume(_isMuted ? 0.0 : 1.0);
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  // Progress bar placeholder
                                  Container(
                                    width: 100,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colorScheme.primary,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  // TODO: Implement fullscreen
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    // Placeholder khi chưa có video
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Video bài giảng',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 16),

        // Lesson info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.lesson.title,
                style: theme.textTheme.headlineSmall,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.black,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.lesson.duration,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}