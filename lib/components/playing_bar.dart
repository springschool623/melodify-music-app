import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class PlayingBar extends StatefulWidget {
  final int duration; // thời gian tăng chiều rộng (tính bằng giây)
  final Function(bool isPlaying) onPlayPause;
  final String songName;
  final String artistName; // thêm tham số artistName
  final String musicImg;

  const PlayingBar({
    super.key,
    required this.duration,
    required this.onPlayPause,
    required this.songName,
    required this.artistName,
    required this.musicImg, // thêm tham số artistName
  });

  @override
  State<PlayingBar> createState() => _PlayingBarState();
}

class _PlayingBarState extends State<PlayingBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isPlaying = false;
  double _currentValue = 0;
  late Timer _timer;
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

    // Chọn màu ngẫu nhiên cho bài nhạc
    _selectedColor = _getRandomDarkColor();

    // Khởi tạo _widthAnimation với một giá trị mặc định
    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);

    // Initialize _timer with a dummy timer
    _timer = Timer(Duration.zero, () {});
  }

  //Update màu sắc khi bấm sang nhạc khác
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
        _currentValue = _controller.value; // Lưu lại giá trị hiện tại
        _controller.stop();
        _timer.cancel();
      } else {
        if (_currentValue == 0) {
          // Nếu giá trị hiện tại là 0, bắt đầu lại từ đầu
          _widthAnimation = Tween<double>(begin: 0, end: maxWidth).animate(_controller)
            ..addListener(() {
              setState(() {});
            });
          _controller.forward(from: 0);
          _startTimer();
        } else {
          _controller.forward(from: _currentValue); // Tiếp tục từ giá trị đã lưu
          _startTimer(resume: true);
        }
      }
      _isPlaying = !_isPlaying;
      widget.onPlayPause(_isPlaying); // Notify the current play/pause state
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
          _timer.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    _controller.reset();
    _timer.cancel();
    setState(() {
      _elapsedSeconds = 0;
      _currentValue = 0;
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  // Hàm để tạo màu ngẫu nhiên tối hơn
  Color _getRandomDarkColor() {
    final Random random = Random();
    const int maxColorValue = 150; // Giới hạn giá trị màu để tạo màu tối hơn
    return Color.fromARGB(
      255,
      random.nextInt(maxColorValue),
      random.nextInt(maxColorValue),
      random.nextInt(maxColorValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.songName,
                                style: changeTextColor(robotoBlack14, whiteColor),
                              ),
                              Text(
                                widget.artistName, // hiển thị tên nghệ sĩ
                                style: changeTextColor(robotoRegular14, lightGrayColor),
                              ),
                            ],
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
    );
  }
}
