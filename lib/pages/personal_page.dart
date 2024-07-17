import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/myfavorite_page.dart';
import 'package:melodify_app_project/pages/setting_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'setting_page.dart';
import 'user_account_page.dart'; // Import trang tài khoản người dùng

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparent,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
            sliver: SliverAppBar(
              pinned: true,
              backgroundColor: transparent,
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserAccountPage()), // Điều hướng đến trang tài khoản người dùng
                  );
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lê Nguyễn Gia Bảo',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoBoldFont',
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Xem hồ sơ',
                      style: TextStyle(
                        fontFamily: 'RobotoBoldFont',
                        fontSize: 14,
                        color: lightGrayColor,
                      ),
                    ),
                  ],
                ),
              ),
              titleSpacing: 15,
              leading: const Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logotest.jpg'),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              color: whiteColor,
              thickness: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: const Icon(Icons.add, color: whiteColor),
                  title: const Text(
                    'Thêm tài khoản',
                    style: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.flash_on, color: whiteColor),
                  title: const Text(
                    'Thông tin mới',
                    style: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.audiotrack, color: whiteColor),
                  title: const Text(
                    'Nội dung đã nghe',
                    style: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: whiteColor),
                  title: const Text(
                    'Cài đặt và quyền riêng tư',
                    style: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}