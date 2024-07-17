import 'package:flutter/material.dart';
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  blueColor,
                  blackColor,
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
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
                      size: 40,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/logotest.jpg'), // Update with your image path
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
                      child: Text(
                        '1 người theo dõi • Đang theo dõi 37',
                        style: changeTextColor(robotoRegular14, lightGrayColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Chỉnh sửa',
                              style: changeTextColor(robotoRegular14, whiteColor),
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
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/liked-songs-640.png'), // Update with your image path
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
                                    style: changeTextColor(robotoBold16, whiteColor),
                                  ),
                                  Text(
                                    '0 lượt lưu',
                                    style: changeTextColor(robotoRegular14, lightGrayColor),
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
          // Bottom navigation bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              child: BottomNavigationBar(
                backgroundColor: Colors.black,
                selectedItemColor: whiteColor,
                unselectedItemColor: lightGrayColor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Trang chủ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Tìm kiếm',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_music),
                    label: 'Thư viện',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: 'Premium',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Cá nhân',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}