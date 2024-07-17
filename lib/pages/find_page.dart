import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Bạn muốn nghe gì?',
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.blue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(top: 25, left: 16, right: 16),
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              titleSpacing: 15,
              leading: Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logotest.jpg'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Duyệt tìm tất cả',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'RobotoBoldFont',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    childAspectRatio: 2, // Adjust this to make the cards rectangular
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryCard('Nhạc', Colors.purple, context),
                      _buildCategoryCard('Podcasts', Colors.green, context),
                      _buildCategoryCard('Dành cho bạn', Colors.orange, context),
                      _buildCategoryCard('Mới phát hành', Colors.lightGreen, context),
                      _buildCategoryCard('Nhạc Việt', Colors.pink, context),
                      _buildCategoryCard('K-Pop', Colors.red, context),
                      _buildCategoryCard('Cổ điển', Colors.yellow, context),
                      _buildCategoryCard('Jazz', Colors.lime, context),
                      _buildCategoryCard('Nhạc sĩ', Colors.redAccent, context),
                      _buildCategoryCard('Mùa hè', Colors.red, context),
                      _buildCategoryCard('R&B', Colors.brown, context),
                      _buildCategoryCard('Rap', Colors.grey, context),
                      _buildCategoryCard('Bảng xếp hạng', Colors.blue, context),
                      _buildCategoryCard('Karaoke', Colors.teal, context),
                      _buildCategoryCard('Indie', Colors.deepPurple, context),
                      _buildCategoryCard('Thư giãn', Colors.cyan, context),
                      _buildCategoryCard('LO-FI', Colors.yellow, context),
                      _buildCategoryCard('Tình yêu', Colors.pinkAccent, context),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, Color color, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Nhạc') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MusicPage()),
          );
        } else {
          // Handle other categories if needed
          print('Tapped on $title');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'RobotoBoldFont',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
