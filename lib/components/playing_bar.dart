import 'dart:math';

import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class PlayingBar extends StatefulWidget {
  final int duration; // thời gian tăng chiều rộng (tính bằng giây)
  final String musicName;
  final String artistName;
  final String musicImg;
  const PlayingBar({super.key, required this.duration, required this.musicName, required this.artistName, required this.musicImg});

  @override
  State<PlayingBar> createState() => _PlayingBarState();
}

class _PlayingBarState extends State<PlayingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isPlaying = false;
  double _currentValue = 0;

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
          });
        }
      });

    // Khởi tạo _widthAnimation với một giá trị mặc định
    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  void _togglePlayPause(double maxWidth) {
    setState(() {
      if (_isPlaying) {
        _currentValue = _controller.value; // Lưu lại giá trị hiện tại
        _controller.stop();
      } else {
        if (_currentValue == 0) {
          // Nếu giá trị hiện tại là 0, bắt đầu lại từ đầu
          _widthAnimation =
              Tween<double>(begin: 0, end: maxWidth).animate(_controller)
                ..addListener(() {
                  setState(() {});
                });
          _controller.forward(from: 0);
        } else {
          _controller.forward(
              from: _currentValue); // Tiếp tục từ giá trị đã lưu
        }
      }
      _isPlaying = !_isPlaying;
    });
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            color: _getRandomDarkColor(),
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
                            color: blueColor,
                            image: DecorationImage(
                              image: AssetImage(widget.musicImg)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5, // Giới hạn chiều rộng
                                child: Text(
                                  widget.musicName,
                                  style: changeTextColor(robotoBlack14, whiteColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5, // Giới hạn chiều rộng
                                child: Text(
                                  widget.artistName,
                                  style: changeTextColor(robotoRegular14, lightGrayColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.tv,
                            size: 30, color: lightGrayColor),
                        const SizedBox(width: 10),
                        const Icon(Icons.add_circle_outline_rounded,
                            size: 30, color: lightGrayColor),
                        GestureDetector(
                          onTap: () {
                            _togglePlayPause(
                                MediaQuery.of(context).size.width - 40);
                          },
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                            size: 35,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
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
