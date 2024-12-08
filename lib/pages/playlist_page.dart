import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/audio_provider.dart';
import 'package:melodify_app_project/components/track_provider.dart';
import 'package:melodify_app_project/components/visible_playing_bar.dart';
import 'package:melodify_app_project/pages/useremail_provider.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../conf/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PlayListPage extends StatefulWidget {
  final String title;
  final String imagePlaylist;
  final String albumId;

  const PlayListPage({
    super.key,
    required this.title,
    required this.imagePlaylist,
    required this.albumId,
  });

  @override
  State<PlayListPage> createState() => PlayListPageState();
}

class PlayListPageState extends State<PlayListPage> {
  List<Map<String, String>> items = [];
  final TextEditingController searchController = TextEditingController();
  String? selectedTrackId;
  String songName = "";
  String audioUrl = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    fetchTracks();
  }

  Future<void> fetchTracks() async {
    final credentials = spotify.SpotifyApiCredentials(CustomString.clientId, CustomString.clientSecret);
    final spotifyApi = spotify.SpotifyApi(credentials);

    try {
      final album = await spotifyApi.albums.get(widget.albumId);
      final tracks = album.tracks?.toList();

      setState(() {
        items = tracks?.map((track) {
          return {
            'image': widget.imagePlaylist,
            'musicName': track.name ?? 'Unknown Track',
            'artist': track.artists?.first.name ?? 'Unknown Artist',
            'trackID': track.id ?? 'Unknown ID',
          };
        }).toList() ?? [];
      });
    } catch (e) {
      print('Error fetching tracks: $e');
    }
  }

  Future<void> sendTrackToAPI(Map<String, String> trackData) async {
  const url = 'https://melodify-app-api.vercel.app/api/tracks'; // Thay bằng URL thực của bạn

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(trackData),
    );

    if (response.statusCode == 201) {
      print('Track added successfully.');
    } else {
      print('Failed to add track: ${response.body}');
    }
  } catch (e) {
    print('Error sending track to API: $e');
  }
}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final audioProvider = Provider.of<AudioProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    setState(() {
      audioUrl = audioProvider.audioURL ?? '';
      userEmail = userProvider.userEmail ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 285,
                            height: 40,
                            child: SearchBar(
                              controller: searchController,
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                lightGrayColorLowOpacity,
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                              leading: const Icon(
                                Icons.search,
                                color: whiteColor,
                              ),
                              hintText: 'Tìm trong danh sách phát',
                              hintStyle: MaterialStateProperty.all<TextStyle>(
                                  changeTextColor(
                                      robotoRegular14, whiteColor)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            width: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: lightGrayColorLowOpacity,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text('Sắp xếp',
                                style: changeTextColor(
                                    robotoRegular14, whiteColor)),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.imagePlaylist,
                          height: 300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: changeTextColor(
                                  robotoBold24, whiteColor),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Cập nhật những bài hát hay nhất mỗi ngày!',
                              style: changeTextColor(
                                  robotoRegular14, lightGray),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_circle_down, color: lightGrayColor, size: 35,),
                              SizedBox(width: 25),
                              Icon(Icons.add_circle_outline, color: lightGrayColor, size: 35,),
                              SizedBox(width: 25),
                              Icon(Icons.more_vert, color: lightGrayColor, size: 35,),
                            ],
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.shuffle, 
                                color: blueColor, 
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.play_circle, color: blueColor, size: 50,),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Bài hát hàng đầu',
                        style: changeTextColor(robotoBold18, whiteColor),
                      ),
                      const SizedBox(height: 10),
                      for (final item in items)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              item['image']!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item['musicName']!,
                            style: changeTextColor(robotoBold16, whiteColor),
                          ),
                          subtitle: Text(
                            item['artist']!,
                            style: changeTextColor(robotoRegular14, lightGray),
                          ),
                          trailing: const Icon(
                            Icons.more_vert,
                            color: whiteColor,
                          ),
                          onTap: () async {
                            await context.read<AudioProvider>().stopAudio();
                            final currentPlayingSong = Provider.of<CurrentPlayingSong>(context, listen: false);
                            currentPlayingSong.updateSong(
                              item['musicName']!,
                              item['artist']!,
                              item['image']!,
                            );
                            final trackProvider = Provider.of<TrackProvider>(context, listen: false);
                            trackProvider.setTrackId(item['trackID']);

                            final newAudioUrl = await fetchAudioUrlForTrack(item['trackID']!);

                            setState(() {
                              selectedTrackId = item['trackID'];
                              audioUrl = newAudioUrl;
                            });

                            final trackData = {
                              'userEmail': userEmail, // Thay bằng email thực của người dùng
                              'trackID': item['trackID']!,
                              'trackName': item['musicName']!,
                              'artists': item['artist']!,
                              'trackImage': item['image']!,
                            };

                            await sendTrackToAPI(trackData);

                            print('Tapped on ${item['musicName']} by ${item['artist']} with trackID: ${item['trackID']}');
                            print("Play $audioUrl");
                          },
                        ),
                      const SizedBox(height: 15),
                      Text(
                        'Có thể bạn sẽ thích',
                        style: changeTextColor(robotoBold18, whiteColor),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void search(String query) {
    final filteredItems = items.where((item) {
      final musicNameLower = item['musicName']!.toLowerCase();
      final artistLower = item['artist']!.toLowerCase();
      final searchLower = query.toLowerCase();

      return musicNameLower.contains(searchLower) ||
          artistLower.contains(searchLower);
    }).toList();

    setState(() {
      items = filteredItems;
    });
  }

  Future<String> fetchAudioUrlForTrack(String trackId) async {
    try {
      final credentials = spotify.SpotifyApiCredentials(CustomString.clientId, CustomString.clientSecret);
      final spotifyApi = spotify.SpotifyApi(credentials);

      final trackFuture = spotifyApi.tracks.get(trackId);
      final yt = YoutubeExplode();

      final track = await trackFuture;
      final songName = track.name ?? "";
      
      if (songName.isNotEmpty) {
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;

        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.first.url.toString();

        final cacheDir = await getTemporaryDirectory();
        final cachedFile = File('${cacheDir.path}/$trackId.mp3');

        if (await cachedFile.exists()) {
          audioUrl = cachedFile.path;
        } else {
          final response = await http.get(Uri.parse(audioUrl));
          await cachedFile.writeAsBytes(response.bodyBytes);
          audioUrl = cachedFile.path;
        }

        print("Audio URL fetched and set.");
        return audioUrl; // Ensure we return a value here
      } else {
        // If songName is empty, handle accordingly
        return ''; // Return a default value or handle as needed
      }
    } catch (e) {
      if (e is TimeoutException) {
        print('Fetch track timed out');
      } else {
        print('An error occurred: $e');
      }
      return ''; // Return a default value or handle as needed
    }
  }
}
