import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/audio_provider.dart';
import 'package:melodify_app_project/pages/playing_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:provider/provider.dart';

class PlayingBar extends StatefulWidget {
  final int duration;
  final Function(bool isPlaying) onPlayPause;
  final String songName;
  final String artistName;
  final String musicImg;

  const PlayingBar({
    super.key,
    required this.duration,
    required this.onPlayPause,
    required this.songName,
    required this.artistName,
    required this.musicImg,
  });

  @override
  State<PlayingBar> createState() => _PlayingBarState();
}

class _PlayingBarState extends State<PlayingBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isPlaying = false;
  double _currentValue = 0;
  Timer? _timer; // Changed to Timer? for null safety
  int _elapsedSeconds = 0;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isPlaying = false;
            widget.onPlayPause(_isPlaying); // Notify that playback has stopped
          });
        }
      });

    _selectedColor = _getRandomDarkColor();
    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void didUpdateWidget(PlayingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songName != widget.songName ||
        oldWidget.artistName != widget.artistName ||
        oldWidget.musicImg != widget.musicImg) {
      setState(() {
        _selectedColor = _getRandomDarkColor();
        _controller.reset();
        _isPlaying = false;
        _currentValue = 0;
      });
    }
  }

  void _togglePlayPause(double maxWidth) {
    setState(() {
      if (_isPlaying) {
        _currentValue = _controller.value;
        _controller.stop();
        _timer?.cancel(); // Safely cancel the timer
      } else {
        if (_currentValue == 0) {
          _widthAnimation = Tween<double>(begin: 0, end: maxWidth).animate(_controller)
            ..addListener(() {
              setState(() {});
            });
          _controller.forward(from: 0);
          _startTimer();
        } else {
          _controller.forward(from: _currentValue);
          _startTimer(resume: true);
        }
      }
      _isPlaying = !_isPlaying;
      widget.onPlayPause(_isPlaying);
    });
  }

  void _startTimer({bool resume = false}) {
    if (!resume) {
      _elapsedSeconds = 0;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds >= widget.duration) {
          _timer?.cancel(); // Safely cancel the timer
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); // Safely cancel the timer
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  Color _getRandomDarkColor() {
    final Random random = Random();
    const int maxColorValue = 150;
    return Color.fromARGB(
      255,
      random.nextInt(maxColorValue),
      random.nextInt(maxColorValue),
      random.nextInt(maxColorValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayingMusicPage(
              musicName: widget.songName,
              artist: widget.artistName,
              image: widget.musicImg,
              duration: widget.duration,
              onPlayPause: (bool isPlaying) => {
                if (isPlaying) {
                  context.read<AudioProvider>().resumeAudio()
                } else {
                  context.read<AudioProvider>().stopAudio()
                }
              },
            ),
          ),
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: _selectedColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(widget.musicImg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.songName,
                                  style: changeTextColor(robotoBlack14, whiteColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.artistName, // hiển thị tên nghệ sĩ
                                  style: changeTextColor(robotoRegular14, lightGrayColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.tv, size: 30, color: lightGrayColor),
                          const SizedBox(width: 10),
                          const Icon(Icons.add_circle_outline_rounded, size: 30, color: lightGrayColor),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              _togglePlayPause(MediaQuery.of(context).size.width - 40);
                            },
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                              size: 35,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (_widthAnimation.value == 0) {
                        _widthAnimation = Tween<double>(begin: 0, end: constraints.maxWidth).animate(_controller)
                          ..addListener(() {
                            setState(() {});
                          });
                      }
                      return Stack(
                        children: [
                          Container(
                            height: 2,
                            color: whiteLowOpacity,
                          ),
                          Container(
                            width: _widthAnimation.value,
                            height: 2,
                            color: whiteColor,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
