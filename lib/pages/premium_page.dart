// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          moreBlackBackground(),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 220.0,
                backgroundColor: transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/image.png',
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/bwlogo.png',
                                  height: 22.0,
                                  width: 22.0,
                                ),
                                SizedBox(width: 4.0),
                                Text('Premium',
                                    style: changeTextColor(
                                        robotoBold16, whiteColor)),
                              ],
                            ),
                            SizedBox(height: 12.0),
                            Text(
                                'Trải nghiệm âm nhạc đỉnh cao với gói Premium Individual.',
                                style: robotoBlack28.copyWith(
                                  color: whiteColor,
                                  height: 1.2,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(500, 45),
                              backgroundColor: whiteColor),
                          onPressed: () {},
                          child: Text(
                            'Đăng Ký Premium Individual',
                            style: changeTextColor(robotoMedium16, blackColor),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Có áp dụng điều khoản',
                        style: robotoRegular12.copyWith(
                            color: lightGrey,
                            decoration: TextDecoration.underline,
                            decorationColor: lightGrey,
                            decorationThickness: 1.8,
                            height: 2),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: darkGrayColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 24),
                              child: Text(
                                'Lý do nên dùng Premium',
                                style: changeTextColor(robotoBold22, whiteColor),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: darkGray,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.speaker_group_outlined,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Nghe nhạc không quảng cáo',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.downloading_outlined,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Tải xuống để nghe offline',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.shuffle,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Phát nhạc theo thứ tự',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.headset_outlined,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Chất lượng âm thanh cao',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.supervised_user_circle_outlined,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Nghe cùng bạn bè theo thời gian thực',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.playlist_add_circle_outlined,
                                        color: whiteColor,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        'Sắp xếp danh sách chờ nghe',
                                        style: changeTextColor(robotoRegular14, whiteColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 130,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
