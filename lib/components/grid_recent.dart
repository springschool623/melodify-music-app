import 'package:flutter/material.dart';
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
  List<String> albumIds = ['0i3IirLVHTlg7JqMvv45tE', '4faMbTZifuYsBllYHZsFKJ', '1vi1WySkgPGkbR8NnQzlXu', '0J9ZJ2vnTHm4NpzKVE779w', '5tlCVkYaDAmAtJ5YxejpWi', '0LM9Cm43Sug8Hfpm84qmt6'];
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
      final albums = await spotifyApi.albums.list(albumIds);
      setState(() {
        items = albums.map((album) {
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


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double itemHeight = 60 + 15; // Item height + main axis spacing
        final int rowCount = (items.length / 2).ceil();
        final double gridViewHeight = itemHeight * rowCount;

        return SizedBox(
          height: gridViewHeight,
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
                      builder: (context) => PlayListPage(
                        title: items[index]['text']!,
                        imagePlaylist: items[index]['image']!,
                        albumId: items[index]['id']!,
                      ),
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
      },
    );
  }
}
