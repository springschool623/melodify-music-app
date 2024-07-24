import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/artist_page.dart';
import 'package:melodify_app_project/pages/playlist_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../conf/const.dart';

class ListRecentPlay extends StatefulWidget {
  const ListRecentPlay({super.key});

  @override
  State<ListRecentPlay> createState() => _ListRecentPlayState();
}

class _ListRecentPlayState extends State<ListRecentPlay> {
  List<Map<String, String>> items = [];

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    final credentials = spotify.SpotifyApiCredentials(CustomString.clientId, CustomString.clientSecret);
    final spotifyApi = spotify.SpotifyApi(credentials);

    try {
      final newReleases = await spotifyApi.browse.newReleases().all();
      setState(() {
        items = newReleases.map((album) {
          return {
            'id': album.id!,
            'image': album.images?.first.url ?? '',
            'text': album.name ?? 'Unknown Album',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching albums: $e');
    }
  }

  //Navigate sang các trang khác 
  void _navigateToAnotherPage(String albumId, String image, String text, String imageURL) {
    if (image.contains('playlist')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayListPage(title: text, imagePlaylist: imageURL, albumId: albumId),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArtistPage(artistName: text, artistImage: imageURL),
        ),
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
            onTap: () => _navigateToAnotherPage(item['id']!, item['image']!, item['text']!, item['image']!),
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
                        image: NetworkImage(item['image']!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 125,
                    alignment: isPlaylist ? Alignment.centerLeft : Alignment.center,
                    child: Text(
                      item['text']!,
                      style: changeTextColor(robotoBold13, whiteColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
