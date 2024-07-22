// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:melodify_app_project/pages/myfavorite_page.dart'; // Make sure to import the MyFavoritePage class

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/logotest.jpg',
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Lê Nguyễn Gia Bảo',
                        style: changeTextColor(robotoBold24, whiteColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1',
                            style: changeTextColor(robotoMedium14, whiteColor),
                          ),
                          Text(
                            ' người theo dõi ',
                            style: changeTextColor(robotoMedium14, lightGrey),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: whiteColor),
                          ),
                          Text(
                            ' Đang theo dõi ',
                            style: changeTextColor(robotoMedium14, lightGrey),
                          ),
                          Text(
                            '37',
                            style: changeTextColor(robotoMedium14, whiteColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: transparent,
                              side: BorderSide(color: whiteColor,width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              foregroundColor: whiteColor
                            ),
                            child: Text(
                              'Chỉnh sửa',
                              style:
                                  changeTextColor(robotoMedium14, whiteColor),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Danh sách phát',
                        style: changeTextColor(robotoBold20, whiteColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyFavoritePage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/liked-songs-640.png'), // Update with your image path
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bài hát đã thích',
                                    style: changeTextColor(
                                        robotoBold16, whiteColor),
                                  ),
                                  Text(
                                    '0 lượt lưu',
                                    style: changeTextColor(
                                        robotoRegular14, lightGrayColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
