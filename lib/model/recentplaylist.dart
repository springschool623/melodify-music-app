import 'package:flutter/material.dart';
import 'package:melodify_app_project/model/recentmodel.dart';

class RecentPlaylistProvider extends ChangeNotifier {
  final List<RecentMixSong> _playlist = [
    //Playlist 1
    RecentMixSong(
      name: 'Negav Radio', 
      imgPath: 'assets/images/mix1.png'
    ),

    //Playlist 2
    RecentMixSong(
      name: 'Tuyển tập nhạc buồn', 
      imgPath: 'assets/images/mix2.png'
    ),

    //Playlist 3
    RecentMixSong(
      name: 'Daily Mix 2', 
      imgPath: 'assets/images/mix3.png'
    ),

    //Playlist 4
    RecentMixSong(
      name: 'Daily Mix 1', 
      imgPath: 'assets/images/mix4.png'
    ),

    //Playlist 5
    RecentMixSong(
      name: 'Daily Mix 6', 
      imgPath: 'assets/images/mix5.png'
    ),

    //Playlist 6
    RecentMixSong(
      name: 'Thoải Mái Gác Chân Lên', 
      imgPath: 'assets/images/mix6.png'
    ),

    //Playlist 7
    RecentMixSong(
      name: 'Orange Radio', 
      imgPath: 'assets/images/mix7.png'
    ),

    //Playlist 8
    RecentMixSong(
      name: 'Buitruonglinh', 
      imgPath: 'assets/images/mix8.png'
    ),
  ];

  //current playlist playing index
  int? _currentPlaylistIndex;

  /*
  GETTER
  */
  List<RecentMixSong> get playlist => _playlist;
  int? get currentPlaylistIndex => _currentPlaylistIndex;

  /*
  GETTER
  */
}