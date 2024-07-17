import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/pages/playlist_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../conf/const.dart';

class RecentPlayListGridView extends StatefulWidget {
  const RecentPlayListGridView({super.key});

  @override
  State<RecentPlayListGridView> createState() => _RecentPlayListGridViewState();
}

class _RecentPlayListGridViewState extends State<RecentPlayListGridView> {
  List<Map<String, String>> items = [];
  int? selectedIndex;

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
            'image': album.images?.first.url ?? '',
            'text': album.name ?? 'Unknown Album',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching albums: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final double totalHeight = (items.length * 22) + ((items.length - 1) * 15);

    return SizedBox(
      height: 1000,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          childAspectRatio: 22 / 7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayListPage(title: items[index]['text']!, imagePlaylist: items[index]['image']!),
                ),
              );
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: darkGray,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: Image.network(
                        items[index]['image']!,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        items[index]['text']!,
                        style: changeTextColor(robotoBold12, whiteColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if (selectedIndex == index)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.more_horiz_outlined,
                          color: blueColor,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
