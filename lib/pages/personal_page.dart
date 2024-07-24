import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/myfavorite_page.dart';
import 'package:melodify_app_project/pages/noti_page.dart';
import 'package:melodify_app_project/pages/setting_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'setting_page.dart';
import 'user_account_page.dart'; // Import trang tài khoản người dùng

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lê Nguyễn Gia Bảo',
                      style: changeTextColor(robotoBold16, whiteColor),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Xem hồ sơ',
                      style: changeTextColor(robotoBold14, lightGrayColor),
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
                  title: Text(
                    'Thêm tài khoản',
                    style: changeTextColor(robotoRegular16, whiteColor),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.flash_on, color: whiteColor),
                  title: Text(
                    'Thông tin mới',
                    style: changeTextColor(robotoRegular16, whiteColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => NewReleasesPage(),
                      )
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.audiotrack, color: whiteColor),
                  title: Text(
                    'Nội dung đã nghe',
                    style: changeTextColor(robotoRegular16, whiteColor),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: whiteColor),
                  title: Text(
                    'Cài đặt và quyền riêng tư',
                    style: changeTextColor(robotoRegular16, whiteColor),
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