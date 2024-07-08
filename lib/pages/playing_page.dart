// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/pages/artist_page.dart';
import 'package:melodify_app_project/pages/lyrics_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class PlayingMusicPage extends StatefulWidget {
  final String musicName;
  final String artist;
  final String image;
  final String playListTitle;
  final int duration;

  const PlayingMusicPage({
    Key? key,
    required this.musicName,
    required this.artist,
    required this.image,
    required this.playListTitle,
    required this.duration,
  }) : super(key: key);

  static const String routeName = '/playing_music_page';

  @override
  State<PlayingMusicPage> createState() => _PlayingMusicPageState();
}

class _PlayingMusicPageState extends State<PlayingMusicPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  bool _isPlaying = false;
  double _currentValue = 0;
  late Timer _timer;
  int _elapsedSeconds = 0;

  bool _isDisposed = false;
  final ValueNotifier<bool> _someValueNotifier = ValueNotifier<bool>(false);

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();

    // Hide BottomNav and PlayingBar when this page is initialized
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     VisibilitySettings.showBottomNavAndPlayingBar.value = false;
    //   }
    // });
    // _someValueNotifier.addListener(_listener);

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

    _startTimer();
  }

  void _togglePlayPause(double maxWidth) {
    if (mounted) {
      setState(() {
        if (_isPlaying) {
          _currentValue = _controller.value; //Lưu lại giá trị hiện tại
          _controller.stop();
          _timer.cancel();
        } else {
          if (_currentValue == 0) {
            //Nếu giá trị hiện tại là 0, bắt đầu lại từ đầu
            _widthAnimation =
                Tween<double>(begin: 0, end: maxWidth).animate(_controller)
                  ..addListener(() {
                    if (mounted) {
                      setState(() {});
                    }
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
  }

  void _startTimer({bool resume = false}) {
    if (!resume) {
      _elapsedSeconds = 0;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
          if (_elapsedSeconds >= widget.duration) {
            _timer.cancel();
          }
        });
      }
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
    if (!_isDisposed) {
      // Hiển thị BottomNav và PlayingBar khi rời khỏi trang này
      // VisibilitySettings.showBottomNavAndPlayingBar.value = true;
      // _someValueNotifier.removeListener(_listener);
      // _someValueNotifier.dispose();

      _controller.dispose();
      _timer.cancel();
      _isDisposed = true; // Đánh dấu đã dispose

      super.dispose();
    }
  }

  void _listener() {
    if (mounted) {
      setState(() {
        // Update your state here based on _someValueNotifier changes
      });
    }
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainerBrighter(),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  title: Column(
                    children: [
                      Text(
                        'ĐANG PHÁT TỪ DANH SÁCH PHÁT',
                        style: changeTextColor(robotoMedium10, whiteColor),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.playListTitle,
                        style: changeTextColor(robotoBlack12, whiteColor),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              height: 330,
                              width: 330,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(widget.image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.musicName,
                                    style: changeTextColor(
                                        robotoBold18, whiteColor),
                                  ),
                                  Text(
                                    widget.artist,
                                    style: changeTextColor(
                                        robotoMedium18, lightGrayColor),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: whiteColor,
                                    size: 38,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: whiteLowOpacity,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Container(
                                        width: _widthAnimation.value,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '00:00',
                                    style: changeTextColor(
                                        robotoMedium14, lightGrayColor),
                                  ),
                                  Text(
                                    '04:10',
                                    style: changeTextColor(
                                        robotoMedium14, lightGrayColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.shuffle,
                              color: lightBlue,
                              size: 26,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.backwardStep,
                                    color: greyLowOpacity,
                                    size: 32,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
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
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.forwardStep,
                                    color: whiteColor,
                                    size: 32,
                                  )),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: whiteColor,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.computer,
                                color: whiteColor,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share_outlined,
                                color: whiteColor,
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Lyrics
                    GestureDetector(
                      onTap: () {
                        // Update BOTNAV visibility status
                        VisibilitySettings.showBottomNavAndPlayingBar.value = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LyricsPage(
                              musicName: widget.musicName,
                              artist: widget.artist,
                              duration: 150,
                            ),
                            settings: const RouteSettings(name: 'LyricsPage'),
                          ),
                        ).then((_) {
                          // Restore visibility status when returning
                          VisibilitySettings.showBottomNavAndPlayingBar.value = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: lightCyanColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bản xem trước lời bài hát',
                                style:
                                    changeTextColor(robotoBold18, whiteColor),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                'Hello? Anh thấy story em đăng\n\n'
                                'Nhạc lofi, đèn đom đóm và lại thút thít trong lớp chăn\n\n'
                                'Trong hàng vạn sự tình xảy ra, điều nào đủ nghiêm để khiến em đau?\n\n'
                                'Vì đằng sau con số trăm ngàn',
                                style: changeTextColor(
                                    robotoBold22.copyWith(height: 1),
                                    whiteColor),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: darkCyanColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: lightCyanColor,
                                        spreadRadius: 0,
                                        blurRadius: 30,
                                        offset: Offset(0, -35),
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Có giới hạn số lượng lời bài hát mỗi tháng.',
                                      style: changeTextColor(
                                          robotoMedium135, whiteColor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(115, 30),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Hiện lời bài hát',
                                          style: changeTextColor(
                                              robotoMedium135, blackColor),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        VisibilitySettings.showBottomNavAndPlayingBar.value = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArtistPage(artistName: 'Negav', artistImage: widget.image,),
                            )
                        ).then((_) {
                          VisibilitySettings.showBottomNavAndPlayingBar.value = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: darkGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: AssetImage(
                                          'assets/images/bannerartist.png',
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Negav',
                                              style: changeTextColor(
                                                  robotoBold20, whiteColor),
                                            ),
                                            Text(
                                              '513.1N người nghe hằng tiếng',
                                              style: changeTextColor(
                                                  robotoRegular12,
                                                  lightGrayColor),
                                            ),
                                          ],
                                        ),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(60, 25),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              'Theo dõi',
                                              style: changeTextColor(
                                                  robotoBlack12, whiteColor),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'sap noi tieng',
                                      style: changeTextColor(
                                          robotoMedium12, lightGrayColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, bottom: 18, top: 4),
                        decoration: BoxDecoration(
                          color: darkGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Người tham gia thực hiện',
                                  style:
                                      changeTextColor(robotoBold16, whiteColor),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: const Size(85, 10),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Hiện tất cả',
                                      style: changeTextColor(
                                          robotoRegular12, blueColor),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Negav',
                                      style: changeTextColor(
                                          robotoMedium16, whiteColor),
                                    ),
                                    Text(
                                      'Nghệ sĩ chính',
                                      style: changeTextColor(
                                          robotoRegular12, lightGrayColor),
                                    ),
                                  ],
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(60, 25),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Theo dõi',
                                      style: changeTextColor(
                                          robotoBlack12, whiteColor),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CROW ON HYENAS',
                                      style: changeTextColor(
                                          robotoMedium16, whiteColor),
                                    ),
                                    Text(
                                      'Nghệ sĩ chính',
                                      style: changeTextColor(
                                          robotoRegular12, lightGrayColor),
                                    ),
                                  ],
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(60, 25),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Theo dõi',
                                      style: changeTextColor(
                                          robotoBlack12, whiteColor),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dang Thanh An',
                                      style: changeTextColor(
                                          robotoMedium16, whiteColor),
                                    ),
                                    Text(
                                      'Nhà soạn nhạc, Người viết lời',
                                      style: changeTextColor(
                                          robotoRegular12, lightGrayColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
