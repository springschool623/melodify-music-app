import 'dart:ui';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            leading: const Padding(
              padding: EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logotest.jpg'),
              ),
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MonFontsBold',
                      color: Colors.white),
                ),
                SizedBox(
                  height: 3,
                ),
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
            bottom: TabBar(
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              tabs: [
                Tab(child: Text('Tất cả')),
                Tab(child: Text('Nhạc')),
              ],
            ),
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(30, 144, 255, 1),
                  Colors.black,
                ])),
            child: const Center(
              child: Text(
                'HIhi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
