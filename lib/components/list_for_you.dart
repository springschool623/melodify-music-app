import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class ListForYouPlaylist extends StatefulWidget {
  const ListForYouPlaylist({super.key});

  @override
  State<ListForYouPlaylist> createState() => _ListForYouPlaylistState();
}

class _ListForYouPlaylistState extends State<ListForYouPlaylist> {

  final List<Map<String, String>> items = [
    {'image': 'assets/images/playlist1.png', 'text': 'Với Kewtie, HURRYKNG, DT Tập Rap và nhiều hơn nữa'},
    {'image': 'assets/images/playlist2.png', 'text': 'Mer, Thịnh Suy, Tùng TeA và nhiều hơn nữa'},
    {'image': 'assets/images/playlist3.png', 'text': 'BTS, MOMOLAND, ITZY và nhiều hơn nữa'},
    {'image': 'assets/images/playlist4.png', 'text': 'John Adams, Ed Sheeran, Camila Cabello và nhiều hơn nữa'},
    {'image': 'assets/images/playlist5.png', 'text': 'Taylor Swift và Bruna Mars'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:194,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index]['image']!),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: Text(
                    items[index]['text']!,
                    style: changeTextColor(robotoBold12, lightGrayColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}