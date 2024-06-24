// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/botnav.dart';
import 'package:melodify_app_project/components/grid_recent.dart';
import 'package:melodify_app_project/components/list_fav_artist.dart';
import 'package:melodify_app_project/components/playing_bar.dart';
import 'package:melodify_app_project/pages/find_page.dart';
import 'package:melodify_app_project/pages/home_page.dart';
import 'package:melodify_app_project/pages/library_page.dart';
import 'package:melodify_app_project/pages/personal_page.dart';
import 'package:melodify_app_project/pages/premium_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Kiểm soát botnav
  int _selectedIndex = 0;

  //Update các pages khi nhấn chọn
  void navigattionBar(int index) {
    if(_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
      _selectedIndex = index;
    });
    }
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _pages[index],
          );
        },
      ),
    );
  }

  //Display Page
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const PremiumPage(),
    const LibraryPage(),
    const PersonnalPage()
  ];

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
                  Color.fromRGBO(30, 144, 255, 1),
                  Colors.black,
                ],
              ),
            ),
          ),
          // Hiển thị trang được chọn
          Stack(
            children: List.generate(_pages.length, (index) => _buildOffstageNavigator(index)),
          ),
          // Đặt BottomNavigationBar ở dưới cùng của màn hình
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                PlayingBar(duration: 20),
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.black.withOpacity(0.8), // Đặt màu nền với độ mờ
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Trang chủ',
                      activeIcon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_outlined),
                      label: 'Tìm kiếm',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.my_library_music_outlined),
                      label: 'Thư viện',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.paid_outlined),
                      label: 'Premium',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Cá nhân',
                    ),
                  ],
                  unselectedItemColor: Colors.white54,
                  selectedItemColor: Colors.white,
                  onTap: (index) => navigattionBar(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
