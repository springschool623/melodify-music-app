import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/playing_bar.dart';
import 'package:melodify_app_project/components/visible_playing_bar.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/pages/find_page.dart';
import 'package:melodify_app_project/pages/home_page.dart';
import 'package:melodify_app_project/pages/library_page.dart';
import 'package:melodify_app_project/pages/personal_page.dart';
import 'package:melodify_app_project/pages/premium_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:provider/provider.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

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

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const LibraryPage(),
    const PremiumPage(),
    const PersonnalPage(),
  ];

  // Assuming _myValueNotifier is a ValueNotifier or ChangeNotifier
  final ValueNotifier<int> _myValueNotifier = ValueNotifier<int>(0);
  // Other variables and methods...

  @override
  void initState() {
    super.initState();
    // Initialize your listeners here
    _myValueNotifier.addListener(_listener);
  }

  @override
  void dispose() {
    // Clean up your listeners here
    _myValueNotifier.removeListener(_listener);
    _myValueNotifier.dispose(); // Dispose of the notifier if needed
    super.dispose();
  }

  void _listener() {
    // Handle updates from _myValueNotifier here
    if (mounted) {
      setState(() {
        // Update your state variables here
        // Example: _myStateVariable = _myValueNotifier.value;
      });
    }
  }

  void navigateToPage(int index) {
    if (_selectedIndex == index) {
      // Pop to the first route if already on the selected page
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      // Navigate to the selected page
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  String _currentSongTitle = '';
  String _currentArtistName = '';
  int _currentDuration = 0;

  void updatePlayingSong(String title, String artist, int duration) {
    setState(() {
      _currentSongTitle = title;
      _currentArtistName = artist;
      _currentDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      //Ẩn hiện cũng như chỉ muốn hiện cái bài lên đây
                      Consumer<CurrentPlayingSong>(
                        builder: (context, currentSong, child) {
                          return Visibility(
                            visible: currentSong.isVisible,
                            child: PlayingBar(
                              duration: currentSong.duration,
                              artistName: currentSong.artist,
                              musicName: currentSong.title,
                              musicImg: currentSong.img,
                            ),
                          );
                        },
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
