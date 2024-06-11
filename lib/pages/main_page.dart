// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/grid_recent.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'MonFontsBold',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'ZeBao',
                        style: TextStyle(
                          fontFamily: 'MonFontsBold',
                          fontSize: 14,
                          color: Color.fromRGBO(165, 165, 165, 1),
                        ),
                      ),
                    ],
                  ),
                  titleSpacing: 15,
                  leading: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logotest.jpg'),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings, color: Colors.white),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20,),
                      Text(
                        'Gần đây',
                        style: TextStyle(
                          fontFamily: 'MonFontsBold',
                          color: Colors.white,
                          fontSize: 22
                        ),
                      ),
                      const SizedBox(height: 8,),
                      RecentPlayListGridView(),
                      const SizedBox(height: 30,),
                      Text(
                        'Nghệ sĩ yêu thích của bạn',
                        style: TextStyle(
                          fontFamily: 'MonFontsBold',
                          color: Colors.white,
                          fontSize: 22
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
