import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/artist_page.dart';
import 'package:melodify_app_project/pages/playlist_page.dart';
import 'package:melodify_app_project/pages/useremail_provider.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:http/http.dart' as http;

import '../conf/const.dart';

class ListRecentPlay extends StatefulWidget {
  const ListRecentPlay({super.key});

  @override
  State<ListRecentPlay> createState() => _ListRecentPlayState();
}

class _ListRecentPlayState extends State<ListRecentPlay> {
  List<Map<String, String>> items = [];
  Timer? _timer; // Để lưu trữ Timer
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    fetchTrackByUserEmail(userEmail);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchTrackByUserEmail(userEmail);
    });
  }

    @override
  void dispose() {
    _timer?.cancel(); // Hủy Timer khi widget bị dispose
    super.dispose();
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context);
    setState(() {
      userEmail = userProvider.userEmail ?? '';
    });
  }


  // Future<void> fetchAlbums() async {
  //   final credentials = spotify.SpotifyApiCredentials(CustomString.clientId, CustomString.clientSecret);
  //   final spotifyApi = spotify.SpotifyApi(credentials);

  //   try {
  //     final newReleases = await spotifyApi.browse.newReleases().all();
  //     setState(() {
  //       items = newReleases.map((album) {
  //         return {
  //           'id': album.id!,
  //           'image': album.images?.first.url ?? '',
  //           'text': album.name ?? 'Unknown Album',
  //         };
  //       }).toList();
  //     });
  //   } catch (e) {
  //     print('Error fetching albums: $e');
  //   }
  // }

Future<void> fetchTrackByUserEmail(String email) async {
    final url = Uri.parse('https://melodify-app-api.vercel.app/api/tracks/$email');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> trackList = json.decode(response.body);
        setState(() {
          items = trackList.map((track) {
            return {
              'id': track['trackID'] as String,
              'image': track['trackImage'] as String,
              'text': track['trackName'] as String,
            };
          }).toList();
        });
      } else {
        print('Failed to load tracks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tracks: $e');
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
