import 'package:flutter/material.dart';

class ListFavoriteArtist extends StatefulWidget {
  const ListFavoriteArtist({super.key});

  @override
  State<ListFavoriteArtist> createState() => _ListFavoriteArtistState();
}

class _ListFavoriteArtistState extends State<ListFavoriteArtist> {
  final List<Map<String, String>> items = [
    {'image': 'assets/images/artist1.png', 'text': 'HIEUTHUHAI'},
    {'image': 'assets/images/artist2.png', 'text': 'Negav'},
    {'image': 'assets/images/artist3.png', 'text': 'Orange'},
    {'image': 'assets/images/artist4.png', 'text': 'W/N'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 183,
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
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index]['image']!),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  items[index]['text']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'MonFontsBold'
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}