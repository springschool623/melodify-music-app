import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/artist_page.dart';
import 'package:melodify_app_project/pages/playlist_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class ListRecentPlay extends StatefulWidget {
  const ListRecentPlay({super.key});

  @override
  State<ListRecentPlay> createState() => _ListRecentPlayState();
}

class _ListRecentPlayState extends State<ListRecentPlay> {

  final List<Map<String, String>> items = [
    {'image': 'assets/images/playlist1.png', 'text': 'Negav Radio'},
    {'image': 'assets/images/artist2.png', 'text': 'Negav'},
    {'image': 'assets/images/artist4.png', 'text': 'W/N'},
    {'image': 'assets/images/playlist4.png', 'text': 'Daily Mix 4'},
    {'image': 'assets/images/playlist5.png', 'text': 'Daily Mix 5'},
  ];

  //Navigate sang các trang khác 
  void _navigateToAnotherPage(String image, String text, String imageURL) {
    if(image.contains('playlist')) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => PlayListPage(title: text, imagePlaylist: imageURL,),
        ),
      );
    } else {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ArtistPage(artistName: text, artistImage: imageURL,),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isPlaylist = item['image']!.contains('playlist');
          return GestureDetector(
            onTap: () => _navigateToAnotherPage(item['image']!, item['text']!, item['image']!),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      shape: isPlaylist ? BoxShape.rectangle : BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(item['image']!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 125,
                    alignment: isPlaylist ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                      items[index]['text']!,
                      style: changeTextColor(robotoBold13, whiteColor),
                      textAlign: isPlaylist ? TextAlign.left : TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}