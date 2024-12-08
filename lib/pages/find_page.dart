// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/components/grid_recent.dart';
import 'package:melodify_app_project/components/list_collection_artist.dart';
import 'package:melodify_app_project/components/list_fav_artist.dart';
import 'package:melodify_app_project/components/list_for_you.dart';
import 'package:melodify_app_project/components/list_recent_play.dart';
import 'package:melodify_app_project/pages/music_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // add the alpha value if not present
    }
    return Color(int.parse(hex, radix: 16));
  }

  List<Map<String, String>> items = [
    {
      'image': 'assets/images/cateimg/nhac.jfif',
      'cateName': 'Nhạc',
      'color': '#8FEDDD',
    },
    {
      'image': 'assets/images/cateimg/moiphathanh.jfif',
      'cateName': 'Mới phát hành',
      'color': '#006450',
    },
    {
      'image': 'assets/images/cateimg/kpop.jfif',
      'cateName': 'K-Pop',
      'color': '#1E3264',
    },
    {
      'image': 'assets/images/cateimg/nhacviet.jfif',
      'cateName': 'Nhạc Việt',
      'color': '#8400E7',
    },
    {
      'image': 'assets/images/cateimg/rap.jfif',
      'cateName': 'Rap',
      'color': '#E61E32',
    },
    {
      'image': 'assets/images/cateimg/randb.jfif',
      'cateName': 'R&B',
      'color': '#477D95',
    },
    {
      'image': 'assets/images/cateimg/indie.jfif',
      'cateName': 'Indie',
      'color': '#608108',
    },
    {
      'image': 'assets/images/cateimg/lofi.jfif',
      'cateName': 'LO-FI',
      'color': '#503750',
    },
    {
      'image': 'assets/images/cateimg/tinhyeu.jfif',
      'cateName': 'Tình yêu',
      'color': '#FF0090',
    },
    {
      'image': 'assets/images/cateimg/thugian.jfif',
      'cateName': 'Thư giãn',
      'color': '#BA5D07',
    },
    {
      'image': 'assets/images/cateimg/tiectung.jfif',
      'cateName': 'Tiệc tùng',
      'color': '#B06239',
    },
    {
      'image': 'assets/images/cateimg/anime.jfif',
      'cateName': 'Anime',
      'color': '#148A08',
    },
    {
      'image': 'assets/images/cateimg/ngungon.jfif',
      'cateName': 'Ngủ ngon',
      'color': '#503750',
    },
    {
      'image': 'assets/images/cateimg/dance.jfif',
      'cateName': 'Dance/Điện tử',
      'color': '#537AA1',
    },
    {
      'image': 'assets/images/cateimg/game.jfif',
      'cateName': 'Chơi game',
      'color': '#E8115B',
    },
  ];

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
              backgroundColor: transparent,
              title: Text(
                'Tìm kiếm',
                style: changeTextColor(robotoBold24, whiteColor),
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
                  icon: FaIcon(
                    FontAwesomeIcons.camera,
                    color: whiteColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    style: changeTextColor(robotoBold16, darkGray),
                    decoration: InputDecoration(
                      hintText: 'Bạn muốn nghe gì?',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: blackColor,
                        size: 30,
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    'Duyệt tìm tất cả',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'RobotoBoldFont',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                mainAxisExtent: 90,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: hexToColor(items[index]['color']!),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -1,
                            right: -12,
                            child: Transform.rotate(
                              angle: 0.4, // Góc xoay (radians)
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      items[index]['image']!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 8,
                            child: Container(
                              width: 100, // Set the desired width
                              child: Text(
                                items[index]['cateName']!,
                                style: changeTextColor(robotoBold18, whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 150),
          ),
        ],
      ),
    );
  }
}
