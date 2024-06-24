import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class ListCollectionArtist extends StatefulWidget {
  const ListCollectionArtist({super.key});

  @override
  State<ListCollectionArtist> createState() => _ListCollectionArtistState();
}

class _ListCollectionArtistState extends State<ListCollectionArtist> {
  final List<Map<String, String>> items = [
    {'image': 'assets/images/collection1.png', 'text': 'Bản nhạc tình mới nhất Đừng Làm Trái Tim Anh Đau'},
    {'image': 'assets/images/collection2.jpg', 'text': 'This is tlinh. Các bản nhạc bạn nghe, tất cả trong một danh sách phát'},
    {'image': 'assets/images/collection3.png', 'text': 'This is RAP VIỆT. Các bản nhạc bạn nghe, tất cả trong một danh sách phát'},
    {'image': 'assets/images/collection4.jpg', 'text': 'This is HIEUTHUHAI. Các bản nhạc bạn nghe, tất cả trong một danh sách phát'},
    {'image': 'assets/images/collection5.jpgg', 'text': 'This is RPT MCK. Các bản nhạc bạn nghe, tất cả trong một danh sách phát'},
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