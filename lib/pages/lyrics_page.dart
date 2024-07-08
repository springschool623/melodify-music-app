import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class LyricsPage extends StatefulWidget {
  final String musicName;
  final String artist;
  final int duration;
  const LyricsPage(
      {super.key,
      required this.musicName,
      required this.artist,
      required this.duration});

  static const String routeName = '/lyrics_page';

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isPlaying = false;
  double _currentValue = 0;
  Timer? _timer;
  int _elapsedSeconds = 0;

  bool _isDisposed = false;

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    // Hide BottomNav and PlayingBar when this page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VisibilitySettings.showBottomNavAndPlayingBar.value = false;
    });
    //Just for playing bar
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

    //Khởi tạo _widthAnimation với một giá trị mặc định
    _widthAnimation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  void _togglePlayPause(double maxWidth) {
    setState(() {
      if (_isPlaying) {
        _currentValue = _controller.value; //Lưu lại giá trị hiện tại
        _controller.stop();
        _timer?.cancel();
      } else {
        if (_currentValue == 0) {
          //Nếu giá trị hiện tại là 0, bắt đầu lại từ đầu
          _widthAnimation =
              Tween<double>(begin: 0, end: maxWidth).animate(_controller)
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
          _timer?.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    _controller.reset();
    _timer?.cancel();
    setState(() {
      _elapsedSeconds = 0;
      _currentValue = 0;
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    _timer?.cancel();

    // Đặt đoạn code để hiển thị lại BottomNav và PlayingBar khi trang bị hủy
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!_isDisposed) {
        VisibilitySettings.showBottomNavAndPlayingBar.value = true;
      }
    });

    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          blueBackground(),
          CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  title: Column(
                    children: [
                      Text(
                        widget.musicName,
                        style: changeTextColor(robotoMedium14, whiteColor),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.artist,
                        style: changeTextColor(robotoMedium12, whiteColor),
                      ),
                    ],
                  ),
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 40,
                      color: whiteColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_sharp,
                          size: 25,
                          color: whiteColor,
                        )),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Hello? Anh thấy story em đăng\n\n' +
                            'Nhạc lofi, đèn đom đóm và lại thút thít trong lớp chăn\n\n' +
                            'Trong hàng vạn sự tình xảy ra, điều nào đủ nghiêm để khiến em đau?\n\n' +
                            'Vì đằng sau con số trăm ngàn những theo dõi\n\n' +
                            'Mấy ai rõ em thế nào\n\n' +
                            'Ban ngày chụp choẹt PR giúp local brand\n\n' +
                            'Thả dáng và nở nụ cười nhưng ôi về đêm ưu sầu là bạn\n\n' +
                            'Ohh\n\n' +
                            'Hết điếu này đến khu khác, khụ khụ mãi trên livestream',
                        style: changeTextColor(
                            robotoBold24.copyWith(height: 1), whiteColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: blueColor,
                spreadRadius: 1,
                blurRadius: 35,
                offset: Offset(0, -22),
              )
            ]),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                              color: whiteLowOpacity,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          width: _widthAnimation.value,
                          height: 6,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '00:00',
                      style: changeTextColor(robotoMedium14, lightGrayColor),
                    ),
                    Text(
                      '04:10',
                      style: changeTextColor(robotoMedium14, lightGrayColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Cái này chủ yếu để làm cho nút play ở giữa
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          color: transparent,
                          size: 28,
                        )),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _togglePlayPause(
                                MediaQuery.of(context).size.width - 40);
                          },
                          child: FaIcon(
                            _isPlaying
                                ? FontAwesomeIcons.pause
                                : FontAwesomeIcons.solidCirclePlay,
                            size: 60,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          color: whiteColor,
                          size: 28,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
