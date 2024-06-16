// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/grid_recent.dart';
import 'package:melodify_app_project/components/list_fav_artist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
            sliver: SliverAppBar(
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
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Gần đây',
                    style: TextStyle(
                        fontFamily: 'MonFontsSemiBold',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: RecentPlayListGridView(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    'Nghệ sĩ yêu thích của bạn',
                    style: TextStyle(
                        fontFamily: 'MonFontsSemiBold',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ListFavoriteArtist(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
