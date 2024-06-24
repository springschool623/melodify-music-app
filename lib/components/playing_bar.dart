import 'package:flutter/material.dart';

class PlayingBar extends StatefulWidget {
  final int duration; // thời gian tăng chiều rộng (tính bằng giây)
  const PlayingBar({super.key, required this.duration});

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
            color: const Color.fromRGBO(39, 138, 152, 1),
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
                            color: Colors.blue,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bật Nhạc Lên",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoBlackFont'),
                              ),
                              Text(
                                "HIEUTHUHAI",
                                style: TextStyle(
                                    color: Color.fromRGBO(207, 207, 207, 1),
                                    fontSize: 14,
                                    fontFamily: 'RobotoRegularFont'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.tv,
                            size: 30, color: Color.fromRGBO(207, 207, 207, 1)),
                        const SizedBox(width: 10),
                        const Icon(Icons.add_circle_outline_rounded,
                            size: 30, color: Color.fromRGBO(207, 207, 207, 1)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            _togglePlayPause(
                                MediaQuery.of(context).size.width - 40);
                          },
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                            size: 35,
                            color: const Color.fromRGBO(255, 255, 255, 1),
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
                          color: const Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                        Container(
                          width: _widthAnimation.value,
                          height: 2,
                          color: const Color.fromRGBO(255, 255, 255, 1),
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
