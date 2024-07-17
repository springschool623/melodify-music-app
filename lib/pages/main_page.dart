import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:melodify_app_project/conf/const.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:melodify_app_project/components/playing_bar.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/pages/find_page.dart';
import 'package:melodify_app_project/pages/home_page.dart';
import 'package:melodify_app_project/pages/library_page.dart';
import 'package:melodify_app_project/pages/personal_page.dart';
import 'package:melodify_app_project/pages/premium_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String musicTrackId = "7J8AUbvYoToCvGRQeSXBx7";
  final player = AudioPlayer();
  Duration? songDuration;
  String songName = "";
  String artistName = "";
  String songImg = "";
  String? audioUrl;
  PlayerState playerState = PlayerState.completed;
  bool isLoading = true;
  double playbackRate = 1.0;
  bool isPrepared = false;
  bool isCached = false;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const LibraryPage(),
    const PremiumPage(),
    const PersonalPage(),
  ];

  final ValueNotifier<int> _myValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    fetchTrack();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        playerState = state;
      });
    });
    _myValueNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    _myValueNotifier.removeListener(_listener);
    _myValueNotifier.dispose();
    player.dispose(); // Dispose of the audio player
    super.dispose();
  }

  Future<void> fetchTrack() async {
    try {
      setState(() {
        isLoading = true;
      });

      final credentials = SpotifyApiCredentials(CustomString.clientId, CustomString.clientSecret);
      final spotify = SpotifyApi(credentials);

      final trackFuture = spotify.tracks.get(musicTrackId);
      final yt = YoutubeExplode();

      final track = await trackFuture;
      songName = track.name ?? "";
      artistName = track.artists?.first.name ?? "";
      songImg = track.album?.images?.first.url ?? ""; // Get song image

      if (songName.isNotEmpty) {
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;
        songDuration = video.duration;

        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        audioUrl = manifest.audioOnly.first.url.toString();

        final cacheDir = await getTemporaryDirectory();
        final cachedFile = File('${cacheDir.path}/$musicTrackId.mp3');

        if (await cachedFile.exists()) {
          audioUrl = cachedFile.path;
          isCached = true;
        } else {
          final response = await http.get(Uri.parse(audioUrl!));
          await cachedFile.writeAsBytes(response.bodyBytes);
          audioUrl = cachedFile.path;
          isCached = true;
        }

        await player.setPlaybackRate(playbackRate);
        await player.setSourceUrl(audioUrl!);
        isPrepared = true;

        print("Audio URL fetched and set.");
      }
    } catch (e) {
      if (e is TimeoutException) {
        print('Fetch track timed out');
      } else {
        print('An error occurred: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void pauseAudio() {
    player.pause();
  }

  void playAudio() {
    if (audioUrl != null && isPrepared && !isLoading) {
      print(songImg);
      player.resume();
    }
  }

  void _listener() {
    if (mounted) {
      setState(() {
        // Update your state variables here
      });
    }
  }

  void navigateToPage(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _pages[index],
            settings: routeSettings,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int durationInSeconds = songDuration?.inSeconds ?? 0;
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          Stack(
            children: List.generate(_pages.length, (index) => _buildOffstageNavigator(index)),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: VisibilitySettings.showBottomNavAndPlayingBar,
            builder: (context, show, child) {
              return Visibility(
                visible: show,
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      isLoading
                          ? const CircularProgressIndicator()
                          : PlayingBar(
                              duration: durationInSeconds,
                              onPlayPause: (bool isPlaying) {
                                if (isPlaying) {
                                  playAudio();
                                } else {
                                  pauseAudio();
                                }
                              },
                              songName: songName,
                              artistName: artistName,
                              musicImg: songImg, // pass songImg to PlayingBar
                            ),
                      BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: blackLowOpacity,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined),
                            label: 'Trang chủ',
                            activeIcon: Icon(Icons.home),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.search_outlined),
                            label: 'Tìm kiếm',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.my_library_music_outlined),
                            label: 'Thư viện',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.paid_outlined),
                            label: 'Premium',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline),
                            label: 'Cá nhân',
                          ),
                        ],
                        selectedLabelStyle: changeTextColor(robotoMedium14, whiteColor),
                        unselectedItemColor: lightGrayColor,
                        selectedItemColor: whiteColor,
                        unselectedLabelStyle: changeTextColor(robotoRegular12, lightGrayColor),
                        currentIndex: _selectedIndex,
                        onTap: navigateToPage,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}