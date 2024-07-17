import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 50, 113), // Màu nền tương tự trang chính
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color.fromARGB(0, 17, 4, 68),
            title: Text('Cài đặt', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    title: const Text(
                      'Tài khoản',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Phiên bản',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Lựa chọn ưu tiên về nội dung',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Thiết lập',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Quyền riêng tư và bảo mật',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Chế độ ngoại tuyến',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text(
                      'Lưu trữ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
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